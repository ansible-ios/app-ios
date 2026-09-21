load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ListItemSliderSelectorComponent",
    module_name = "ListItemSliderSelectorComponent",
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
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/SliderComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
