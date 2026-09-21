load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "EmojiStatusSelectionComponent",
    module_name = "EmojiStatusSelectionComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/IosappNotices",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EntityKeyboard:EntityKeyboard",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/EmojiStatusComponent:EmojiStatusComponent",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/Components/PagerComponent:PagerComponent",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
        "//submodules/lottie-ios:Lottie",
        "//submodules/TextFormat:TextFormat",
        "//submodules/AppBundle:AppBundle",
        "//submodules/GZip:GZip",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/IosappUI/Components/ChatTimerScreen",
        "//submodules/Components/SheetComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
