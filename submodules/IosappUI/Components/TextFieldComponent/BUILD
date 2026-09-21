load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "TextFieldComponent",
    module_name = "TextFieldComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/TextFormat",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/InvisibleInkDustNode",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/Pasteboard",
        "//submodules/ImageTransparency",
        "//submodules/IosappUI/Components/Chat/ChatInputTextNode",
        "//submodules/TextInputMenu",
        "//submodules/ObjCRuntimeUtils",
        "//submodules/Components/MultilineTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
