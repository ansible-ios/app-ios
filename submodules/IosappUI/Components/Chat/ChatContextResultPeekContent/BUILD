load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatContextResultPeekContent",
    module_name = "ChatContextResultPeekContent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/PhotoResources",
        "//submodules/AppBundle",
        "//submodules/ContextUI",
        "//submodules/SoftwareVideo",
        "//submodules/IosappUI/Components/BatchVideoRendering",
        "//submodules/IosappUI/Components/GifVideoLayer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
