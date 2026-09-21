load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GifVideoLayer",
    module_name = "GifVideoLayer",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappUI/Components/BatchVideoRendering",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/PhotoResources",
    ],
    visibility = [
        "//visibility:public",
    ],
)
