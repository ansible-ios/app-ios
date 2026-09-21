load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ThemeAccentColorScreen",
    module_name = "ThemeAccentColorScreen",
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
        "//submodules/ItemListUI",
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
        "//submodules/ChatListUI",
        "//submodules/IosappUI/Components/Settings/WallpaperGalleryScreen",
        "//submodules/IosappUI/Components/Settings/SettingsThemeWallpaperNode",
        "//submodules/IosappUI/Components/Settings/GenerateThemeName",
        "//submodules/IosappUI/Components/PremiumLockButtonSubtitleComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
