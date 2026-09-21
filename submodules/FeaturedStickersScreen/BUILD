load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "FeaturedStickersScreen",
    module_name = "FeaturedStickersScreen",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display:Display",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/MergeLists:MergeLists",
        "//submodules/StickerPeekUI:StickerPeekUI",
        "//submodules/OverlayStatusController:OverlayStatusController",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/SearchBarNode:SearchBarNode",
        "//submodules/UndoUI:UndoUI",
        "//submodules/ContextUI:ContextUI",
        "//submodules/PremiumUI:PremiumUI",
        "//submodules/ChatPresentationInterfaceState:ChatPresentationInterfaceState",
        "//submodules/StickerResources:StickerResources",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/TextFormat",
        "//submodules/ListSectionHeaderNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
