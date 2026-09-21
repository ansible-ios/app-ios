load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatBotInfoItem",
    module_name = "ChatBotInfoItem",
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
        "//submodules/TextFormat",
        "//submodules/UrlEscaping",
        "//submodules/PhotoResources",
        "//submodules/AccountContext",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/IosappUniversalVideoContent",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/Markdown",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoCoverComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
