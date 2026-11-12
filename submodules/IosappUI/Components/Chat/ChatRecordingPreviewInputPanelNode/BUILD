load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatRecordingPreviewInputPanelNode",
    module_name = "ChatRecordingPreviewInputPanelNode",
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
        "//submodules/IosappPresentationData",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/AppBundle",
        "//submodules/ContextUI",
        "//submodules/AnimationUI",
        "//submodules/ManagedAnimationNode",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/ChatSendButtonRadialStatusNode",
        "//submodules/IosappUI/Components/AudioWaveformNode",
        "//submodules/IosappUI/Components/Chat/ChatInputPanelNode",
        "//submodules/TooltipUI",
        "//submodules/IosappNotices",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/MediaScrubberComponent",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/IosappUI/Components/Chat/ChatRecordingViewOnceButtonNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
