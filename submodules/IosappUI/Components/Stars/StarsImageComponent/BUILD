load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "StarsImageComponent",
    module_name = "StarsImageComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/IosappPresentationData",
        "//submodules/PhotoResources",
        "//submodules/AvatarNode",
        "//submodules/AccountContext",
        "//submodules/InvisibleInkDustNode",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
