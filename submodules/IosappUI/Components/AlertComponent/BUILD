load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AlertComponent",
    module_name = "AlertComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/Markdown",
        "//submodules/TextFormat",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/MultilineTextWithEntitiesComponent",
        "//submodules/Components/ActivityIndicatorComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
