load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ReactionListContextMenuContent",
    module_name = "ReactionListContextMenuContent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display:Display",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/WebPBinding:WebPBinding",
        "//submodules/AnimatedAvatarSetNode:AnimatedAvatarSetNode",
        "//submodules/ContextUI:ContextUI",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/Components/ReactionImageComponent:ReactionImageComponent",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/EmojiStatusComponent:EmojiStatusComponent",
        "//submodules/TextFormat:TextFormat",
    ],
    visibility = [
        "//visibility:public",
    ],
)
