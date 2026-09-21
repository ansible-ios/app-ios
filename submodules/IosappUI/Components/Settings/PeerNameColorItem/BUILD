load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerNameColorItem",
    module_name = "PeerNameColorItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/MergeLists",
        "//submodules/ItemListUI",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
    ],
    visibility = [
        "//visibility:public",
    ],
)
