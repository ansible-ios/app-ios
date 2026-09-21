load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MultilineTextWithEntitiesComponent",
    module_name = "MultilineTextWithEntitiesComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display:Display",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Markdown:Markdown",
        "//submodules/TextFormat:TextFormat",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/TextNodeWithEntities:TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)
