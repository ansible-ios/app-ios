load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerAllowedReactionsScreen",
    module_name = "PeerAllowedReactionsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display:Display",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AppBundle",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/IosappUI/Components/SwitchComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/PremiumLockButtonSubtitleComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/PagerComponent",
        "//submodules/PremiumUI",
        "//submodules/UndoUI",
        "//submodules/TextFormat",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListItemSliderSelectorComponent",
        "//submodules/IosappUI/Components/ListSwitchItemComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
