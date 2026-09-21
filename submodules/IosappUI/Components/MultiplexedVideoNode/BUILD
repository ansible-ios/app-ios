load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MultiplexedVideoNode",
    module_name = "MultiplexedVideoNode",
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
        "//submodules/ContextUI:ContextUI",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/SoftwareVideo:SoftwareVideo",
        "//submodules/IosappUI/Components/BatchVideoRendering",
        "//submodules/IosappUI/Components/GifVideoLayer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
