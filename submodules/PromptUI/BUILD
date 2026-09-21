load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PromptUI",
    module_name = "PromptUI",
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
        "//submodules/IosappStringFormatting",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertMultilineInputFieldComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
