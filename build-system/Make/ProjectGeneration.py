import json
import os
import shutil

from BuildEnvironment import is_apple_silicon, call_executable, BuildEnvironment


def remove_directory(path):
    if os.path.isdir(path):
        shutil.rmtree(path)

def generate_xcodeproj(build_environment: BuildEnvironment, disable_extensions, disable_provisioning_profiles, include_release, generate_dsym, bazel_app_arguments, target_name):
    if '/' in target_name:
        app_target_spec = target_name.split('/')[0] + '/' + target_name.split('/')[1] + ':' + target_name.split('/')[1]
        app_target = target_name
        app_target_clean = app_target.replace('/', '_')
    else:
        app_target_spec = '{target}:{target}'.format(target=target_name)
        app_target = target_name
        app_target_clean = app_target.replace('/', '_')

    bazel_generate_arguments = [build_environment.bazel_path]

    bazel_generate_arguments += ['run', '//{}_xcodeproj'.format(app_target_spec)]

    if target_name == "iosapp":
        if disable_extensions:
            bazel_generate_arguments += ['--//{}:disableExtensions'.format(app_target)]
        if disable_provisioning_profiles:
            bazel_generate_arguments += ['--//{}:disableProvisioningProfiles'.format(app_target)]
        bazel_generate_arguments += ['--//{}:disableStripping'.format(app_target)]

    project_bazel_arguments = []
    for argument in bazel_app_arguments:
        project_bazel_arguments.append(argument)

    if target_name == "iosapp":
        if disable_extensions:
            project_bazel_arguments += ['--//{}:disableExtensions'.format(app_target)]
        if disable_provisioning_profiles:
            project_bazel_arguments += ['--//{}:disableProvisioningProfiles'.format(app_target)]
        project_bazel_arguments += ['--//{}:disableStripping'.format(app_target)]

    project_bazel_arguments += ['--features=-swift.debug_prefix_map']
    project_bazel_arguments += ['--features=swift.emit_swiftsourceinfo']
    
    xcodeproj_bazelrc = os.path.join(build_environment.base_path, 'xcodeproj.bazelrc')
    if os.path.isfile(xcodeproj_bazelrc):
        os.unlink(xcodeproj_bazelrc)
    with open(xcodeproj_bazelrc, 'w') as file:
        for argument in project_bazel_arguments:
            file.write('build ' + argument + '\n')

    call_executable(bazel_generate_arguments)

    xcodeproj_path = '{}.xcodeproj'.format(app_target_spec.replace(':', '/'))

    # Inject a Pre-action into the scheme that chmods bazel outputs writable and
    # pre-creates framework Modules/<Module>.swiftmodule/ dirs. Without this,
    # Xcode's builtin ProcessInfoPlistFile / Swift copy steps fail because
    # bazel installs framework directories read-only (dr-xr-xr-x), and the copy
    # destinations don't have parent dirs created.
    scheme_path = os.path.join(xcodeproj_path, 'xcshareddata', 'xcschemes', '{}.xcscheme'.format(target_name))
    if os.path.isfile(scheme_path):
        _inject_chmod_preaction(scheme_path, target_name)

    bazel_build_sh = os.path.join(xcodeproj_path, 'rules_xcodeproj', 'bazel', 'bazel_build.sh')
    if os.path.isfile(bazel_build_sh):
        _patch_bazel_build_sh(bazel_build_sh)

    copy_outputs_sh = os.path.join(xcodeproj_path, 'rules_xcodeproj', 'bazel', 'copy_outputs.sh')
    if os.path.isfile(copy_outputs_sh):
        _patch_copy_outputs_sh(copy_outputs_sh)

    return xcodeproj_path


def _patch_copy_outputs_sh(path):
    sentinel = 'macOS 26 / openrsync sometimes ignores --chmod=u+w'
    os.chmod(path, 0o755)
    with open(path, 'r') as f:
        content = f.read()
    if sentinel in content:
        return
    needle = '"$TARGET_BUILD_DIR"\n'
    inject = (
        '"$TARGET_BUILD_DIR"\n\n'
        '      # macOS 26 / openrsync sometimes ignores --chmod=u+w when --perms is set,\n'
        '      # leaving the .app dir read-only. simctl install then fails with EACCES.\n'
        '      chmod -R u+w "$TARGET_BUILD_DIR/$BAZEL_OUTPUTS_PRODUCT_BASENAME" 2>/dev/null || true\n'
    )
    # Only replace the first occurrence (the rsync target_build_dir for product)
    content = content.replace(needle, inject, 1)
    with open(path, 'w') as f:
        f.write(content)


def _patch_bazel_build_sh(path):
    sentinel = '# Workaround: bazel writes framework outputs as read-only'
    os.chmod(path, 0o644)
    with open(path, 'r') as f:
        content = f.read()
    if sentinel in content:
        return
    suffix = '''

# Workaround: bazel writes framework outputs as read-only (dr-xr-xr-x).
# Xcode's builtin copy / ProcessInfoPlistFile phases then fail with
# "Permission denied" and "No such file or directory (2)" (because they
# can't mkdir Modules/ inside the read-only framework). Chmod everything
# writable after bazel finishes, and pre-create the swiftmodule dir tree.
if [ -n "${BUILD_DIR:-}" ]; then
  chmod -R u+w "${BUILD_DIR%/Products}" 2>/dev/null || true
  find "${BUILD_DIR%/Products}" -type d -name "*.framework" 2>/dev/null | while read fw; do
    bn=$(basename "$fw" .framework)
    sm=${bn%Framework}
    mkdir -p "$fw/Modules/${sm}.swiftmodule/Project" 2>/dev/null || true
    chmod -R u+w "$fw" 2>/dev/null || true
  done
fi
'''
    with open(path, 'w') as f:
        f.write(content + suffix)


def _inject_chmod_preaction(scheme_path, target_name):
    sentinel = 'chmod +w + mkdir framework Modules'
    # rules_xcodeproj installs the scheme file as read-only, make it writable first.
    os.chmod(scheme_path, 0o644)
    with open(scheme_path, 'r') as f:
        content = f.read()
    if sentinel in content:
        return
    script_text = (
        'if [ -n &quot;${BUILD_DIR:-}&quot; ]; then '
        'chmod -R u+w &quot;${BUILD_DIR%/Products}&quot; 2&gt;/dev/null; '
        'find &quot;${BUILD_DIR%/Products}&quot; -type d -name &quot;*.framework&quot; 2&gt;/dev/null | while read fw; do '
        'bn=$(basename &quot;$fw&quot; .framework); sm=${bn%Framework}; '
        'mkdir -p &quot;$fw/Modules/${sm}.swiftmodule/Project&quot; 2&gt;/dev/null; '
        'chmod -R u+w &quot;$fw&quot; 2&gt;/dev/null; '
        'done; fi&#10;true&#10;'
    )
    block = (
        '         <ExecutionAction\n'
        '            ActionType = "Xcode.IDEStandardExecutionActionsCore.ExecutionActionType.ShellScriptAction">\n'
        '            <ActionContent\n'
        '               title = "{}"\n'
        '               scriptText = "{}">\n'
        '               <EnvironmentBuildable>\n'
        '                  <BuildableReference\n'
        '                     BuildableIdentifier = "primary"\n'
        '                     BlueprintIdentifier = "0500AAC8C4EF000000000001"\n'
        '                     BuildableName = "{}.app"\n'
        '                     BlueprintName = "{}"\n'
        '                     ReferencedContainer = "container:{}">\n'
        '                  </BuildableReference>\n'
        '               </EnvironmentBuildable>\n'
        '            </ActionContent>\n'
        '         </ExecutionAction>\n'
    ).format(sentinel, script_text, target_name, target_name, os.path.abspath(scheme_path.split('/xcshareddata')[0]))

    # Insert into the FIRST <PreActions> block of BuildAction
    needle = '      </PreActions>\n      <BuildActionEntries>'
    if needle not in content:
        return
    content = content.replace(needle, block + '      </PreActions>\n      <BuildActionEntries>', 1)
    with open(scheme_path, 'w') as f:
        f.write(content)


def generate(build_environment: BuildEnvironment, disable_extensions, disable_provisioning_profiles, include_release, generate_dsym, bazel_app_arguments, target_name) -> str:
    return generate_xcodeproj(build_environment, disable_extensions, disable_provisioning_profiles, include_release, generate_dsym, bazel_app_arguments, target_name)
