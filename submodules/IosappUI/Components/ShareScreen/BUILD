load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "ShareScreen",
    module_name = "ShareScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/ContextUI",
        "//submodules/IosappUI/Components/AuthConfirmationScreen",
        "//submodules/IosappUI/Components/PeerInfo/AccountPeerContextItem",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/ItemListUI",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/ShareController",
        "//submodules/SaveToCameraRoll",
        "//submodules/ChatListUI",
        "//submodules/AvatarNode",
        "//submodules/CheckNode",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/ChatEntityKeyboardInputNode",
        "//submodules/IosappUI/Components/Stories/PeerListItemComponent",
        "//submodules/IosappUI/Components/Chat/ChatMessagePaymentAlertController",
        "//submodules/Components/SheetComponent",
        "//submodules/UndoUI",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/HorizontalTabsComponent",
        "//submodules/IosappUI/Components/NavigationStackComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/IosappUI/Components/MessageInputPanelComponent",
        "//submodules/IosappUI/Components/Chat/MergedAvatarsNode",
        "//submodules/TooltipUI",
        "//submodules/IosappNotices",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/SegmentControlComponent",
        "//submodules/UIKitRuntimeUtils",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "ShareScreenTestsLib",
    testonly = True,
    srcs = glob(["Tests/*.swift"]),
    deps = [
        ":ShareScreen",
        "//submodules/IosappCore",
    ],
)

ios_test_runner(
    name = "ShareScreenTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ShareScreenTests",
    runner = ":ShareScreenTestRunner",
    minimum_os_version = "15.0",
    deps = [":ShareScreenTestsLib"],
)
