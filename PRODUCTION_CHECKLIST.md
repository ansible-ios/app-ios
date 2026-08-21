# Ansible iOS — Production Checklist

Текущая конфигурация настроена для **development** с Personal Team.
Для выпуска в App Store нужно выполнить следующие шаги.

---

## 1. Apple Developer Account ($99/год)
- Зарегистрировать платный Apple Developer Program
- Или использовать существующий (Digital Fortress LLC — C67CF9S4VU)

## 2. variables.bzl — переключить на production
Файл: `build-input/configuration-repository/variables.bzl`

```python
# БЫЛО (development):
telegram_use_xcode_managed_codesigning = True
telegram_team_id = "D24RCNW45L"              # Personal Team
telegram_is_internal_build = "true"
telegram_is_appstore_build = "false"
telegram_aps_environment = ""
telegram_enable_watch = False

# НУЖНО (production):
telegram_use_xcode_managed_codesigning = False
telegram_team_id = "ВАША_TEAM_ID"            # Платный Developer аккаунт
telegram_is_internal_build = "false"
telegram_is_appstore_build = "true"
telegram_appstore_id = "ВАША_APP_ID"         # ID из App Store Connect
telegram_aps_environment = "production"
telegram_enable_watch = True                  # опционально
```

## 3. Telegram/BUILD — включить extensions обратно
```python
# БЫЛО (development):
bool_flag(name = "disableExtensions", build_setting_default = True)

# НУЖНО (production):
bool_flag(name = "disableExtensions", build_setting_default = False)
```

## 4. Provisioning Profiles
Создать в Apple Developer Portal для bundle ID `app.behappy.messenger`:
- **App Store** profile для основного приложения
- **Development** profiles для каждого extension:
  - `app.behappy.messenger.Share`
  - `app.behappy.messenger.Widget`
  - `app.behappy.messenger.NotificationService`
  - `app.behappy.messenger.NotificationContent`
  - `app.behappy.messenger.SiriIntents`
  - `app.behappy.messenger.BroadcastUpload`
  - `app.behappy.messenger.watchkitapp` (если Watch включён)
  - `app.behappy.messenger.watchkitapp.watchkitextension`

Положить в `build-input/configuration-repository/provisioning/`

## 5. Capabilities (в Developer Portal для App ID)
Включить для `app.behappy.messenger`:
- [x] Push Notifications
- [x] App Groups (`group.app.behappy.messenger`)
- [ ] Siri (опционально)
- [ ] iCloud (опционально)

## 6. API Credentials
Файл: `build-input/configuration-repository/variables.bzl`
```python
telegram_api_id = "РЕАЛЬНЫЙ_API_ID"    # сейчас "1"
telegram_api_hash = "РЕАЛЬНЫЙ_HASH"    # сейчас "stub"
```

## 7. Пересгенерировать Xcode проект
```bash
build-input/bazel-8.4.2-darwin-arm64 run //Telegram:Telegram_xcodeproj
```

## 8. Собрать и отправить в App Store
```bash
# Или через Xcode: Product → Archive → Distribute App
```

---

## Текущее состояние (development)
- Название: Ansible
- Bundle ID: app.behappy.messenger
- Team: D24RCNW45L (Personal Team)
- Extensions: отключены
- Push Notifications: отключены
- Provisioning: Xcode Managed
- Иконка: DefaultGrey (серая)
- useTempAuthKeys: true
- Сервер: 144.31.238.115:10443
