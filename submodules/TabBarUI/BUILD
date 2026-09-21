load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "TabBarUI",
    module_name = "TabBarUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
    	"//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/TabBarComponent",
        "//submodules/IosappUI/Components/GlassControls",
    ],
    visibility = [
        "//visibility:public",
    ],
)
