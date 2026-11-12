load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "VideoChatMicButtonComponent",
    module_name = "VideoChatMicButtonComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/Calls/VoiceChatActionButton",
        "//submodules/IosappUI/Components/Calls/CallScreen",
        "//submodules/MetalEngine",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AccountContext",
        "//submodules/RadialStatusNode",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappCore",
    ],
    visibility = [
        "//visibility:public",
    ],
)
