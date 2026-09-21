load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatTextLinkEditUI",
    module_name = "ChatTextLinkEditUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/IosappPresentationData",
        "//submodules/UrlEscaping",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertMultilineInputFieldComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertWebpagePreviewComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
