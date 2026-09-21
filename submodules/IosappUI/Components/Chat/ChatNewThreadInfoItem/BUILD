load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatNewThreadInfoItem",
    module_name = "ChatNewThreadInfoItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappStringFormatting",
        "//submodules/ComponentFlow",
        "//submodules/Components/BundleIconComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
