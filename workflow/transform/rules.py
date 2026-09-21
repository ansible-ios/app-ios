# -*- coding: utf-8 -*-
"""Ansible iOS fork transformation, v3.

T() = the MECHANICAL part of the fork: the Telegram*->Iosapp* rename plus the
unambiguous wire/deep-link token substitutions. Everything that is a judgement
call stays out of here and is carried by the functional patch P = diff(T(base), master).
"""
import re, posixpath

# ---------------------------------------------------------------- paths
def path_rule(p):
    parts = p.split("/")
    if parts[0] == "Telegram":
        parts[0] = "iosapp"
        if len(parts) > 1 and parts[1] == "Telegram-iOS":
            parts[1] = "Sources"
    for i in range(len(parts)):
        if i == 0 and parts[0] == "iosapp":
            continue
        if parts[i].startswith("Telegram"):
            parts[i] = "Iosapp" + parts[i][len("Telegram"):]
    p = "/".join(parts)
    # the Telegram share-target logo asset keeps its name
    p = p.replace("Images.xcassets/Chat/Context Menu/Iosapp.imageset",
                  "Images.xcassets/Chat/Context Menu/Telegram.imageset")
    if p.endswith(".tgs"):
        p = p[:-4] + ".ass"
    return p

# ------------------------------------------------- content-rule scoping
# Files the rename pass must NOT touch: vendored code, docs/CI metadata,
# localisation and Apple property lists (brand text lives there).
SKIP_PREFIX = ("third-party/", ".github/", "docs/", "buildbox/",
               "submodules/IosappUniversalVideoContent/HlsBundle/",
               "submodules/IosappUniversalVideoContent/PlayerSource/")
SKIP_EXT = (".md", ".plist", ".xcconfig", ".entitlements", ".storyboard",
            ".xcscheme", ".strings", ".stringsdict", ".xml", ".pbxproj")
SKIP_EXACT = (".gitignore", ".gitlab-ci.yml", ".cursorignore", ".gitattributes",
              "Random.txt", "NOTICE", "CHANGELOG.md", "LICENSE")
SKIP_SUFFIX = ("Images.xcassets/Contents.json",)

def _skip_rename(path):
    if path.startswith(SKIP_PREFIX): return True
    if path in SKIP_EXACT: return True
    if path.endswith(SKIP_EXT): return True
    if "/" in path and path.split("/")[-1] in (".gitignore",): return True
    if ".lproj/" in path: return True
    if ".xcassets/" in path and path.endswith("Contents.json"): return True
    if path.startswith("build-system/Make/") or path.startswith("build-system/MakeProject/"):
        return True            # target-name mapping is bespoke; carried by P
    return False

# ---------------------------------------------------- wire / deep links
# Applied to every decodable text file, including the ones excluded above:
# these are protocol values, not brand prose.
WIRE = [
    ("application/x-tgsticker",     "application/x-ansible-sticker"),
    ("application/x-tgstoryboardmap", "application/x-ansible-storyboardmap"),
    ("application/x-tgstoryboard",  "application/x-ansible-storyboard"),
    ("https://t.me/",               "https://asme.su/"),
    ("https://t.me",                "https://asme.su"),
    ('"t.me"',                      '"asme.su"'),
    ('"telegram.me"',               '"www.asme.su"'),
    ("t.me/",                       "asme.su/"),
    ("tg://",                       "as://"),
    # bundled Lottie extension .tgs -> .ass (NOT the Lottie JSON key "tgs")
    ('withExtension: "tgs"',        'withExtension: "ass"'),
    ('ofType: "tgs"',               'ofType: "ass"'),
    ('ofType:@"tgs"',               'ofType:@"ass"'),
    ('.tgs"',                       '.ass"'),
]
WIRE_SKIP_PREFIX = ("third-party/", "buildbox/", "docs/", ".github/")

def content_rule(newpath, oldpath, data):
    if not data:
        return data
    try:
        s = data.decode("utf-8")
    except UnicodeDecodeError:
        return data
    out = s
    if not _skip_rename(oldpath):
        out = out.replace("Telegram", "Iosapp")
        # flatbuffers generates lower-cased accessors from the type name
        out = re.sub(r"(?<=\.)telegram(?=[a-z])", "iosapp", out)
        # …but the pasteboard UTI "private.telegramtext" is a wire value, kept
        out = out.replace("private.iosapptext", "private.telegramtext")
        # 🚨 NEGATIVE RULE (fork commit 9024068d): the mini-app / game JS bridge
        # identifiers are a wire contract with every bot web-app out there and
        # must keep their upstream names.
        out = out.replace("IosappWebviewProxy", "TelegramWebviewProxy")
        out = out.replace("IosappGameProxy", "TelegramGameProxy")
        out = out.replace("window.Iosapp.", "window.Telegram.")
    if not oldpath.startswith(WIRE_SKIP_PREFIX):
        for a, b in WIRE:
            if a in out:
                out = out.replace(a, b)
    if out == s:
        return data
    return out.encode("utf-8")
