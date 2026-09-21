load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SearchInputPanelComponent",
    module_name = "SearchInputPanelComponent",
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
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
    ],
    visibility = [
        "//visibility:public",
    ],
)
