load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageNotificationItem",
    module_name = "ChatMessageNotificationItem",
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
        "//submodules/IosappUIPreferences",
        "//submodules/AvatarNode",
        "//submodules/AccountContext",
        "//submodules/LocalizedPeerData",
        "//submodules/StickerResources",
        "//submodules/PhotoResources",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
