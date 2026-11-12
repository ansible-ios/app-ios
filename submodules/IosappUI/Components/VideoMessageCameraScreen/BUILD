load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "VideoMessageCameraScreen",
    module_name = "VideoMessageCameraScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/MediaResources",
        "//submodules/LocalMediaResources",
        "//submodules/ImageCompression",
        "//submodules/Camera",
        "//submodules/Camera/CameraLegacy",
        "//submodules/Camera/CameraNeo",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BlurredBackgroundComponent",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/CameraButtonComponent",
        "//submodules/TooltipUI",
        "//submodules/IosappNotices",
        "//submodules/DeviceAccess",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/LegacyMediaPickerUI",
        "//submodules/IosappAudio",
        "//submodules/ChatSendMessageActionUI",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "VideoMessageCameraScreenTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":VideoMessageCameraScreen",
        "//submodules/Display",
    ],
)

ios_test_runner(
    name = "VideoMessageCameraScreenTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "VideoMessageCameraScreenTests",
    minimum_os_version = "15.0",
    runner = ":VideoMessageCameraScreenTestRunner",
    deps = [
        ":VideoMessageCameraScreenTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
