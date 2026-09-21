load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ProxyServerPreviewScreen",
    module_name = "ProxyServerPreviewScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/IosappUI/Components/Gifts/TableComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/BundleIconComponent",
        "//submodules/OverlayStatusController",
    ],
    visibility = [
        "//visibility:public",
    ],
)
