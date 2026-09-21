load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatRankInfoScreen",
    module_name = "ChatRankInfoScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/ContextUI",
        "//submodules/AppBundle",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Markdown",
        "//submodules/Components/BundleIconComponent",
        "//submodules/TextFormat",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/RankChatPreviewItem",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
    ],
    visibility = [
        "//visibility:public",
    ],
)
