load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletCollectibleScreen",
    module_name = "WalletCollectibleScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/ContextUI",
        "//submodules/Display",
        "//submodules/PasscodeCore",
        "//submodules/PresentationDataUtils",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/AvatarComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/Gifts/TableComponent",
        "//submodules/IosappUI/Components/GlassControls",
        "//submodules/IosappUI/Components/Wallet/WalletCollectibleHeaderComponent",
        "//submodules/IosappUI/Components/Wallet/WalletAuthorizationUI",
        "//submodules/IosappUI/Components/Wallet/WalletPagerComponent",
        "//submodules/IosappUI/Components/Wallet/WalletPeerSelectionScreen",
        "//submodules/WalletContext",
        "//submodules/TooltipUI",
        "//submodules/UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
