load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ThemeCarouselItem",
    module_name = "ThemeCarouselItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/MergeLists",
        "//submodules/IosappUIPreferences",
        "//submodules/ItemListUI",
        "//submodules/PresentationDataUtils",
        "//submodules/WallpaperResources",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/ContextUI",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/ShimmerEffect",
        "//submodules/StickerResources",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
        "//submodules/HexColor",
    ],
    visibility = [
        "//visibility:public",
    ],
)
