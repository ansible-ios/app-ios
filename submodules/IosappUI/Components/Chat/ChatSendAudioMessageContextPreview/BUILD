load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatSendAudioMessageContextPreview",
    module_name = "ChatSendAudioMessageContextPreview",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ChatSendMessageActionUI",
        "//submodules/ComponentFlow",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/Postbox",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/AudioWaveform",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemView",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageMediaBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatHistoryEntry",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUIPreferences",
        "//submodules/MosaicLayout",
    ],
    visibility = [
        "//visibility:public",
    ],
)
