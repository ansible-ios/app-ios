load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ItemListUI",
    module_name = "ItemListUI",
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
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/MergeLists:MergeLists",
        "//submodules/TextFormat:TextFormat",
        "//submodules/Markdown:Markdown",
        "//submodules/ProgressNavigationButtonNode:ProgressNavigationButtonNode",
        "//submodules/SwitchNode:SwitchNode",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/CheckNode:CheckNode",
        "//submodules/SegmentedControlNode:SegmentedControlNode",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AnimationUI:AnimationUI",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/ManagedAnimationNode:ManagedAnimationNode",
        "//submodules/AvatarNode",
        "//submodules/IosappCore",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/TabSelectorComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassControls",
        "//submodules/IosappUI/Components/HorizontalTabsComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
