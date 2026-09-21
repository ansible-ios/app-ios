load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MediaScrubberComponent",
    module_name = "MediaScrubberComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/IosappUI/Components/AudioWaveformComponent",
        "//submodules/UIKitRuntimeUtils",
    ],
    visibility = [
        "//visibility:public",
    ],
)
