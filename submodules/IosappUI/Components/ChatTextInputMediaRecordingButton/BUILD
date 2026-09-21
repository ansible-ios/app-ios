load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatTextInputMediaRecordingButton",
    module_name = "ChatTextInputMediaRecordingButton",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/LegacyComponents",
        "//submodules/AccountContext",
        "//submodules/ChatInterfaceState",
        "//submodules/AudioBlob",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ComponentFlow",
        "//submodules/Components/LottieAnimationComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/LegacyInstantVideoController",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/Components/ComponentDisplayAdapters",
    ],
    visibility = [
        "//visibility:public",
    ],
)
