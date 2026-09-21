load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageReplyInfoNode",
    module_name = "ChatMessageReplyInfoNode",
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
        "//submodules/CheckNode",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/MessageInlineBlockBackgroundView",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
    ],
    visibility = [
        "//visibility:public",
    ],
)
