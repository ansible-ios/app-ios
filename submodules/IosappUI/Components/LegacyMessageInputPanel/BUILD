load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LegacyMessageInputPanel",
    module_name = "LegacyMessageInputPanel",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/AccountContext",
        "//submodules/LegacyComponents",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/ContextUI",
        "//submodules/TooltipUI",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/ChatEntityKeyboardInputNode",
        "//submodules/IosappUI/Components/MessageInputPanelComponent",
        "//submodules/IosappNotices",
        "//submodules/TextFormat",
        "//submodules/IosappUIPreferences",
        "//submodules/Pasteboard",
        "//submodules/IosappUI/Components/Chat/ChatRichTextEditorComposer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
