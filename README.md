# Ansible для iOS

Клиент мессенджера Ansible для iPhone и iPad. Это независимый **форк Telegram для iOS**. Приложение использует инфраструктуру и учётные записи Ansible. [Исходный проект Telegram](https://github.com/TelegramMessenger/Telegram-iOS).

## Сборка на Mac

Сборка использует Xcode и Bazel. Для начала клонируйте репозиторий вместе с зависимостями:

```sh
git clone --recursive https://github.com/ansible-ios/app-ios.git
cd app-ios
```

- Перед установкой инструментов сверьте версии macOS, Xcode и Bazel с [версией конфигурации в репозитории](versions.json).
- Параметры приложения находятся в [конфигурации Ansible](build-system/ansible-configuration.json). Сборкой управляет [Make.py](build-system/Make/Make.py).
- Для установки подписанного IPA на устройство нужны сертификат и профиль подготовки. Последовательность подготовки подписи, сборки и проверки IPA приведена в [сценарии CI](.github/workflows/build.yml).

## Лицензия и авторство

Авторы Ansible распространяют свои изменения по GNU GPL версии 2 или более поздней. В исходном проекте Telegram для iOS отсутствует единый корневой файл лицензии. Для заимствованных файлов и подмодулей действуют соответствующие им условия. Происхождение кода и позиция авторов форка подробно изложены в [NOTICE](NOTICE).

[Сайт Ansible](https://ansible.su) · [История изменений](CHANGELOG.md) · [Выпуски для iOS](https://github.com/ansible-ios/app-ios/releases)
