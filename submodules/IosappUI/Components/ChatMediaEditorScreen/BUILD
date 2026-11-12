load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "ChatMediaEditorScreen",
    module_name = "ChatMediaEditorScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/LegacyMediaPickerUI",
        "//submodules/LegacyComponents",
        "//submodules/TextFormat",
        "//submodules/ImageCompression",
        "//submodules/LocalMediaResources",
        "//submodules/IosappUIPreferences",
        "//submodules/Display",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/DrawingUI:DrawingUI",
        "//submodules/MediaPickerUI:MediaPickerUI",
        "//submodules/IosappUI/Components/MediaEditorScreen",
        "//submodules/IosappUI/Components/MediaScrubberComponent",
        "//submodules/SaveToCameraRoll:SaveToCameraRoll",
        "//submodules/LocalizedPeerData:LocalizedPeerData",
        "//submodules/IosappUI/Components/MediaCropComponent",
        "//submodules/ContextUI:ContextUI",
        "//submodules/IosappUI/Components/ChatMediaSend",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/RadialStatusNode:RadialStatusNode",
        "//submodules/IosappUI/Components/MediaAssetsContext",
        "//submodules/TooltipUI:TooltipUI",
        "//submodules/IosappUI/Components/SliderComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/MediaEditorBottomControls",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "ChatMediaEditorScreenTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":ChatMediaEditorScreen",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/TextFormat",
        "//submodules/Display",
        "//submodules/LegacyMediaPickerUI",
        "//submodules/LocalMediaResources",
        "//submodules/LegacyComponents",
        "//submodules/IosappUI/Components/MediaCropComponent",
        "//submodules/IosappUI/Components/MediaEditorScreen",
        "//submodules/IosappUI/Components/ChatMediaSend",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/DrawingUI:DrawingUI",
    ],
)

ios_test_runner(
    name = "ChatMediaEditorScreenTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ChatMediaEditorScreenTests",
    minimum_os_version = "15.0",
    runner = ":ChatMediaEditorScreenTestRunner",
    deps = [
        ":ChatMediaEditorScreenTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
