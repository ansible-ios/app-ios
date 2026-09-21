load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatInputTextNode",
    module_name = "ChatInputTextNode",
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
        "//submodules/AppBundle",
        "//submodules/IosappCore",
        "//submodules/IosappUI/Components/Chat/ChatInputTextNode/ChatInputTextViewImpl",
        "//submodules/IosappUI/Components/Chat/MessageInlineBlockBackgroundView",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorCore",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorUIKit",
    ],
    visibility = [
        "//visibility:public",
    ],
)
