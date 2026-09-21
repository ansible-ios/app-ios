load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageShareButton",
    module_name = "ChatMessageShareButton",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/ContextUI",
        "//submodules/Components/HierarchyTrackingLayer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
