load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "TranslateHeaderPanelComponent",
    module_name = "TranslateHeaderPanelComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/LocalizedPeerData",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/MoreButtonNode",
        "//submodules/ContextUI",
        "//submodules/TranslateUI",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappNotices",
        "//submodules/PremiumUI",
        "//submodules/IosappUI/Components/TranslationLanguagesContextMenuContent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
