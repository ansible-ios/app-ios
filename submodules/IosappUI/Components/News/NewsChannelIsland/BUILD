load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NewsChannelIsland",
    module_name = "NewsChannelIsland",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/News/NewsFeedSupport",
    ],
    visibility = [
        "//visibility:public",
    ],
)
