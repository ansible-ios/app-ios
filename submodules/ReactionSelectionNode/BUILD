load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ReactionSelectionNode",
    module_name = "ReactionSelectionNode",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/StickerResources:StickerResources",
        "//submodules/AccountContext:AccountContext",
        "//submodules/Components/ReactionButtonListComponent:ReactionButtonListComponent",
        "//submodules/lottie-ios:Lottie",
        "//submodules/AppBundle:AppBundle",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/PagerComponent:PagerComponent",
        "//submodules/IosappUI/Components/EmojiStatusSelectionComponent:EmojiStatusSelectionComponent",
        "//submodules/IosappUI/Components/EntityKeyboard:EntityKeyboard",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/DCTMultiAnimationRendererImpl:DCTMultiAnimationRendererImpl",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/TextFormat:TextFormat",
        "//submodules/GZip:GZip",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/IosappUI/Components/Utils/GenerateStickerPlaceholderImage",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/Premium/PremiumStarComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)

