load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatAvatarNavigationNode",
    module_name = "ChatAvatarNavigationNode",
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
        "//submodules/AvatarNode",
        "//submodules/ContextUI",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUniversalVideoContent",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/GalleryUI",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/AvatarVideoNode",
        "//submodules/IosappUI/Components/Stories/AvatarStoryIndicatorComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
