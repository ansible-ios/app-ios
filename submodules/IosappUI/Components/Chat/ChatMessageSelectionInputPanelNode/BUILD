load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageSelectionInputPanelNode",
    module_name = "ChatMessageSelectionInputPanelNode",
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
        "//submodules/AppBundle",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/Chat/ChatInputPanelNode",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/IosappUI/Components/Chat/TopMessageReactions",
        "//submodules/ReactionSelectionNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
    ],
    visibility = [
        "//visibility:public",
    ],
)
