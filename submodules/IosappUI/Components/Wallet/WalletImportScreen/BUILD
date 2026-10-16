load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletImportScreen",
    module_name = "WalletImportScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/PasscodeCore",
        "//submodules/Display",
        "//submodules/LottieSettings:LottieSettings",
        "//submodules/AccountContext",
        "//submodules/Markdown",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/PresentationDataUtils",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/SegmentControlComponent",
        "//submodules/WalletContext",
        "//submodules/IosappUI/Components/Wallet/WalletAuthorizationUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
