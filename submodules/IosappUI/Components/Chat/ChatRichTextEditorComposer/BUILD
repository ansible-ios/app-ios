load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatRichTextEditorComposer",
    module_name = "ChatRichTextEditorComposer",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AppBundle",
        "//submodules/AsyncDisplayKit",
        "//submodules/ContextUI",
        "//submodules/Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorCore",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorUIKit",
        "//submodules/IosappUI/Components/Chat/ChatInputTextNode",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/CheckNode",
        "//submodules/Pasteboard",
    ],
    visibility = [
        "//visibility:public",
    ],
)
