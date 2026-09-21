load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CocoonInfoScreen",
    module_name = "CocoonInfoScreen",
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
        "//submodules/ComponentFlow",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/AccountContext",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
