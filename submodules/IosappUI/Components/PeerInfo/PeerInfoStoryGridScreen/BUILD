load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerInfoStoryGridScreen",
    module_name = "PeerInfoStoryGridScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoVisualMediaPaneNode",
        "//submodules/IosappUI/Components/ChatListHeaderComponent",
        "//submodules/IosappUI/Components/ChatTitleView",
        "//submodules/ContextUI",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/BottomButtonPanelComponent",
        "//submodules/IosappUI/Components/MoreHeaderButton",
        "//submodules/IosappUI/Components/MediaEditorScreen",
        "//submodules/SaveToCameraRoll",
        "//submodules/ShareController",
        "//submodules/OpenInExternalAppUI",
        "//submodules/IosappUI/Components/SaveProgressScreen",
    ],
    visibility = [
        "//visibility:public",
    ],
)
