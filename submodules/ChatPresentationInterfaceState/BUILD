load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatPresentationInterfaceState",
    module_name = "ChatPresentationInterfaceState",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/ContextUI:ContextUI",
        "//submodules/ChatInterfaceState:ChatInterfaceState",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ChatContextQuery",
        "//submodules/TooltipUI",
        "//submodules/AudioWaveform",
        "//submodules/UndoUI",
        "//submodules/TextFormat",
    ],
    visibility = [
        "//visibility:public",
    ],
)
