load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AttachmentTextInputPanelNode",
    module_name = "AttachmentTextInputPanelNode",
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
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/TextFormat:TextFormat",
        "//submodules/AccountContext:AccountContext",
        "//submodules/TouchDownGesture:TouchDownGesture",
        "//submodules/ActivityIndicator:ActivityIndicator",
        "//submodules/Speak:Speak",
        "//submodules/LegacyComponents:LegacyComponents",
        "//submodules/ObjCRuntimeUtils:ObjCRuntimeUtils",
        "//submodules/InvisibleInkDustNode:InvisibleInkDustNode",
        "//submodules/TextInputMenu:TextInputMenu",
        "//submodules/ChatPresentationInterfaceState:ChatPresentationInterfaceState",
        "//submodules/Pasteboard:Pasteboard",
        "//submodules/ContextUI:ContextUI",
        "//submodules/IosappUI/Components/ChatEntityKeyboardInputNode:ChatEntityKeyboardInputNode",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/LottieAnimationComponent:LottieAnimationComponent",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/TextNodeWithEntities:TextNodeWithEntities",
        "//submodules/IosappUI/Components/Chat/ChatInputTextNode",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
