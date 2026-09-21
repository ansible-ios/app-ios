load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ArchiveInfoScreen",
    module_name = "ArchiveInfoScreen",
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
        "//submodules/Components/SolidRoundedButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/LottieComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
