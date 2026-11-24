# Ansible для iOS

> [!NOTE]
> **Происхождение кода.** Форк [TelegramMessenger/Telegram-iOS](https://github.com/TelegramMessenger/Telegram-iOS), который сопровождает проект Ansible Messenger. Сведения об авторах и лицензиях приведены в исходной документации.

Клиент мессенджера Ansible для iPhone и iPad. Это независимый **форк Telegram для iOS**. Приложение использует инфраструктуру и учётные записи Ansible. [Исходный проект Telegram](https://github.com/TelegramMessenger/Telegram-iOS).

## Сборка на Mac

Сборка использует Xcode и Bazel. Для начала клонируйте репозиторий вместе с зависимостями:

```sh
git clone --recursive https://github.com/ansible-ios/as-ios.git
cd as-ios
```

- Перед установкой инструментов сверьте версии macOS, Xcode и Bazel с [версией конфигурации в репозитории](versions.json).
- Параметры приложения находятся в [конфигурации Ansible](build-system/ansible-configuration.json). Сборкой управляет [Make.py](build-system/Make/Make.py).
- Для установки подписанного IPA на устройство нужны сертификат и профиль подготовки. Последовательность подготовки подписи, сборки и проверки IPA приведена в [сценарии CI](.github/workflows/build.yml).

## Лицензия и авторство

Авторы Ansible распространяют свои изменения по GNU GPL версии 2 или более поздней. В исходном проекте Telegram для iOS отсутствует единый корневой файл лицензии. Для заимствованных файлов и подмодулей действуют соответствующие им условия. Происхождение кода и позиция авторов форка подробно изложены в [NOTICE](NOTICE).

[Сайт Ansible](https://ansible.su) · [История изменений](CHANGELOG.md) · [Выпуски для iOS](https://github.com/ansible-ios/as-ios/releases)

## Происхождение модулей организации

| Модуль Ansible | Исходный проект |
| --- | --- |
| [as-rlottie](https://github.com/ansible-ios/as-rlottie) | [github.com/ali-fareed/rlottie](https://github.com/ali-fareed/rlottie) |
| [as-rules-apple](https://github.com/ansible-ios/as-rules-apple) | [github.com/ali-fareed/rules_apple](https://github.com/ali-fareed/rules_apple) |
| [as-rules-swift](https://github.com/ansible-ios/as-rules-swift) | [github.com/bazelbuild/rules_swift](https://github.com/bazelbuild/rules_swift) |
| [as-apple-support](https://github.com/ansible-ios/as-apple-support) | [github.com/bazelbuild/apple_support](https://github.com/bazelbuild/apple_support) |
| [as-calls](https://github.com/ansible-ios/as-calls) | [github.com/ali-fareed/tgcalls](https://github.com/ali-fareed/tgcalls) |
| [as-libvpx](https://github.com/ansible-ios/as-libvpx) | [github.com/webmproject/libvpx](https://github.com/webmproject/libvpx) |
| [as-webrtc](https://github.com/ansible-ios/as-webrtc) | [github.com/ali-fareed/webrtc](https://github.com/ali-fareed/webrtc) |
| [as-rules-xcodeproj](https://github.com/ansible-ios/as-rules-xcodeproj) | [github.com/MobileNativeFoundation/rules_xcodeproj](https://github.com/MobileNativeFoundation/rules_xcodeproj) |
| [as-dav1d](https://github.com/ansible-ios/as-dav1d) | [github.com/ali-fareed/dav1d](https://github.com/ali-fareed/dav1d) |
| [as-tlottie](https://github.com/ansible-ios/as-tlottie) | [github.com/dkaraush/tlottie](https://github.com/dkaraush/tlottie) |
| [as-mtproto-engine](https://github.com/ansible-ios/as-mtproto-engine) | [github.com/TelegramMessenger/mtproto-engine](https://github.com/TelegramMessenger/mtproto-engine) |
