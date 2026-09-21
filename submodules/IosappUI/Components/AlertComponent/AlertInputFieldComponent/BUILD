load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AlertInputFieldComponent",
    module_name = "AlertInputFieldComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/TextFormat",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
