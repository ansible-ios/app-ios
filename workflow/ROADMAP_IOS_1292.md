# Ansible iOS → upstream Telegram-iOS 12.9.2

Branch `12.9.2` of `ansible-ios/app-ios`, six commits on top of `master`.
Method: **clean start** — upstream 12.9.2 verbatim, then the fork's mechanical
transformation re-run by script, then the fork's real delta carried as a
three-way merge. Same shape as the desktop 7.2.8 and Android 12.10.1 moves.

## Bases, pinned by measurement

| | upstream commit | app | xcode | API layer |
|---|---|---|---|---|
| previous base (`b4b3bc23`) | `be6c32ef9c2594248da00f0510803c936d256a3a` (2026-04-07 "Trigger build") | 12.6.2 | 26.4 | 224 |
| new base | `4643a28ee1aa` (2026-07-17 "Bump version") | 12.9.2 | 26.2 | **228** |

Both were established by comparing every blob against the GitHub trees API, not
by trusting `versions.json`:

* The old base matches `be6c32ef` for **all 28477 blobs** except `buildbox/`
  (15 files the importer dropped) and 159 files that differ only by CRLF→LF
  normalisation at import.
* The supplied archive `_archive/1/Telegram-iOS-master` matches `4643a28ee1aa`
  for every source file; the only extras are two markdown docs added upstream on
  a side branch (`6d37e5003ae4`) and the same 159 CRLF files.

**Xcode 26.4 was never our choice.** `versions.json` had not been edited since
the import. `be6c32ef` genuinely carried 26.4, and the very next upstream commit,
`d2293b8e0944` "Xcode 26.4 build crashes on iOS 15/16", reverted to 26.2. The
fork froze one commit before that fix. 12.9.2 ships 26.2, so
`--overrideXcodeVersion` is no longer needed on a 26.2 Mac.

**Layer 228 is safe.** `bh_mvsy_tl/src/registry/tl_cid.erl` →
`layers() -> [224, 225, 227, 228, 229]`. Desktop already runs 229, web runs 228.

## Why not a merge

The fork's delta against its base was 8019 files, of which **6462 were renames**
(4603 pure path moves). Upstream changed 3728 files. Files touched by *both*:
**1542** — and on our side almost every one of those is nothing but the
`Telegram*` → `Iosapp*` rename. A merge would have spent the entire effort on
conflicts that carry no information.

Instead the rename was re-derived as a script and applied to **both** sides, so
it cancels out of the merge base. Applied to the old base it shrinks the fork
delta from 8019 files to **469**. That 469 is the fork's real work, and it merged
onto 12.9.2 with **5 conflicts**.

## The transformation (`workflow/transform/`)

`rules.py` holds the whole ruleset; `build_tree.py` applies it to a git tree and
writes the result as a new tree without touching a worktree; `xform.py` is the
harness that compares the result blob-for-blob against a target tree. Re-run it
for the next upstream bump.

**Paths.** Root `Telegram/` → `iosapp/`, and beneath it `Telegram-iOS/` →
`Sources/`. Every other path component starting with `Telegram` → `Iosapp`
(covers the 17 `submodules/Telegram*` modules — unchanged in count at 12.9.2 —
plus `Tests/TelegramCoreBuildTest`, `TelegramEngine/`, and file basenames).
`*.tgs` → `*.ass` (189 files at 12.9.2, was 186).

**Content.** Token `Telegram` → `Iosapp`, plus the lower-cased flatbuffers
accessors (`.telegrammediafile…` → `.iosappmediafile…`). Wire values, applied
everywhere: `tg://` → `as://`, `t.me` → `asme.su`, `"telegram.me"` →
`"www.asme.su"`, `application/x-tgsticker` → `application/x-ansible-sticker`,
`x-tgstoryboard[map]` → `x-ansible-storyboard[map]`, and the `.tgs` loader forms
(`ofType:`/`withExtension:`/`".tgs"`).

**🚨 Negative rules — these break things if a future sweep forgets them:**

* The mini-app / game JS bridge names are a wire contract with every bot web-app:
  `TelegramWebviewProxy`, `TelegramWebviewProxyProto`, `TelegramGameProxy`,
  `window.Telegram.` stay as upstream names (fork commit `9024068d`). 12.9.2 adds
  more of them in `WebAppWebView.swift`. 19 occurrences must survive.
* The pasteboard UTI `private.telegramtext` is a wire value, not a brand word.
* The Lottie JSON key `"tgs"` is **not** the file extension — leave it.
* `x-tgwallpattern`, `x-tgtheme-*`, the Postbox key `"tg"`, the Tajik ISO code
  `"tg"`, `telegra.ph`, `fragment.com` and `telegram.org` stay upstream.
* Not renamed: docs, `.github/`, `third-party/`, every `*.lproj`, `*.plist`,
  `*.xcconfig`, `*.strings`, `build-system/Make*` (its target-name mapping is
  bespoke), and the `Images.xcassets/Chat/Context Menu/Telegram.imageset` asset.

**🚨 www comes first.** `baseIosappMePaths = ["www.asme.su", "asme.su"]` — the
subdomain-collapsing branch in `UrlHandling.resolveUrlImpl` returns on the first
match, so with the other order `https://www.asme.su/durov` collapses to
`asme.su/www/durov` and resolves a peer named `www`.

## The five merge conflicts

| file | resolution |
|---|---|
| `.gitignore` | union — upstream's new entries plus our `*.LSP.json` |
| `DataAndStorageSettingsController.swift` | upstream deleted the `defaultWebBrowser` block; take upstream |
| `WebBrowserSettingsController.swift` | upstream's new signature with our renamed strings key |
| `UrlHandling.swift` | keep `["www.asme.su", "asme.su"]`; drop the `telegram.dog` upstream re-added; **empty** upstream's new t.me web-client short-link host list (`a./k./z.t.me`) — we run no such hosts, so `isIosappWebShortLink` never matches |
| `LegacyDataImport.swift` | module deleted upstream; our only change was the legacy Telegram keychain name |

## Submodules

Upstream moved exactly two pins between 12.6.2 and 12.9.2; both are now ours:

* `tgcalls` `8099768559ed` → `e3069322a3d1e16ecb11a5e302242e59ddd7f09e`.
  **Not optional:** 12.9.2's `MODULE.bazel` adds rules_go/gazelle and reads
  `//submodules/TgVoipWebrtc/tgcalls/tools/go_sfu:go.mod`, absent at the old pin —
  bazel fails at module resolution before compiling anything.
* `webrtc` `add1a8440963` → `3817e906cb6c22ec9cc62023b073e1a668d9cb33`, and our
  patch is **dropped**. `add1a8440963` (branch `fix/ffmpeg7-reordered-opaque`) sat
  on `e3dfe44d1aea`, five commits *behind* the 12.6.2 upstream pin, and commented
  `reordered_opaque` out, losing the per-frame timestamp. Upstream's new pin fixes
  the same FFmpeg 7 removal properly (`h264_decoder_impl.cc`: "Pass timestamp via
  AVPacket::pts"). Fork commit `f6c56446` is obsolete.

🚨 Neither SHA was reachable from a branch in our forks (`ansible-ios/tgcalls`
master is 261 commits behind, `ansible-ios/webrtc` `telegram` is 4 behind), which
is the same landmine that broke `submodule update` when `a856fe0f` pinned a
dangling adlib SHA. Branch **`ansible-1292`** was pushed in both forks at those
commits. The other 10 pins are unchanged; `third-party/td` stays on
`asdlib/adlib` `60040de5` (our DC seeds + rotated RSA live there).

## What else this branch fixes

* **Russian actually ships.** The 18751-line ru pack had been in the repo since
  `15cad4bf` but `iosapp/BUILD` listed `ru` in `empty_languages`, whose genrule is
  `cmd = "touch $(OUTS)"`, and `AppStringResources` took en.lproj plus those 18
  generated **empty** files. Russian came from the server langpack alone. Now
  `Sources/ru.lproj/Localizable.strings` is in `AppStringResources` and 27 keys
  were renamed `Telegram*` → `Iosapp*` to match the code — exactly the 27 whose
  `Iosapp` form exists in 12.9.2's en.lproj. The other 37 ru keys containing the
  word Telegram keep upstream key names; only their values are brand text.
  Coverage: 12365 of 15018 ru keys live, 2653 orphans of deleted upstream keys
  (harmless), 385 upstream keys with no ru yet (fall back to English).
* **The app-target rename is finished.** CI globbed `bin/Telegram/Telegram.ipa`
  while `Make.py` had been writing `iosapp.ipa` since May; RemoteBuild/TartBuild
  looked for `Telegram.ipa`; the SPM generators read
  `bazel-bin/Telegram/spm_build_root_modules.json`; and
  `BuildConfiguration.copy_profiles_from_directory` mapped the main bundle id to
  `Telegram.mobileprovision`, already renamed to `Iosapp.mobileprovision`.
* **Siri/CallKit handles.** `488224da` converted the readers to `hasPrefix("as")`
  but only 10 of 15 sites; five generators still wrote `"tg\(id)"`, so every
  donated intent produced a handle the app refused. Readers strip exactly two
  characters, so `"as"` is the right width.

## Open, deliberately not done

* **`Telegram/WatchApp/` — 954 of the 1730 new upstream files.** A whole in-repo
  watchOS app with vendored RLottie/libwebp and a TDLib shim. It stays **off**
  (`bool_flag embedWatchApp` default False, `tags = ["manual"]`) and was left
  unbranded. Turning it on is a separate project: it is a second brand surface
  and a second TL client.
* **Passkeys (new in 12.9.2).** The relying-party id is server-driven (`rpId`
  from the passkey challenge), but `PasskeysScreen.swift` hardcodes
  `"telegram.org"` in `reportUnknownPublicKeyCredential`, and the entitlements
  still carry `webcredentials:telegram.org` alongside `webcredentials:asme.su`.
  Pointing these at `ansible.su` requires the backend to issue that RP id first.
* **`build-system/ansible-configuration.json` is still not wired in.** CI keeps
  using `appstore-configuration.json` (api_id 8, `ph.telegra.Telegraph`).
* **Universal links** still need an AASA file on `asme.su`; `applinks:asme.su` is
  declared but unserved.
* Not built and not run against the backend — see below.

## Before calling it done

1. `git submodule update --init --recursive` on a **fresh clone** — that is what
   the dangling-pin class of bug breaks, and it cannot be seen in this worktree.
2. Build on the Mac: `python3 build-system/Make/Make.py build --configuration=release_arm64`,
   or `./run-on-sim.sh` for the simulator. Xcode 26.2 now matches `versions.json`,
   so no `--overrideXcodeVersion`.
3. If anything is added to a bazel `deps` list, regenerate the Xcode project —
   `rules_xcodeproj` will otherwise report `No such module`.
4. 🚨 Verify on the **server**, not from the client's own claims: the new session
   must show `client_layer = 228` in `auth_keys`, and `update_log` must be writing
   rows at 228. After reinstalling, `xcrun simctl erase <udid>` — a saved
   address-set in the App Group postbox overrides the seed
   (`MTContext.m:956-966`).
5. Check animated stickers, gifts and emoji statuses render: that is the
   `application/x-ansible-sticker` path, and it was the symptom that looked like a
   backend bug in August.
