load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NewSessionInfoScreen",
    module_name = "NewSessionInfoScreen",
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
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/Components/SheetComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/SolidRoundedButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Markdown",
    ],
    visibility = [
        "//visibility:public",
    ],
)
