load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MessageInputActionButtonComponent",
    module_name = "MessageInputActionButtonComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/IosappUI/Components/ChatTextInputMediaRecordingButton",
        "//submodules/AccountContext",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/MoreHeaderButton",
        "//submodules/ContextUI",
        "//submodules/Components/ReactionButtonListComponent",
        "//submodules/IosappCore",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
