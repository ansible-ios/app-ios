load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageTransferBubbleContentNode",
    module_name = "ChatMessageTransferBubbleContentNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/ComponentFlow",
        "//submodules/LottieSettings:LottieSettings",
        "//submodules/Display",
        "//submodules/MetalEngine",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/IosappPresentationData",
        "//submodules/TextFormat",
        "//submodules/LocalizedPeerData",
        "//submodules/IosappStringFormatting",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Premium/PremiumDiamondComponent",
        "//submodules/TextSelectionNode",
        "//submodules/InvisibleInkDustNode",
        "//submodules/ActivityIndicator",
        "//submodules/WalletContext",
        "//submodules/IosappUI/Components/Wallet/WalletCardComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
