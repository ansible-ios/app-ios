load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "EmptyStateIndicatorComponent",
    module_name = "EmptyStateIndicatorComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/Components/AnimatedStickerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
    ],
    visibility = [
        "//visibility:public",
    ],
)
