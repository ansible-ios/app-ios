load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageItemImpl",
    module_name = "ChatMessageItemImpl",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Postbox",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/AccountContext",
        "//submodules/Emoji",
        "//submodules/PersistentStringHash",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Chat/ChatHistoryEntry",
        "//submodules/IosappUI/Components/Chat/ChatMessageItem",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemView",
        "//submodules/IosappUI/Components/Chat/ChatMessageStickerItemNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageAnimatedStickerItemNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleItemNode",
        "//submodules/AvatarNode",
        "//submodules/IosappUniversalVideoContent",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/GalleryUI",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/AvatarVideoNode",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
