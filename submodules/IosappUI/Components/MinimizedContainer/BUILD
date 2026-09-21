load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MinimizedContainer",
    module_name = "MinimizedContainer",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
	"//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
