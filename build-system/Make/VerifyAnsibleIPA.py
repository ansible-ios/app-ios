"""Check the actual release payload before publishing it. Never print API credentials."""
import argparse
import datetime
import os
from pathlib import Path
import plistlib
import subprocess
import tempfile
import zipfile


def verify(ipa):
    expected_hash = os.environ.get('ANSIBLE_IOS_API_HASH', '')
    if not expected_hash:
        raise ValueError('Set ANSIBLE_IOS_API_HASH to verify the embedded API credential')
    with tempfile.TemporaryDirectory() as temporary:
        with zipfile.ZipFile(ipa) as archive:
            archive.extractall(temporary)
        apps = list((Path(temporary) / 'Payload').glob('*.app'))
        if len(apps) != 1:
            raise ValueError('Expected one application in the release IPA')
        app = apps[0]
        info = plistlib.loads((app / 'Info.plist').read_bytes())
        if info['CFBundleIdentifier'] != 'su.ansible.messenger':
            raise ValueError('Unexpected release bundle ID')
        schemes = {scheme for item in info.get('CFBundleURLTypes', [])
                   for scheme in item.get('CFBundleURLSchemes', [])}
        if 'as' not in schemes:
            raise ValueError('Ansible URL scheme missing from release')
        subprocess.run(['codesign', '--verify', '--deep', '--strict', str(app)], check=True)
        result = subprocess.run(['codesign', '-d', '--entitlements', ':-', str(app)],
                                check=True, capture_output=True)
        entitlements = plistlib.loads(result.stdout)
        if entitlements.get('application-identifier') != 'ANSIBLECI0.su.ansible.messenger':
            raise ValueError('Unexpected release application identifier')
        if entitlements.get('com.apple.security.application-groups') != ['group.su.ansible.messenger']:
            raise ValueError('Unexpected release app group')
        if any('telegram' in str(value).lower() or 'telegra.' in str(value).lower()
               for value in entitlements.values()):
            raise ValueError('Telegram entitlement found in Ansible release')
        profile_data = subprocess.run(
            ['openssl', 'smime', '-verify', '-inform', 'der', '-noverify',
             '-in', str(app / 'embedded.mobileprovision')],
            check=True, capture_output=True).stdout
        profile = plistlib.loads(profile_data)
        if profile['ExpirationDate'] <= datetime.datetime.now(datetime.timezone.utc).replace(tzinfo=None):
            raise ValueError('Expired release provisioning profile')
        for key in ('application-identifier', 'com.apple.security.application-groups'):
            if profile['Entitlements'].get(key) != entitlements.get(key):
                raise ValueError('Release entitlements do not match provisioning profile')
        certificate_prefix = str(Path(temporary) / 'signing-certificate-')
        subprocess.run(['codesign', '-d', '--extract-certificates=' + certificate_prefix, str(app)],
                       check=True, capture_output=True)
        if Path(certificate_prefix + '0').read_bytes() not in profile['DeveloperCertificates']:
            raise ValueError('Release signature does not match provisioning certificate')
        # BuildConfig is statically linked into an app framework. Inspect Mach-O
        # payloads instead of trusting the source configuration used by the job.
        found_hash = False
        for path in app.rglob('*'):
            if not path.is_file():
                continue
            with path.open('rb') as binary:
                magic = binary.read(4)
                if magic in (b'\xcf\xfa\xed\xfe', b'\xfe\xed\xfa\xcf', b'\xca\xfe\xba\xbe'):
                    found_hash = found_hash or expected_hash.encode() in binary.read()
        if not found_hash:
            raise ValueError('System iOS API credential missing from release binaries')
    print('Verified Ansible IPA: bundle ID, URL scheme, app group, signature and embedded API credential')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('ipa')
    verify(parser.parse_args().ipa)
