load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageEventLogPreviousDescriptionContentNode",
    module_name = "ChatMessageEventLogPreviousDescriptionContentNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatMessageAttachedContentNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
