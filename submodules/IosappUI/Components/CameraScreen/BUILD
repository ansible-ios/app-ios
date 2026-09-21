load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(
    "@build_bazel_rules_apple//apple:resources.bzl",
    "apple_resource_bundle",
    "apple_resource_group",
)
load("//build-system/bazel-utils:plist_fragment.bzl",
    "plist_fragment",
)

filegroup(
    name = "CameraScreenMetalResources",
    srcs = glob([
        "MetalResources/**/*.*",
    ]),
    visibility = ["//visibility:public"],
)

plist_fragment(
    name = "CameraScreenBundleInfoPlist",
    extension = "plist",
    template =
    """
    <key>CFBundleIdentifier</key>
    <string>org.telegram.CameraScreen</string>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleName</key>
    <string>CameraScreen</string>
    """
)

apple_resource_bundle(
    name = "CameraScreenBundle",
    infoplists = [
        ":CameraScreenBundleInfoPlist",
    ],
    resources = [
        ":CameraScreenMetalResources",
    ],
)

swift_library(
    name = "CameraScreen",
    module_name = "CameraScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    data = [
        ":CameraScreenBundle",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/MetalEngine",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/LocalMediaResources",
        "//submodules/Camera",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BlurredBackgroundComponent",
        "//submodules/Components/LottieAnimationComponent:LottieAnimationComponent",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/TooltipUI",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/Components/MetalImageView",
        "//submodules/IosappUI/Components/CameraButtonComponent",
        "//submodules/Utils/VolumeButtons",
        "//submodules/IosappNotices",
        "//submodules/DeviceAccess",
        "//submodules/IosappUI/Components/Utils/RoundedRectWithTailPath",
        "//submodules/IosappUI/Components/MediaAssetsContext",
        "//submodules/UndoUI",
        "//submodules/ContextUI",
        "//submodules/AvatarNode",
        "//submodules/ActivityIndicator",
        "//submodules/IosappUI/Components/Utils/AnimatableProperty",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ShareWithPeersScreen",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappCallsUI",
        "//submodules/IosappUI/Components/Stories/StoryContainerScreen",
        "//submodules/IosappUI/Components/ChatEntityKeyboardInputNode",
        "//submodules/IosappUI/Components/LiquidLens",
        "//submodules/IosappUI/Components/TabSelectionRecognizer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
