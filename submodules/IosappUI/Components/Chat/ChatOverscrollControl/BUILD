load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatOverscrollControl",
    module_name = "ChatOverscrollControl",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/ComponentFlow",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/AvatarNode",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)
