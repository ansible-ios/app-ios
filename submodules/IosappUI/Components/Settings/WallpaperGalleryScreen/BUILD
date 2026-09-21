load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WallpaperGalleryScreen",
    module_name = "WallpaperGalleryScreen",
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
        "//submodules/CounterControllerTitleView",
        "//submodules/LegacyMediaPickerUI",
        "//submodules/IosappUI/Components/Settings/SettingsThemeWallpaperNode",
        "//submodules/IosappUI/Components/PremiumLockButtonSubtitleComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassControls",
    ],
    visibility = [
        "//visibility:public",
    ],
)
