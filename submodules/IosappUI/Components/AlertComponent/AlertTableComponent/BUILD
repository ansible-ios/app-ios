load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AlertTableComponent",
    module_name = "AlertTableComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/Gifts/TableComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
