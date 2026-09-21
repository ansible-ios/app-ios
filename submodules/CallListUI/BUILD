load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CallListUI",
    module_name = "CallListUI",
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
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/AccountContext:AccountContext",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/AlertUI:AlertUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/IosappNotices:IosappNotices",
        "//submodules/MergeLists:MergeLists",
        "//submodules/ChatListSearchItemHeader:ChatListSearchItemHeader",
        "//submodules/PeerOnlineMarkerNode:PeerOnlineMarkerNode",
        "//submodules/ContextUI:ContextUI",
        "//submodules/IosappBaseController:IosappBaseController",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/ItemListPeerActionItem",
        "//submodules/InviteLinksUI",
        "//submodules/UndoUI",
        "//submodules/IosappCallsUI",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
    ],
    visibility = [
        "//visibility:public",
    ],
)
