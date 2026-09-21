load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageMapBubbleContentNode",
    module_name = "ChatMessageMapBubbleContentNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/LiveLocationTimerNode",
        "//submodules/PhotoResources",
        "//submodules/MediaResources",
        "//submodules/LocationResources",
        "//submodules/LiveLocationPositionNode",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Chat/ChatMessageDateAndStatusNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
    ],
    visibility = [
        "//visibility:public",
    ],
)
