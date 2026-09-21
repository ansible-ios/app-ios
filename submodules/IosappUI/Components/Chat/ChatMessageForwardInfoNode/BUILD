load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageForwardInfoNode",
    module_name = "ChatMessageForwardInfoNode",
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
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/LocalizedPeerData",
        "//submodules/PhotoResources",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/TextLoadingEffect",
        "//submodules/AvatarNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
