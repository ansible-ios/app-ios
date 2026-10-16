load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

# See //submodules/IosappUI:composer_state_writer_sources.
filegroup(
    name = "composer_state_writer_sources",
    srcs = ["Sources/ChatTextInputPanelNode.swift"],
    visibility = ["//visibility:public"],
)

swift_library(
    name = "ChatTextInputPanelNode",
    module_name = "ChatTextInputPanelNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/LottieSettings:LottieSettings",
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/TouchDownGesture",
        "//submodules/ImageTransparency",
        "//submodules/ActivityIndicator",
        "//submodules/AnimationUI",
        "//submodules/Speak",
        "//submodules/ObjCRuntimeUtils",
        "//submodules/AvatarNode",
        "//submodules/ContextUI",
        "//submodules/InvisibleInkDustNode",
        "//submodules/TextInputMenu",
        "//submodules/Pasteboard",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ManagedAnimationNode",
        "//submodules/IosappUI/Components/EditableChatTextNode",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/Components/LottieAnimationComponent",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/EmojiSuggestionsComponent",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/UndoUI",
        "//submodules/PremiumUI",
        "//submodules/StickerPeekUI",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/SolidRoundedButtonNode",
        "//submodules/TooltipUI",
        "//submodules/IosappUI/Components/ChatTextInputMediaRecordingButton",
        "//submodules/ChatContextQuery",
        "//submodules/IosappUI/Components/Chat/ChatInputTextNode",
        "//submodules/IosappUI/Components/Chat/ChatRichTextEditorComposer",
        "//submodules/IosappUI/Components/Chat/ChatInputPanelNode",
        "//submodules/IosappNotices",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/Utils/DeviceModel",
        "//submodules/PhotoResources",
        "//submodules/IosappUI/Components/Chat/ChatTextInputSlowmodePlaceholderNode",
        "//submodules/IosappUI/Components/Chat/ChatTextInputActionButtonsNode",
        "//submodules/IosappUI/Components/Chat/ChatTextInputAudioRecordingTimeNode",
        "//submodules/IosappUI/Components/Chat/ChatTextInputAudioRecordingCancelIndicator",
        "//submodules/IosappUI/Components/Chat/ChatRecordingViewOnceButtonNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/Chat/ChatInputAccessoryPanel",
        "//submodules/IosappUI/Components/Chat/ChatInputAutocompletePanel",
        "//submodules/IosappUI/Components/Chat/ChatRecordingPreviewInputPanelNode",
        "//submodules/IosappUI/Components/Chat/ChatInputContextPanelNode",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/RasterizedCompositionComponent",
        "//submodules/IosappUI/Components/DiamondsParticleEffect",
        "//submodules/IosappUI/Components/Calls/VideoChatMicButtonComponent",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorUIKit",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorCore",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "ChatTextInputPanelNodeTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":ChatTextInputPanelNode",
        "//submodules/IosappUI/Components/Chat/ChatInputTextNode",
        "//submodules/TextFormat",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappPresentationData",
        "//submodules/Display",
    ],
)

# The runner MUST pin a real device/OS: the default runner picks an invalid
# device and the test process exits 15. Matches //submodules/InstantPageUI:InstantPageUITests.
ios_test_runner(
    name = "ChatTextInputPanelNodeTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ChatTextInputPanelNodeTests",
    minimum_os_version = "15.0",
    runner = ":ChatTextInputPanelNodeTestRunner",
    deps = [
        ":ChatTextInputPanelNodeTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
