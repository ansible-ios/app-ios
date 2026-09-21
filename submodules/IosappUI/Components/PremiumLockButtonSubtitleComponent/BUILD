load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PremiumLockButtonSubtitleComponent",
    module_name = "PremiumLockButtonSubtitleComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
