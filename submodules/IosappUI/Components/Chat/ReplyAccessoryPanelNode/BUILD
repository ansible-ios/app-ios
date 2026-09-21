load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ReplyAccessoryPanelNode",
    module_name = "ReplyAccessoryPanelNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/AccountContext",
        "//submodules/LocalizedPeerData",
        "//submodules/PhotoResources",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/Chat/AccessoryPanelNode",
        "//submodules/IosappUI/Components/CompositeTextNode",
        "//submodules/IosappNotices",
    ],
    visibility = [
        "//visibility:public",
    ],
)

