load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "InteractiveTextComponent",
    module_name = "InteractiveTextComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/TextFormat",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappCore",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/Chat/MessageInlineBlockBackgroundView",
        "//submodules/InvisibleInkDustNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
