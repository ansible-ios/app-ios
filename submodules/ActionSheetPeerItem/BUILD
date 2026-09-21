load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ActionSheetPeerItem",
    module_name = "ActionSheetPeerItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
    ],
    visibility = [
        "//visibility:public",
    ],
)
