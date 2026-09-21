load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AccountPeerContextItem",
    module_name = "AccountPeerContextItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/AvatarNode",
        "//submodules/ContextUI",
        "//submodules/AccountContext",
    ],
    visibility = [
        "//visibility:public",
    ],
)
