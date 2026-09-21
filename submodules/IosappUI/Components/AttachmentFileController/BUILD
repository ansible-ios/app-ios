load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AttachmentFileController",
    module_name = "AttachmentFileController",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/Postbox",
        "//submodules/AccountContext",
        "//submodules/IosappPresentationData",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUIPreferences",
        "//submodules/LegacyComponents",
        "//submodules/SolidRoundedButtonNode",
        "//submodules/PresentationDataUtils",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/ComponentFlow",
        "//submodules/ItemListPeerActionItem",
        "//submodules/ListMessageItem",
        "//submodules/AttachmentUI",
        "//submodules/SearchBarNode",
        "//submodules/MergeLists",
        "//submodules/ChatListSearchItemHeader",
        "//submodules/ItemListUI",
        "//submodules/SearchUI",
        "//submodules/ContextUI",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/SearchInputPanelComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/MediaManager/PeerMessagesMediaPlaylist",
    ],
    visibility = [
        "//visibility:public",
    ],
)

