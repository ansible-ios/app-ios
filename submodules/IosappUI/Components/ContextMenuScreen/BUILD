load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ContextMenuScreen",
    module_name = "ContextMenuScreen",
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
        "//submodules/Components/ViewControllerComponent",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
    ],
    visibility = [
        "//visibility:public",
    ],
)
