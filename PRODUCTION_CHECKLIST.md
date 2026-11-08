# Ansible iOS release configuration

GitHub Actions builds `release_arm64` using `build-system/ansible-configuration.json`.
The application bundle ID is `su.ansible.messenger`, its app group is
`group.su.ansible.messenger`, and the primary URL scheme is `as`.

## API configuration

The official iOS API ID is `21000003`. Supply its matching hash through the repository
Actions secret `ANSIBLE_IOS_API_HASH`. The same environment variable is required for
local builds and project generation. Do not commit the hash or print build variables.
An absent secret fails the build before compilation.

## GitHub IPA for re-signing

This lane publishes an IPA for re-signing, not an App Store or TestFlight distribution.
`PrepareAnsibleCI.py` creates a fresh temporary certificate and matching profiles on
every runner. `ANSIBLECI0` is an artificial CI signing identifier, not an Apple Developer
Team ID. Certificate, profiles and PKCS#12 password remain in the runner temporary
directory and are removed after the build. No Telegram signing materials are used.

The release disables the App Store flag, Siri and iCloud. The existing default keeps
extensions disabled; the Watch app is not embedded. The profile carries an APNs
production entitlement for packaging, but a self-signed certificate does not authorize
APNs or installation on a stock device. Installation requires re-signing with a valid
Apple identity and matching capabilities/profiles.

Before publishing, `VerifyAnsibleIPA.py` checks the actual bundle ID, `as` scheme,
app group, code signature, unexpired embedded profile, profile/certificate agreement,
and the system API hash embedded in Mach-O binaries. It never prints that hash.

## Apple distribution

A future Apple distribution lane requires Ansible-owned Apple Developer membership,
registered App IDs and app group, certificates and provisioning profiles for
`su.ansible.messenger` and the extensions being shipped, plus APNs credentials.
Replace the artificial CI Team ID with the actual Ansible Team ID, configure the
App Store Connect application, then enable the intended extensions/capabilities and
validate a signed archive on devices. Telegram Team ID `C67CF9S4VU` is not an Ansible
signing identity and must not be used as one.
