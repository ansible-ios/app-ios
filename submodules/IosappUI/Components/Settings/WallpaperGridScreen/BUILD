load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WallpaperGridScreen",
    module_name = "WallpaperGridScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/Postbox",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/PresentationDataUtils",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/ComponentFlow",
        "//submodules/SolidRoundedButtonNode",
        "//submodules/AppBundle",
        "//submodules/PremiumUI",
        "//submodules/WallpaperResources",
        "//submodules/HexColor",
        "//submodules/MergeLists",
        "//submodules/ShareController",
        "//submodules/GalleryUI",
        "//submodules/GridMessageSelectionNode",
        "//submodules/SearchUI",
        "//submodules/MediaPickerUI",
        "//submodules/ItemListPeerActionItem",
        "//submodules/IosappUI/Components/Settings/WallpaperGalleryScreen",
        "//submodules/IosappUI/Components/Settings/SettingsThemeWallpaperNode",
        "//submodules/IosappUI/Components/Settings/ThemeAccentColorScreen",
        "//submodules/IosappUI/Components/PremiumLockButtonSubtitleComponent",
        "//submodules/IosappUI/Components/Settings/BoostLevelIconComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
