load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerInfoCoverComponent",
    module_name = "PeerInfoCoverComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/Utils/LokiRng",
        "//submodules/TextFormat",
        "//submodules/AvatarNode",
        "//submodules/Components/BundleIconComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
