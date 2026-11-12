load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CommunityRequestsScreen",
    module_name = "CommunityRequestsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Display",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/Communities/CommunityEditScreen",
        "//submodules/IosappUI/Components/Communities/CommunityPrivateChatScreen",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/Stories/PeerListItemComponent",
        "//submodules/UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
