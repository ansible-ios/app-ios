load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageGiftBubbleContentNode",
    module_name = "ChatMessageGiftBubbleContentNode",
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
        "//submodules/AccountContext",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/TextFormat",
        "//submodules/LocalizedPeerData",
        "//submodules/UrlEscaping",
        "//submodules/IosappStringFormatting",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/ReactionSelectionNode",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/ShimmerEffect",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoCoverComponent",
        "//submodules/IosappUI/Components/Gifts/GiftItemComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
