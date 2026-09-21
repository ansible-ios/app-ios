load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatSideTopicsPanel",
    module_name = "ChatSideTopicsPanel",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/AccountContext",
        "//submodules/Components/BlurredBackgroundComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/AvatarNode",
        "//submodules/ChatListUI",
        "//submodules/ContextUI",
        "//submodules/IosappUI/Components/AsyncListComponent",
        "//submodules/IosappUI/Components/TextBadgeComponent",
        "//submodules/IosappUI/Components/MaskedContainerComponent",
        "//submodules/AppBundle",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
