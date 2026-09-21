load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MessagePriceItem",
    module_name = "MessagePriceItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappPresentationData",
        "//submodules/ItemListUI",
        "//submodules/LegacyComponents",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
    ],
    visibility = [
        "//visibility:public",
    ],
)
