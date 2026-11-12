load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageWebpageBubbleContentNode",
    module_name = "ChatMessageWebpageBubbleContentNode",
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
        "//submodules/IosappUIPreferences",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/WebsiteType",
        "//submodules/InstantPageUI",
        "//submodules/UrlHandling",
        "//submodules/GalleryData",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/WallpaperPreviewMedia",
        "//submodules/IosappUI/Components/Chat/ChatMessageInteractiveMediaNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageAttachedContentNode",
        "//submodules/IosappUI/Components/Chat/ChatHistoryEntry",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
    ],
    visibility = [
        "//visibility:public",
    ],
)
