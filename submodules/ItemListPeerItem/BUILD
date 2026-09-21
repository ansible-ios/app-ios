load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ItemListPeerItem",
    module_name = "ItemListPeerItem",
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
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PeerPresenceStatusManager:PeerPresenceStatusManager",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/ContextUI:ContextUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/AccountContext:AccountContext",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/IosappUI/Components/EmojiStatusComponent:EmojiStatusComponent",
        "//submodules/CheckNode",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)
