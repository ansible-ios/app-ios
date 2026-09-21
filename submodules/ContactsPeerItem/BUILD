load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ContactsPeerItem",
    module_name = "ContactsPeerItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/CheckNode:CheckNode",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/ItemListPeerItem:ItemListPeerItem",
        "//submodules/PeerPresenceStatusManager:PeerPresenceStatusManager",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/ListSectionHeaderNode:ListSectionHeaderNode",
        "//submodules/ContextUI:ContextUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/Stories/AvatarStoryIndicatorComponent",
        "//submodules/MoreButtonNode",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)
