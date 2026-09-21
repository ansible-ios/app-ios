load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ContentReportScreen",
    module_name = "ContentReportScreen",
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
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/ItemListUI",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/SheetComponent",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/NavigationStackComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/ListMultilineTextFieldItemComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
