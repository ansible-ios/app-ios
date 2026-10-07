load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DiamondsTransferScreen",
    module_name = "DiamondsTransferScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/ItemListUI",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/SheetComponent",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/Diamonds/DiamondsImageComponent",
        "//submodules/IosappUI/Components/PremiumPeerShortcutComponent",
        "//submodules/IosappUI/Components/Diamonds/DiamondsBalanceOverlayComponent",
        "//submodules/ConfettiEffect",
    ],
    visibility = [
        "//visibility:public",
    ],
)
