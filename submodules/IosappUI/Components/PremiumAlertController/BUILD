load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PremiumAlertController",
    module_name = "PremiumAlertController",
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
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/Premium/PremiumStarComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
