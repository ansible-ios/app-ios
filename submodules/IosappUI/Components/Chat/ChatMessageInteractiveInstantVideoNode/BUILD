load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageInteractiveInstantVideoNode",
    module_name = "ChatMessageInteractiveInstantVideoNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
        #"-Xfrontend", "-debug-time-function-bodies"
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Postbox",
        "//submodules/IosappCore",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/RadialStatusNode",
        "//submodules/SemanticStatusNode",
        "//submodules/PhotoResources",
        "//submodules/IosappUniversalVideoContent",
        "//submodules/FileMediaResourceStatus",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AudioTranscriptionButtonComponent",
        "//submodules/UndoUI",
        "//submodules/IosappNotices",
        "//submodules/Markdown",
        "//submodules/TextFormat",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageForwardInfoNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageDateAndStatusNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageReplyInfoNode",
        "//submodules/IosappUI/Components/Chat/InstantVideoRadialStatusNode",
        "//submodules/IosappUI/Components/Chat/ChatInstantVideoMessageDurationNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
    ],
    visibility = [
        "//visibility:public",
    ],
)
