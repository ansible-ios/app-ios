load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "TabBarComponent",
    module_name = "TabBarComponent",
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
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/TextBadgeComponent",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/IosappUI/Components/LiquidLens",
        "//submodules/AppBundle",
        "//submodules/SearchBarNode",
        "//submodules/IosappUI/Components/TabSelectionRecognizer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
