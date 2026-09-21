load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatTextInputActionButtonsNode",
    module_name = "ChatTextInputActionButtonsNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/ContextUI",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ChatMessageBackground",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/ChatTextInputMediaRecordingButton",
        "//submodules/IosappUI/Components/ChatSendButtonRadialStatusNode",
        "//submodules/ChatSendMessageActionUI",
        "//submodules/ComponentFlow",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/StarsParticleEffect",
    ],
    visibility = [
        "//visibility:public",
    ],
)
