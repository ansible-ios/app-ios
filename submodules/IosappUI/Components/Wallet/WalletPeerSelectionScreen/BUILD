load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletPeerSelectionScreen",
    module_name = "WalletPeerSelectionScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/LottieSettings:LottieSettings",
        "//submodules/AppBundle",
        "//submodules/AsyncDisplayKit",
        "//submodules/ComponentFlow",
        "//submodules/ChatListSearchRecentPeersNode",
        "//submodules/ChatListSearchItemHeader",
        "//submodules/ContextUI",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/ContactsPeerItem",
        "//submodules/Display",
        "//submodules/ItemListUI",
        "//submodules/MergeLists",
        "//submodules/QrCodeUI",
        "//submodules/SearchBarNode",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/UndoUI",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/ChatListHeaderComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/Wallet/WalletSendScreen",
        "//submodules/WalletContext",
    ],
    visibility = [
        "//visibility:public",
    ],
)
