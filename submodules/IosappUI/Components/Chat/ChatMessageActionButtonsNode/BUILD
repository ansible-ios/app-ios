load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageActionButtonsNode",
    module_name = "ChatMessageActionButtonsNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/UrlHandling",
        "//submodules/IosappUI/Components/TextLoadingEffect",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
