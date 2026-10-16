load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletTransactionItemComponent",
    module_name = "WalletTransactionItemComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/ActivityIndicator",
        "//submodules/Display",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappPresentationData",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/Stars/StarsAvatarComponent",
        "//submodules/IosappUI/Components/Wallet/WalletCollectibleImageComponent",
        "//submodules/WalletContext",
    ],
    visibility = [
        "//visibility:public",
    ],
)
