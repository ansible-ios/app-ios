load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AgentConnectScreen",
    module_name = "AgentConnectScreen",
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
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/ActivityIndicatorComponent",
        "//submodules/ActivityIndicator",
        "//submodules/Components/SheetComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ItemListUI",
        "//submodules/Markdown",
        "//submodules/TextFormat",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/NavigationStackComponent",
        "//submodules/IosappUI/Components/ListTextFieldItemComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
