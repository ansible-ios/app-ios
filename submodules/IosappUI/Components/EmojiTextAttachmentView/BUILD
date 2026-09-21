load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "EmojiTextAttachmentView",
    module_name = "EmojiTextAttachmentView",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/YuvConversion:YuvConversion",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/LottieAnimationCache:LottieAnimationCache",
        "//submodules/IosappUI/Components/VideoAnimationCache:VideoAnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/DCTMultiAnimationRendererImpl:DCTMultiAnimationRendererImpl",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappUI/Components/Utils/GenerateStickerPlaceholderImage",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/ComponentFlow",
    ],
    visibility = [
        "//visibility:public",
    ],
)
