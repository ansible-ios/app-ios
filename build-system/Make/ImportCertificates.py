import os
import sys
import argparse
import subprocess
import shlex

from BuildEnvironment import run_executable_with_output

def import_certificates(certificatesPath, password_file=None, keychain_path='temp.keychain'):
    if not os.path.exists(certificatesPath):
        print('{} does not exist'.format(certificatesPath))
        sys.exit(1)

    keychain_name = keychain_path
    keychain_password = 'secret'
    certificate_password = ''
    if password_file is not None:
        with open(password_file) as file:
            certificate_password = file.read().strip()

    existing_keychains = run_executable_with_output('security', arguments=['list-keychains'], check_result=True)
    if keychain_name in existing_keychains:
        # The keychain name is required. Without it `security` fails with
        # "SecKeychainDelete: The specified keychain is not a valid keychain file",
        # which only happens on a second build inside one VM -- unreachable while every
        # build got a fresh ephemeral VM, and hit on every reuse of a persistent one.
        run_executable_with_output('security', arguments=['delete-keychain', keychain_name], check_result=True)

    run_executable_with_output('security', arguments=[
        'create-keychain',
        '-p',
        keychain_password,
        keychain_name
    ], check_result=True)

    existing_keychains = run_executable_with_output('security', arguments=['list-keychains', '-d', 'user'])
    existing_keychains = shlex.split(existing_keychains)

    run_executable_with_output('security', arguments=[
        'list-keychains',
        '-d',
        'user',
        '-s',
        keychain_name,
    ] + [path for path in existing_keychains if path != keychain_name], check_result=True)

    run_executable_with_output('security', arguments=['set-keychain-settings', keychain_name])
    run_executable_with_output('security', arguments=['unlock-keychain', '-p', keychain_password, keychain_name])

    for file_name in sorted(os.listdir(certificatesPath)):
        file_path = certificatesPath + '/' + file_name
        if file_path.endswith('.p12') or file_path.endswith('.cer'):
            result = subprocess.run(['/usr/bin/security',
                'import',
                file_path,
                '-k',
                keychain_name,
                '-P',
                certificate_password,
                '-T',
                '/usr/bin/codesign',
                '-T',
                '/usr/bin/security'
            ], capture_output=True)
            if result.returncode:
                # Do not include the command line: it contains the PKCS#12 password.
                raise RuntimeError('Certificate import failed for ' + file_name)

    run_executable_with_output('security', arguments=[
        'import',
        'build-system/AppleWWDRCAG3.cer',
        '-k',
        keychain_name,
        '-P',
        '',
        '-T',
        '/usr/bin/codesign',
        '-T',
        '/usr/bin/security'
    ], check_result=False)

    run_executable_with_output('security', arguments=[
        'set-key-partition-list',
        '-S',
        'apple-tool:,apple:',
        '-k',
        keychain_password,
        keychain_name
    ], check_result=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog='build')

    parser.add_argument(
        '--path',
        required=True,
        help='Path to certificates.'
    )
    parser.add_argument('--passwordFile', help='Private file containing the PKCS#12 password.')
    parser.add_argument('--keychainPath', default='temp.keychain', help='Keychain created for this build.')

    if len(sys.argv) < 2:
        parser.print_help()
        sys.exit(1)

    args = parser.parse_args()

    import_certificates(args.path, args.passwordFile, args.keychainPath)
