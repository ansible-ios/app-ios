load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GroupCallHeaderPanelComponent",
    module_name = "GroupCallHeaderPanelComponent",
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
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/GlobalControlPanelsContext",
        "//submodules/PresentationDataUtils",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/LocalizedPeerData",
        "//submodules/LiveLocationTimerNode",
        "//submodules/IosappStringFormatting",
        "//submodules/AppBundle",
        "//submodules/AnimatedAvatarSetNode",
        "//submodules/AudioBlob",
        "//submodules/IosappCallsUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
