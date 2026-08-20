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
- Deep links use `asme.su` (server `me_url_prefix`); upstream `t.me` / `telegram.me` / `telegram.dog` / `telesco.pe` are no longer treated as internal hosts.
- App bundle identifier renamed.
- Help and support links point to BeHappy resources.

[Unreleased]: https://github.com/behappy-ios/Telegram-iOS/compare/v0.0.0...HEAD
