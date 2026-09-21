load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SuggestedPostApproveAlert",
    module_name = "SuggestedPostApproveAlert",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/ToastComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Components/MultilineTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
