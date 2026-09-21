load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ItemListVenueItem",
    module_name = "ItemListVenueItem",
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
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/LocationResources:LocationResources",
        "//submodules/ShimmerEffect:ShimmerEffect",
    ],
    visibility = [
        "//visibility:public",
    ],
)
