load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DCTMultiAnimationRendererImpl",
    module_name = "DCTMultiAnimationRendererImpl",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
