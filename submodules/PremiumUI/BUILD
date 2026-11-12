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
    name = "PremiumUIMetalResources",
    srcs = glob([
        "MetalResources/**/*.*",
    ]),
    visibility = ["//visibility:public"],
)

plist_fragment(
    name = "PremiumUIBundleInfoPlist",
    extension = "plist",
    template =
    """
    <key>CFBundleIdentifier</key>
    <string>org.telegram.PremiumUI</string>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleName</key>
    <string>PremiumUI</string>
    """
)

apple_resource_bundle(
    name = "PremiumUIBundle",
    infoplists = [
        ":PremiumUIBundleInfoPlist",
    ],
    resources = [
        ":PremiumUIMetalResources",
    ],
)

filegroup(
    name = "PremiumUIResources",
    srcs = glob([
        "Resources/**/*",
    ], exclude = ["Resources/**/.*"]),
    visibility = ["//visibility:public"],
)

swift_library(
    name = "PremiumUI",
    module_name = "PremiumUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    data = [
        ":PremiumUIBundle",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/AppBundle:AppBundle",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/SolidRoundedButtonNode:SolidRoundedButtonNode",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/ReactionSelectionNode:ReactionSelectionNode",
        "//submodules/InAppPurchaseManager:InAppPurchaseManager",
        "//submodules/ConfettiEffect:ConfettiEffect",
        "//submodules/TextFormat:TextFormat",
        "//submodules/GZip:GZip",
        "//submodules/InstantPageCache:InstantPageCache",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/IosappUniversalVideoContent:IosappUniversalVideoContent",
        "//submodules/RadialStatusNode:RadialStatusNode",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/LegacyComponents:LegacyComponents",
        "//submodules/CheckNode:CheckNode",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/ViewControllerComponent:ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/Components/MultilineTextWithEntitiesComponent:MultilineTextWithEntitiesComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/Components/SolidRoundedButtonComponent:SolidRoundedButtonComponent",
        "//submodules/Components/BlurredBackgroundComponent:BlurredBackgroundComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/Stories/AvatarStoryIndicatorComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/ItemListPeerItem:ItemListPeerItem",
        "//submodules/ItemListPeerActionItem:ItemListPeerActionItem",
        "//submodules/IosappUI/Components/ItemListDatePickerItem:ItemListDatePickerItem",
        "//submodules/IosappUI/Components/ShareWithPeersScreen",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/Utils/RoundedRectWithTailPath",
        "//submodules/CountrySelectionUI",
        "//submodules/IosappUI/Components/Stories/PeerListItemComponent",
        "//submodules/InvisibleInkDustNode",
        "//submodules/AlertUI",
        "//submodules/IosappUI/Components/Chat/MergedAvatarsNode",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/EmojiStatusSelectionComponent",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/IosappUI/Components/PremiumPeerShortcutComponent",
        "//submodules/IosappUI/Components/EmojiActionIconComponent",
        "//submodules/IosappUI/Components/ScrollComponent",
        "//submodules/IosappUI/Components/Premium/PremiumStarComponent",
        "//submodules/IosappUI/Components/Premium/PremiumCoinComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/Gifts/TableComponent",
        "//submodules/IosappUI/Components/Gifts/PeerTableCellComponent",
        "//submodules/IosappUI/Components/AlertComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
