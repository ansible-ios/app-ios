load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DeleteChatPeerActionSheetItem",
    module_name = "DeleteChatPeerActionSheetItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
