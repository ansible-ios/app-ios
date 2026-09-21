load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "BusinessHoursSetupScreen",
    module_name = "BusinessHoursSetupScreen",
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
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/AccountContext",
        "//submodules/PresentationDataUtils",
        "//submodules/Markdown",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListTextFieldItemComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/LocationUI",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/IosappUI/Components/Settings/TimezoneSelectionScreen",
        "//submodules/IosappUI/Components/ChatTimerScreen",
    ],
    visibility = [
        "//visibility:public",
    ],
)
