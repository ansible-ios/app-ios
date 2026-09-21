load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GiftAnimationComponent",
    module_name = "GiftAnimationComponent",
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
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoCoverComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/UIKitRuntimeUtils",
    ],
    visibility = [
        "//visibility:public",
    ],
)
