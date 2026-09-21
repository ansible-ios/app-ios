load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatEmptyNode",
    module_name = "ChatEmptyNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AppBundle",
        "//submodules/LocalizedPeerData",
        "//submodules/IosappStringFormatting",
        "//submodules/AccountContext",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/Chat/ChatLoadingNode",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Markdown",
        "//submodules/ReactionSelectionNode",
        "//submodules/IosappUI/Components/Chat/ChatMediaInputStickerGridItem",
        "//submodules/PremiumUI",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Components/BundleIconComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
