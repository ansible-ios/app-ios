load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerInfoChatListPaneNode",
    module_name = "PeerInfoChatListPaneNode",
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
        "//submodules/IosappStringFormatting",
        "//submodules/ShimmerEffect",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/ChatListUI",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoPaneNode",
        "//submodules/DeleteChatPeerActionSheetItem",
        "//submodules/UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
