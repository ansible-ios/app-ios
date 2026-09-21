load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CountrySelectionUI",
    module_name = "CountrySelectionUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/SearchBarNode:SearchBarNode",
        "//submodules/AppBundle:AppBundle",
        "//submodules/ComponentFlow",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/SearchInputPanelComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
