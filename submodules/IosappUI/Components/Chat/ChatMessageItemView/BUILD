load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageItemView",
    module_name = "ChatMessageItemView",
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
        "//submodules/AccountContext",
        "//submodules/LocalizedPeerData",
        "//submodules/ContextUI",
        "//submodules/ChatListUI",
        "//submodules/IosappPresentationData",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/Chat/ChatMessageItem",
        "//submodules/IosappUI/Components/Chat/ChatMessageTransitionNode",
        "//submodules/IosappAnimatedStickerNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
