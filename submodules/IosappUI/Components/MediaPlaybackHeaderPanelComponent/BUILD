load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MediaPlaybackHeaderPanelComponent",
    module_name = "MediaPlaybackHeaderPanelComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUIPreferences",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/IosappStringFormatting",
        "//submodules/ManagedAnimationNode",
        "//submodules/ContextUI",
        "//submodules/IosappNotices",
        "//submodules/TooltipUI",
        "//submodules/IosappUI/Components/SliderContextItem",
        "//submodules/IosappUI/Components/GlobalControlPanelsContext",
        "//submodules/UndoUI",
        "//submodules/OverlayStatusController",
        "//submodules/PresentationDataUtils",
    ],
    visibility = [
        "//visibility:public",
    ],
)
