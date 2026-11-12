load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

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
        "//submodules/IosappUI/Components/SideColumnLayout",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "ItemListUITestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":ItemListUI",
    ],
)

# The runner MUST pin a real device/OS: the default runner picks an invalid
# device and the test process exits 15.
ios_test_runner(
    name = "ItemListUITestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ItemListUITests",
    minimum_os_version = "15.0",
    runner = ":ItemListUITestRunner",
    deps = [
        ":ItemListUITestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
