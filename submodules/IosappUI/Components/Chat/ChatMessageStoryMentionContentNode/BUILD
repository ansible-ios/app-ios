load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageStoryMentionContentNode",
    module_name = "ChatMessageStoryMentionContentNode",
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
        "//submodules/IosappStringFormatting",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/ReactionSelectionNode",
        "//submodules/PhotoResources",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/IosappUniversalVideoContent",
        "//submodules/GalleryUI",
        "//submodules/Markdown",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/Stories/AvatarStoryIndicatorComponent",
        "//submodules/AvatarNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
    ],
    visibility = [
        "//visibility:public",
    ],
)
