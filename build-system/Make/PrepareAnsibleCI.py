"""Create disposable, self-signed build material for a re-signable Ansible IPA.

These profiles are build inputs, not Apple-issued distribution profiles. All
private material stays in the runner's temporary directory.
"""
import argparse
import datetime
import os
from pathlib import Path
import plistlib
import secrets
import subprocess
import uuid

from BuildConfiguration import build_configuration_from_json


PROFILE_SUFFIXES = {
    'Iosapp': '',
    'Share': '.Share',
    'Widget': '.Widget',
    'NotificationService': '.NotificationService',
    'NotificationContent': '.NotificationContent',
    'Intents': '.SiriIntents',
    'BroadcastUpload': '.BroadcastUpload',
    'WatchApp': '.watchkitapp',
    'WatchExtension': '.watchkitapp.watchkitextension',
}


def run(*args):
    subprocess.run(args, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)


def prepare(configuration_path, destination):
    config = build_configuration_from_json(configuration_path)
    if (config.bundle_id != 'su.ansible.messenger' or
            config.team_id != 'ANSIBLECI0' or
            str(config.api_id) != '21000003' or
            config.app_specific_url_scheme != 'as' or
            config.is_appstore_build != 'false' or
            config.enable_icloud or config.enable_siri):
        raise ValueError('Unexpected Ansible re-signable release configuration')
    if len(config.api_hash) != 32 or any(c not in '0123456789abcdef' for c in config.api_hash.lower()):
        raise ValueError('ANSIBLE_IOS_API_HASH must be a 32-character hexadecimal hash')
    destination = Path(destination)
    destination.mkdir(mode=0o700, parents=True, exist_ok=False)
    certs = destination / 'certs'
    profiles = destination / 'profiles'
    certs.mkdir(mode=0o700)
    profiles.mkdir(mode=0o700)
    key, pem = certs / 'private.pem', certs / 'certificate.pem'
    openssl_config = certs / 'openssl.cnf'
    previous_umask = os.umask(0o077)
    try:
        openssl_config.write_text(
            '[req]\ndistinguished_name = dn\nx509_extensions = signing\nprompt = no\n'
            '[dn]\nCN = Ansible CI Re-sign Required\nOU = ' + config.team_id + '\nO = Ansible CI\n'
            '[signing]\nbasicConstraints = critical,CA:FALSE\n'
            'keyUsage = critical,digitalSignature\nextendedKeyUsage = codeSigning\n')
        password_file = certs / 'password.txt'
        password_file.write_text(secrets.token_hex(32))
        run('openssl', 'req', '-x509', '-newkey', 'rsa:2048', '-nodes',
            '-keyout', str(key), '-out', str(pem), '-days', '30',
            '-config', str(openssl_config))
        # Use an explicit nonempty password: Security.framework rejects empty
        # passwords on PKCS#12 files exported by the current macOS LibreSSL.
        run('/usr/bin/openssl', 'pkcs12', '-export', '-inkey', str(key),
            '-in', str(pem), '-out', str(certs / 'SelfSigned.p12'),
            '-passout', 'file:' + str(password_file),
            '-keypbe', 'PBE-SHA1-3DES', '-certpbe', 'PBE-SHA1-3DES',
            '-macalg', 'sha1', '-nomaciter')
        run('openssl', 'x509', '-in', str(pem), '-outform', 'DER', '-out', str(certs / 'Public.cer'))
        certificate = (certs / 'Public.cer').read_bytes()
        now = datetime.datetime.now(datetime.timezone.utc).replace(tzinfo=None)
        for name, suffix in PROFILE_SUFFIXES.items():
            identifier = config.team_id + '.' + config.bundle_id + suffix
            entitlements = {
                'application-identifier': identifier,
                'com.apple.developer.team-identifier': config.team_id,
                'com.apple.security.application-groups': ['group.' + config.bundle_id],
                'keychain-access-groups': [config.team_id + '.*'],
                'get-task-allow': False,
            }
            if not suffix:
                entitlements['aps-environment'] = 'production'
            profile = {
                'AppIDName': 'Ansible CI ' + name,
                'Name': 'Ansible CI Re-sign Required ' + name,
                'UUID': str(uuid.uuid4()).upper(),
                'Version': 1,
                'Platform': ['watchOS' if name.startswith('Watch') else 'iOS'],
                'ApplicationIdentifierPrefix': [config.team_id],
                'TeamIdentifier': [config.team_id],
                'TeamName': 'Ansible CI (not an Apple Developer team)',
                'CreationDate': now,
                'ExpirationDate': now + datetime.timedelta(days=30),
                'TimeToLive': 30,
                'ProvisionsAllDevices': True,
                'DeveloperCertificates': [certificate],
                'Entitlements': entitlements,
            }
            source = profiles / (name + '.plist')
            source.write_bytes(plistlib.dumps(profile))
            run('openssl', 'smime', '-sign', '-nodetach', '-binary',
                '-signer', str(pem), '-inkey', str(key), '-in', str(source),
                '-outform', 'DER', '-out', str(profiles / (name + '.mobileprovision')))
            source.unlink()
    finally:
        key.unlink(missing_ok=True)
        pem.unlink(missing_ok=True)
        openssl_config.unlink(missing_ok=True)
        os.umask(previous_umask)
    print('Prepared Ansible CI profiles for ' + config.bundle_id + '; re-signing required')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--configuration', required=True)
    parser.add_argument('--destination', required=True)
    args = parser.parse_args()
    prepare(args.configuration, args.destination)
