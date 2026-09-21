load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "BusinessLinkNameAlertController",
    module_name = "BusinessLinkNameAlertController",
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
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertInputFieldComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
