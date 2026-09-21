load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AlertCheckComponent",
    module_name = "AlertCheckComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/CheckComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
