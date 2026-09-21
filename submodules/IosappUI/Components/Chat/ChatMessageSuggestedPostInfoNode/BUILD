load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageSuggestedPostInfoNode",
    module_name = "ChatMessageSuggestedPostInfoNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItem",
        "//submodules/IosappStringFormatting",
        "//submodules/Markdown",
    ],
    visibility = [
        "//visibility:public",
    ],
)
