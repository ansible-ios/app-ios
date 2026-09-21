load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DatePickerNode",
    module_name = "DatePickerNode",
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
        "//submodules/IosappStringFormatting",
        "//submodules/SegmentedControlNode",
        "//submodules/DirectionalPanGesture",
        "//submodules/TextFormat",
    ],
    visibility = [
        "//visibility:public",
    ],
)
