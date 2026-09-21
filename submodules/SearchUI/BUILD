load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SearchUI",
    module_name = "SearchUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/SearchBarNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AppBundle",
        "//submodules/ActivityIndicator",
    ],
    visibility = [
        "//visibility:public",
    ],
)
