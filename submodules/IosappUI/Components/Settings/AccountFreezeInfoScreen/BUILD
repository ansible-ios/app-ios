load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AccountFreezeInfoScreen",
    module_name = "AccountFreezeInfoScreen",
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
        "//submodules/AppBundle",
        "//submodules/Components/SheetComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Markdown",
    ],
    visibility = [
        "//visibility:public",
    ],
)
