load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatLoadingNode",
    module_name = "ChatLoadingNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/ActivityIndicator",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/ShimmerEffect",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/Chat/ChatMessageItem",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemView",
        "//submodules/IosappUI/Components/Chat/ChatMessageStickerItemNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageInstantVideoItemNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageAnimatedStickerItemNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleItemNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemImpl",
    ],
    visibility = [
        "//visibility:public",
    ],
)
