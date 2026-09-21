load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ButtonComponent",
    module_name = "ButtonComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/ActivityIndicator",
        "//submodules/ShimmerEffect",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        
    ],
    visibility = [
        "//visibility:public",
    ],
)
