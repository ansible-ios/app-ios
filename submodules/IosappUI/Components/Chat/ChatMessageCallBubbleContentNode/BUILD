load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageCallBubbleContentNode",
    module_name = "ChatMessageCallBubbleContentNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AppBundle",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatMessageDateAndStatusNode",
        "//submodules/AnimatedAvatarSetNode",
        "//submodules/AvatarNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
