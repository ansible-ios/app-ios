load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GiftLoadingShimmerView",
    module_name = "GiftLoadingShimmerView",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/MultilineTextWithEntitiesComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/AvatarNode",
        "//submodules/CheckNode",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/Stars/ItemShimmeringLoadingComponent",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoCoverComponent",
        "//submodules/Components/BundleIconComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
