load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatSearchNavigationContentNode",
    module_name = "ChatSearchNavigationContentNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappCore",
        "//submodules/SearchBarNode",
        "//submodules/LocalizedPeerData",
        "//submodules/AccountContext",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/ActivityIndicator",
    ],
    visibility = [
        "//visibility:public",
    ],
)
