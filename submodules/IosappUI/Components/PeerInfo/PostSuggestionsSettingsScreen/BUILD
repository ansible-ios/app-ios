load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PostSuggestionsSettingsScreen",
    module_name = "PostSuggestionsSettingsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AppBundle",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/SwitchComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListSwitchItemComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
        "//submodules/IosappUI/Components/PeerInfo/MessagePriceItem",
        "//submodules/UndoUI",
        "//submodules/ShareController",
    ],
    visibility = [
        "//visibility:public",
    ],
)
