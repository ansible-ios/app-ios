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
    name = "IosappCallsUIMetalResources",
    srcs = glob([
        "Resources/**/*.metal",
    ]),
    visibility = ["//visibility:public"],
)

plist_fragment(
    name = "IosappCallsUIBundleInfoPlist",
    extension = "plist",
    template =
    """
    <key>CFBundleIdentifier</key>
    <string>org.telegram.TelegramCallsUI</string>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleName</key>
    <string>TelegramCallsUI</string>
    """
)

apple_resource_bundle(
    name = "IosappCallsUIBundle",
    infoplists = [
        ":IosappCallsUIBundleInfoPlist",
    ],
    resources = [
        ":IosappCallsUIMetalResources",
    ],
)

swift_library(
    name = "IosappCallsUI",
    module_name = "IosappCallsUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    data = [
        ":IosappCallsUIBundle",
    ],
    deps = [
        "//submodules/SSignalKit/SSignalKit",
    	"//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/PhotoResources:PhotoResources",
        "//submodules/IosappNotices:IosappNotices",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/DeviceAccess:DeviceAccess",
        "//submodules/IosappAudio:IosappAudio",
        "//submodules/IosappVoip:IosappVoip",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/OverlayStatusController:OverlayStatusController",
        "//submodules/AppBundle:AppBundle",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/IosappCallsUI/CallsEmoji:CallsEmoji",
        "//submodules/SemanticStatusNode:SemanticStatusNode",
        "//submodules/TooltipUI:TooltipUI",
        "//submodules/ItemListPeerItem:ItemListPeerItem",
        "//submodules/MergeLists:MergeLists",
        "//submodules/RadialStatusNode:RadialStatusNode",
        "//submodules/ContextUI:ContextUI",
        "//submodules/ShareController:ShareController",
        "//submodules/LegacyComponents:LegacyComponents",
        "//submodules/DeleteChatPeerActionSheetItem:DeleteChatPeerActionSheetItem",
        "//submodules/AnimationUI:AnimationUI",
        "//submodules/UndoUI:UndoUI",
        "//submodules/AudioBlob:AudioBlob",
        "//submodules/AnimatedAvatarSetNode:AnimatedAvatarSetNode",
        "//submodules/AlertUI:AlertUI",
        "//submodules/DirectionalPanGesture:DirectionalPanGesture",
        "//submodules/AnimatedCountLabelNode:AnimatedCountLabelNode",
        "//submodules/DeviceProximity:DeviceProximity",
        "//submodules/ManagedAnimationNode:ManagedAnimationNode",
        "//submodules/TemporaryCachedPeerDataManager:TemporaryCachedPeerDataManager",
        "//submodules/PeerInfoAvatarListNode:PeerInfoAvatarListNode",
        "//submodules/MapResourceToAvatarSizes:MapResourceToAvatarSizes",
        "//submodules/TextFormat:TextFormat",
        "//submodules/Markdown:Markdown",
        "//submodules/ChatTitleActivityNode:ChatTitleActivityNode",
        "//third-party/LibYuvBinding",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/LottieAnimationComponent:LottieAnimationComponent",
        "//submodules/Components/ActivityIndicatorComponent:ActivityIndicatorComponent",
        "//submodules/Components/ViewControllerComponent:ViewControllerComponent",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/Components/UndoPanelComponent:UndoPanelComponent",
        "//submodules/Components/HierarchyTrackingLayer:HierarchyTrackingLayer",
        "//submodules/PeerInfoUI/CreateExternalMediaStreamScreen:CreateExternalMediaStreamScreen",
        "//submodules/PhoneNumberFormat:PhoneNumberFormat",
        "//submodules/IosappUI/Components/Calls/CallScreen",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/TinyThumbnail",
        "//submodules/ImageBlur",
        "//submodules/MetalEngine",
        "//submodules/IosappUI/Components/Calls/VoiceChatActionButton",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/Stories/PeerListItemComponent",
        "//submodules/IosappUI/Components/BackButtonComponent",
        "//submodules/Components/BlurredBackgroundComponent",
        "//submodules/DirectMediaImageCache",
        "//submodules/FastBlur",
        "//submodules/InviteLinksUI",
        "//third-party/td:TdBinding",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/MessageInputPanelComponent",
        "//submodules/IosappUI/Components/TextFieldComponent",
        "//submodules/ReactionSelectionNode",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/PremiumUI",
        "//submodules/IosappUI/Components/Calls/VideoChatMicButtonComponent",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertInputFieldComponent",
        "//submodules/IosappUI/Components/GlassControls",
    ],
    visibility = [
        "//visibility:public",
    ],
)
