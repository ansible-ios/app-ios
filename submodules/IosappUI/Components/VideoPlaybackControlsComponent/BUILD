load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "VideoPlaybackControlsComponent",
    module_name = "VideoPlaybackControlsComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/AppBundle",
        "//submodules/ManagedAnimationNode",
        "//submodules/Components/MultilineTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
