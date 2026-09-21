load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "StoryStealthModeSheetScreen",
    module_name = "StoryStealthModeSheetScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AccountContext",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/ToastComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/Markdown",
        "//submodules/IosappStringFormatting",
    ],
    visibility = [
        "//visibility:public",
    ],
)
