load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SubcodecMultiAnimationRendererImpl",
    module_name = "SubcodecMultiAnimationRendererImpl",
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
        "//submodules/IosappUI/Components/SubcodecAnimationCacheImpl:SubcodecAnimationCacheImpl",
        "//third-party/subcodec:SubcodecObjC",
    ],
    visibility = [
        "//visibility:public",
    ],
)
