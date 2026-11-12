load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMediaInputStickerGridItem",
    module_name = "ChatMediaInputStickerGridItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/StickerResources",
        "//submodules/AccountContext",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/ShimmerEffect",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/ChatPresentationInterfaceState",
    ],
    visibility = [
        "//visibility:public",
    ],
)
