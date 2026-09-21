load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GlassControls",
    module_name = "GlassControls",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/LottieComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
