load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "HorizontalTabsComponent",
    module_name = "HorizontalTabsComponent",
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
        "//submodules/IosappCore",
        "//submodules/AsyncDisplayKit",
        "//submodules/AnimationUI",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextWithEntitiesComponent",
        "//submodules/IosappUI/Components/LiquidLens",
        "//submodules/IosappUI/Components/TextBadgeComponent",
        "//submodules/IosappUI/Components/HeaderPanelContainerComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
