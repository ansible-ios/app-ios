load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatInputContextPanelNode",
    module_name = "ChatInputContextPanelNode",
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
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/AccountContext",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
    ],
    visibility = [
        "//visibility:public",
    ],
)
