load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "HorizontalPeerItem",
    module_name = "HorizontalPeerItem",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
	    "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/SelectablePeerNode:SelectablePeerNode",
        "//submodules/PeerOnlineMarkerNode:PeerOnlineMarkerNode",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
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
