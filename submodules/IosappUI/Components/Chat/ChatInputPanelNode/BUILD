load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatInputPanelNode",
    module_name = "ChatInputPanelNode",
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
        "//submodules/AccountContext",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
    ],
    visibility = [
        "//visibility:public",
    ],
)
