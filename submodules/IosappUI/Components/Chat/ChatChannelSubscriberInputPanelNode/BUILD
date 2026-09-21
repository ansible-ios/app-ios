load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatChannelSubscriberInputPanelNode",
    module_name = "ChatChannelSubscriberInputPanelNode",
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
        "//submodules/AlertUI",
        "//submodules/PresentationDataUtils",
        "//submodules/UndoUI",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/Chat/ChatInputPanelNode",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/PeerManagement/OldChannelsController",
        "//submodules/TooltipUI",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/GlassControls",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
