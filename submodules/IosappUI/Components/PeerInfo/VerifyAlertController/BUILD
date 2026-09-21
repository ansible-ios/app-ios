load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "VerifyAlertController",
    module_name = "VerifyAlertController",
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
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/TextFieldComponent",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/PremiumPeerShortcutComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
