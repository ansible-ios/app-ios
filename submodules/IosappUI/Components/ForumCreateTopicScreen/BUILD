load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ForumCreateTopicScreen",
    module_name = "ForumCreateTopicScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/ViewControllerComponent:ViewControllerComponent",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AppBundle:AppBundle",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/EntityKeyboard:EntityKeyboard",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/Components/PagerComponent:PagerComponent",
        "//submodules/PremiumUI",
        "//submodules/ProgressNavigationButtonNode",
        "//submodules/IosappUI/Components/SwitchComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
