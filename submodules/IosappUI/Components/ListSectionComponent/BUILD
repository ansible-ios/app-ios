load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ListSectionComponent",
    module_name = "ListSectionComponent",
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
        "//submodules/IosappUI/Components/DynamicCornerRadiusView",
    ],
    visibility = [
        "//visibility:public",
    ],
)
