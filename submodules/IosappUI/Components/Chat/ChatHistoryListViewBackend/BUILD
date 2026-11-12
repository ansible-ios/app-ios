load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatHistoryListViewBackend",
    module_name = "ChatHistoryListViewBackend",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUI/Components/CoreList:CoreList",
        "//submodules/IosappUI/Components/CoreListComponentHost",
        "//submodules/IosappUI/Components/Chat/ChatMessageItem",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemImpl",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemView",
        "//submodules/IosappCore:IosappCore",
    ],
    visibility = [
        "//visibility:public",
    ],
)
