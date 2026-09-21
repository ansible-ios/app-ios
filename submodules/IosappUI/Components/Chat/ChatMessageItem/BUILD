load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageItem",
    module_name = "ChatMessageItem",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/Chat/ChatHistoryEntry",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappPresentationData",
    ],
    visibility = [
        "//visibility:public",
    ],
)
