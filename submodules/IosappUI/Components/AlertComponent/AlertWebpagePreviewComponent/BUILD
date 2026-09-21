load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AlertWebpagePreviewComponent",
    module_name = "AlertWebpagePreviewComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/WebsiteType",
        "//submodules/UrlHandling",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/Chat/ChatMessageAttachedContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatHistoryEntry",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/WallpaperPreviewMedia",
        "//submodules/ChatPresentationInterfaceState",
    ],
    visibility = [
        "//visibility:public",
    ],
)
