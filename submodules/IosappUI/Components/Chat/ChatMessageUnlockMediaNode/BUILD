load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageUnlockMediaNode",
    module_name = "ChatMessageUnlockMediaNode",
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
        "//submodules/AccountContext",
        "//submodules/LocalizedPeerData",
        "//submodules/PhotoResources",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/AvatarNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
