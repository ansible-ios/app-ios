load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PollStatsScreen",
    module_name = "PollStatsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/ItemListUI",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/StatisticsUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
