load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NotificationExceptionsScreen",
    module_name = "NotificationExceptionsScreen",
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
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AppBundle:AppBundle",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/ItemListUI",
        "//submodules/ItemListPeerItem",
        "//submodules/ItemListPeerActionItem",
        "//submodules/NotificationSoundSelectionUI",
        "//submodules/SettingsUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
