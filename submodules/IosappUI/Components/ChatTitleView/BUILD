load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

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
        "//submodules/AvatarNode",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/ActivityIndicator:ActivityIndicator",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PeerPresenceStatusManager:PeerPresenceStatusManager",
        "//submodules/ChatTitleActivityNode",
        "//submodules/LocalizedPeerData",
        "//submodules/PhoneNumberFormat",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/News/NewsFeedSupport",
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

swift_library(
    name = "ChatTitleViewTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":ChatTitleView",
    ],
)

ios_test_runner(
    name = "ChatTitleViewTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ChatTitleViewTests",
    minimum_os_version = "15.0",
    runner = ":ChatTitleViewTestRunner",
    deps = [
        ":ChatTitleViewTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
