load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AdPanelHeaderPanelComponent",
    module_name = "AdPanelHeaderPanelComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappUIPreferences",
        "//submodules/StickerResources",
        "//submodules/PhotoResources",
        "//submodules/IosappStringFormatting",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/AnimatedNavigationStripeNode",
        "//submodules/ContextUI",
        "//submodules/RadialStatusNode",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/TranslateUI",

    ],
    visibility = [
        "//visibility:public",
    ],
)
