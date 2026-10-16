load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletConnectScreen",
    module_name = "WalletConnectScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AlertUI",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappStringFormatting",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/IosappUI/Components/NavigationStackComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/ScrollComponent",
        "//submodules/TextSelectionNode",
        "//submodules/Pasteboard",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/WalletContext",
        "//submodules/IosappUI/Components/Wallet/WalletCardComponent",
        "//submodules/IosappUI/Components/Wallet/WalletTransactionItemComponent",
        "//submodules/UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
