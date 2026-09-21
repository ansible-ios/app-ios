load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageCommentFooterContentNode",
    module_name = "ChatMessageCommentFooterContentNode",
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
        "//submodules/RadialStatusNode",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/AnimatedAvatarSetNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
    ],
    visibility = [
        "//visibility:public",
    ],
)
