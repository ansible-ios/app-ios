load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "RichTextEditorMediaView",
    module_name = "RichTextEditorMediaView",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/AppBundle:AppBundle",
        "//submodules/IosappCore",
        "//submodules/InstantPageUI",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorCore",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorUIKit",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Display:Display",
        "//submodules/PhotoResources:PhotoResources",
        "//submodules/MediaResources:MediaResources",
        "//submodules/MosaicLayout:MosaicLayout",
        "//submodules/RadialStatusNode:RadialStatusNode",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
