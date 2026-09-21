load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ListMultilineTextFieldItemComponent",
    module_name = "ListMultilineTextFieldItemComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/TextFieldComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/AccountContext",
    ],
    visibility = [
        "//visibility:public",
    ],
)
