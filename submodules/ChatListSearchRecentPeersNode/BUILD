load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatListSearchRecentPeersNode",
    module_name = "ChatListSearchRecentPeersNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/Postbox",
        "//submodules/ListSectionHeaderNode:ListSectionHeaderNode",
        "//submodules/HorizontalPeerItem:HorizontalPeerItem",
        "//submodules/MergeLists:MergeLists",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ContextUI:ContextUI",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
