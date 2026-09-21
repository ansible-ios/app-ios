load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SegmentControlComponent",
    module_name = "SegmentControlComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/SegmentedControlNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
