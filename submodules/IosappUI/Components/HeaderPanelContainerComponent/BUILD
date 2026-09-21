load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "HeaderPanelContainerComponent",
    module_name = "HeaderPanelContainerComponent",
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
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
