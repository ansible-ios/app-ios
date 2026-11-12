load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MediaGrid",
    module_name = "MediaGrid",
    srcs = glob(["Sources/**/*.swift"]),
    deps = [
        "//submodules/IosappUI/Components/CoreList:CoreList",
    ],
    visibility = [
        "//visibility:public",
    ],
)
