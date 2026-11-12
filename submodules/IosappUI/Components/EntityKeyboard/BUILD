load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "EntityKeyboard",
    module_name = "EntityKeyboard",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/PagerComponent:PagerComponent",
        "//submodules/Components/BlurredBackgroundComponent:BlurredBackgroundComponent",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappCore:IosappCore",
        "//submodules/Postbox:Postbox",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/YuvConversion:YuvConversion",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/LottieAnimationCache:LottieAnimationCache",
        "//submodules/IosappUI/Components/VideoAnimationCache:VideoAnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/DCTMultiAnimationRendererImpl:DCTMultiAnimationRendererImpl",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/EmojiStatusComponent:EmojiStatusComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/LottieComponentEmojiContent",
        "//submodules/SoftwareVideo:SoftwareVideo",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/PhotoResources:PhotoResources",
        "//submodules/StickerResources:StickerResources",
        "//submodules/AppBundle:AppBundle",
        "//submodules/UndoUI:UndoUI",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Components/LottieAnimationComponent:LottieAnimationComponent",
        "//submodules/LocalizedPeerData:LocalizedPeerData",
        "//submodules/IosappNotices:IosappNotices",
        "//submodules/GZip",
        "//submodules/LottieBinding:LottieBinding",
        "//submodules/lottie-ios:Lottie",
        "//submodules/IosappUI/Components/Utils/GenerateStickerPlaceholderImage",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappCore/FlatBuffers",
        "//submodules/IosappCore/FlatSerialization",
        "//submodules/IosappUI/Components/BatchVideoRendering",
        "//submodules/IosappUI/Components/GifVideoLayer",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/LiquidLens",
        "//submodules/IosappUI/Components/TabSelectionRecognizer",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "EntityKeyboardTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":EntityKeyboard",
        "//submodules/Display:Display",
    ],
)

ios_test_runner(
    name = "EntityKeyboardTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "EntityKeyboardTests",
    minimum_os_version = "15.0",
    runner = ":EntityKeyboardTestRunner",
    deps = [
        ":EntityKeyboardTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
