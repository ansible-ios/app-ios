load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageDateAndStatusNode",
    module_name = "ChatMessageDateAndStatusNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/LocalizedPeerData",
        "//submodules/Components/ReactionButtonListComponent",
        "//submodules/Components/ReactionImageComponent",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
