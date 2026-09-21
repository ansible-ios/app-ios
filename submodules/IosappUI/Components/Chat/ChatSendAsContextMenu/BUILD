load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatSendAsContextMenu",
    module_name = "ChatSendAsContextMenu",
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
        "//submodules/IosappPresentationData",
        "//submodules/IosappCore",
        "//submodules/AppBundle",
        "//submodules/ContextUI",
        "//submodules/IosappStringFormatting",
        "//submodules/AvatarNode",
        "//submodules/AccountContext",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/ContextControllerImpl",
    ],
    visibility = [
        "//visibility:public",
    ],
)
