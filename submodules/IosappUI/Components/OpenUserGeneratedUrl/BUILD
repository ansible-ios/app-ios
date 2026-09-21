load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "OpenUserGeneratedUrl",
    module_name = "OpenUserGeneratedUrl",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/OverlayStatusController",
        "//submodules/UrlWhitelist",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertCheckComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertWebpagePreviewComponent",
        "//submodules/UrlHandling",
    ],
    visibility = [
        "//visibility:public",
    ],
)
