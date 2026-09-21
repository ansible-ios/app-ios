load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageInstantVideoItemNode",
    module_name = "ChatMessageInstantVideoItemNode",
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
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/LocalizedPeerData",
        "//submodules/ContextUI",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Chat/ChatMessageForwardInfoNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageDateAndStatusNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageReplyInfoNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageInteractiveInstantVideoNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItem",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemView",
        "//submodules/IosappUI/Components/Chat/ChatMessageSwipeToReplyNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageSelectionNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageDeliveryFailedNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageShareButton",
        "//submodules/IosappUI/Components/Chat/ChatMessageActionButtonsNode",
        "//submodules/IosappUI/Components/Chat/ChatSwipeToReplyRecognizer",
        "//submodules/IosappUI/Components/Chat/ChatMessageReactionsFooterContentNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
