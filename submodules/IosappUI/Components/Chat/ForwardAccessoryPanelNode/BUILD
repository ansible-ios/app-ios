load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ForwardAccessoryPanelNode",
    module_name = "ForwardAccessoryPanelNode",
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
        "//submodules/AlertUI",
        "//submodules/PresentationDataUtils",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/IosappNotices",
        "//submodules/IosappStringFormatting",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/Chat/AccessoryPanelNode",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AlertComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
