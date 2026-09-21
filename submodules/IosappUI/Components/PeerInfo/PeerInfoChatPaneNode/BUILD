load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerInfoChatPaneNode",
    module_name = "PeerInfoChatPaneNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/IosappStringFormatting",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoPaneNode",
        "//submodules/ContextUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
