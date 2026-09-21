load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerReportScreen",
    module_name = "PeerReportScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ContextUI",
        "//submodules/UndoUI",
        "//submodules/PresentationDataUtils",
        "//submodules/AlertUI",
        "//submodules/AppBundle",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappPermissionsUI",
        "//submodules/Markdown",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/ShareController",
    ],
    visibility = [
        "//visibility:public",
    ],
)
