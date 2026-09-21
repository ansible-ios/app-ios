load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatPanelsComponent",
    module_name = "ChatPanelsComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore",
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ComponentFlow",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
