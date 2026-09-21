load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerInfoAvatarListNode",
    module_name = "PeerInfoAvatarListNode",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/PhotoResources:PhotoResources",
        "//submodules/RadialStatusNode:RadialStatusNode",
        "//submodules/PeerAvatarGalleryUI:PeerAvatarGalleryUI",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/IosappUniversalVideoContent:IosappUniversalVideoContent",
        "//submodules/GalleryUI:GalleryUI",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AvatarVideoNode:AvatarVideoNode",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/Stories/StorySetIndicatorComponent",
        "//submodules/Components/HierarchyTrackingLayer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
