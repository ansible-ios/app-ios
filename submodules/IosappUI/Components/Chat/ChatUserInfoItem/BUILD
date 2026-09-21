load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatUserInfoItem",
    module_name = "ChatUserInfoItem",
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
        "//submodules/CountrySelectionUI",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/Chat/MergedAvatarsNode",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)
