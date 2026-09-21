# Ansible for iOS

iOS client for the [Ansible](https://ansible.su) messaging service.

> **This project is a fork of [Telegram for iOS](https://github.com/TelegramMessenger/Telegram-iOS).**
> We are grateful to the Telegram-iOS contributors for their work —
> without it this fork would not exist.
>
> **Important:** the upstream Telegram-iOS repository does not contain
> a top-level LICENSE file. This fork is created in good-faith reliance
> on the permissions implied by the upstream README and is distributed
> under GPL v2 (or later) by the fork authors. See [NOTICE](NOTICE) for
> the full discussion of the upstream license situation.
>
> Ansible for iOS is **not affiliated with, endorsed by, or sponsored
> by Telegram FZ-LLC**. It connects to Ansible servers, not Telegram
> servers, and cannot be used to access Telegram accounts.

[![Upstream](https://img.shields.io/badge/forked%20from-Telegram--iOS-orange.svg)](https://github.com/TelegramMessenger/Telegram-iOS)

---

## What this is

Ansible for iOS is the official iOS client for the Ansible messenger.
It is built on top of the Telegram-iOS codebase, with the following
high-level modifications:

- Networking layer rewritten to use the **MVSy 1.0** protocol and
  connect to Ansible backend servers (instead of MTProto 2.0 / Telegram
  DCs).
- Branding, visual identity, and product naming replaced throughout.
- Telegram-specific features removed where not applicable to Ansible
  (e.g., Telegram Premium subscriptions, Telegram Stars, Fragment
  integration, sponsored messages).
- Additional features added that are unique to Ansible.

The complete list of changes is tracked in [`CHANGELOG.md`](CHANGELOG.md).

## Compliance with upstream README requirements

The upstream Telegram-iOS README requests the following from forks. We
comply as follows:

| Upstream request | Status in this fork |
|---|---|
| Obtain your own api_id | N/A — Ansible uses MVSy 1.0, not MTProto |
| Don't use the name "Telegram" | ✅ Rebranded to Ansible |
| Don't use Telegram's logo | ✅ Independent Ansible logo |
| Follow security guidelines | ✅ Inherited from upstream |
| Publish your code | ✅ This repository is public |

## Relationship to upstream

| | Telegram for iOS | Ansible for iOS |
|---|---|---|
| Upstream LICENSE file | Not present | (See NOTICE — fork author license: GPL v2+) |
| Backend | Telegram DCs | Ansible servers (`mvsy.ansible.su`) |
| Protocol | MTProto 2.0 | MVSy 1.0 |
| Trademarks | Telegram | Ansible |
| Account compatibility | Telegram accounts | Ansible accounts (separate system) |
| Source repository | [TelegramMessenger/Telegram-iOS](https://github.com/TelegramMessenger/Telegram-iOS) | [Ansible-ios/Telegram-iOS](https://github.com/Ansible-ios/Telegram-iOS) |

We do **not** merge updates from upstream automatically. The fork is
independently maintained.

## Building from source

The build process is unchanged from upstream. Refer to the upstream
README's compilation instructions; substitute the Ansible backend
endpoint for the Telegram DC list in the configuration step.

```sh
git clone --recursive -j8 https://github.com/Ansible-ios/Telegram-iOS.git
```

Then follow the upstream Xcode setup, configuration, and project
generation steps.

## License

See the [NOTICE](NOTICE) file for a complete discussion of the upstream
license situation and the fork-author license.

For modifications introduced by the Ansible iOS Authors, the applicable
license is **GNU General Public License v2 (or any later version)**.

By contributing to this repository, you agree that your contributions
will be licensed under the same terms.

## Trademarks

"Telegram" is a registered trademark of Telegram FZ-LLC. It is used in
this README and in source code comments solely to identify the upstream
project from which this fork is derived. It is **not** used as a
trademark of this product.

"Ansible" is a trademark of the Ansible iOS Authors.

## Contact

- General: <https://ansible.su>
- Source code questions: open an issue on this repository
- License compliance / DMCA: <legal@ansible.su>
