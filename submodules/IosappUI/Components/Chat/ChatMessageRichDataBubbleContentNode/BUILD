load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageRichDataBubbleContentNode",
    module_name = "ChatMessageRichDataBubbleContentNode",
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
        "//submodules/AccountContext",
        "//submodules/InstantPageUI",
        "//submodules/TextFormat:TextFormat",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageDateAndStatusNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ShimmeringLinkNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/TextLoadingEffect",
        "//submodules/IosappUIPreferences",
        "//submodules/TextSelectionNode",
        "//submodules/IosappUI/Components/StreamingTextReveal:StreamingTextReveal",
    ],
    visibility = [
        "//visibility:public",
    ],
)
