load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ReactionButtonListComponent",
    module_name = "ReactionButtonListComponent",
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
        "//submodules/Components/ReactionImageComponent:ReactionImageComponent",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/TextFormat:TextFormat",
        "//submodules/AppBundle",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
