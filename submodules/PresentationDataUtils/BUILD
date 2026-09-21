load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PresentationDataUtils",
    module_name = "PresentationDataUtils",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display:Display",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AlertUI:AlertUI",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/SolidRoundedButtonNode:SolidRoundedButtonNode",
        "//submodules/OverlayStatusController:OverlayStatusController",
        "//submodules/IosappUI/Components/AlertComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
