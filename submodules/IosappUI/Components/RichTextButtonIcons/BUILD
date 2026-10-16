load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "RichTextButtonIcons",
    module_name = "RichTextButtonIcons",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AppBundle",
        "//submodules/IosappCore",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorCore",
        "//submodules/IosappUI/Components/RichTextEditor:RichTextEditorUIKit",
        "//submodules/IosappUI/Components/RichTextEditorMessageConversion",
    ],
    visibility = [
        "//visibility:public",
    ],
)
