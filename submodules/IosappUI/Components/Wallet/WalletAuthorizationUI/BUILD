load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "WalletAuthorizationUI",
    module_name = "WalletAuthorizationUI",
    srcs = glob(["Sources/**/*.swift"]),
    copts = ["-warnings-as-errors"],
    deps = [
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertInputFieldComponent",
        "//submodules/WalletContext",
    ],
    visibility = ["//visibility:public"],
)
