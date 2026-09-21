load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MessageFeeHeaderPanelComponent",
    module_name = "MessageFeeHeaderPanelComponent",
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
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)
