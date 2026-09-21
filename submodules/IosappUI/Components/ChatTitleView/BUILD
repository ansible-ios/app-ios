load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatTitleView",
    module_name = "ChatTitleView",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/LegacyComponents:LegacyComponents",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/ActivityIndicator:ActivityIndicator",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PeerPresenceStatusManager:PeerPresenceStatusManager",
        "//submodules/ChatTitleActivityNode",
        "//submodules/LocalizedPeerData",
        "//submodules/PhoneNumberFormat",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/AnimatedCountLabelNode",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
