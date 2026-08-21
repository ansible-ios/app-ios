# Changelog

All notable changes to BeHappy for iOS will be documented in this
file.

This changelog covers only modifications made by the BeHappy iOS
Authors. For upstream Telegram-iOS history, refer to the upstream
repository.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Initial fork from upstream Telegram-iOS.
- MVSy 1.0 protocol layer (replaces MTProto 2.0).
- Connection to BeHappy backend (`mvsy.ansible.su`).
- BeHappy branding: app name, icon, splash screen, color scheme.

### Removed
- Telegram-specific branding (name, logo, About text).
- Telegram Premium UI surfaces.
- Telegram Stars integration.
- Fragment / TON wallet integration.
- Sponsored messages.
- Telegram-specific deep links (`tg://`, `t.me`).

### Changed
- Default DC list points to BeHappy servers.
- Deep links: domain `asme.su` (server `me_url_prefix`) and URL scheme `as://` (registered schemes `ansible`, `as`, `tonsite`); upstream Telegram link domains and schemes are no longer recognised as internal. Login QR codes are `as://login?token=`, shared with app-desktop and Android.
- Animated stickers use the Ansible wire format: MIME `application/x-ansible-sticker`, file name `sticker.ass` (matches backend, app-desktop and web).
- App bundle identifier renamed.
- Help and support links point to BeHappy resources.

[Unreleased]: https://github.com/behappy-ios/Telegram-iOS/compare/v0.0.0...HEAD
