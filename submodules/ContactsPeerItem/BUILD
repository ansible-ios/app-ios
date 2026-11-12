load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "ContactsPeerItem",
    module_name = "ContactsPeerItem",
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
        "//submodules/AccountContext:AccountContext",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/CheckNode:CheckNode",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/ItemListPeerItem:ItemListPeerItem",
        "//submodules/PeerPresenceStatusManager:PeerPresenceStatusManager",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/ListSectionHeaderNode:ListSectionHeaderNode",
        "//submodules/ContextUI:ContextUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/Stories/AvatarStoryIndicatorComponent",
        "//submodules/MoreButtonNode",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "ContactsPeerItemTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":ContactsPeerItem",
    ],
)

# The runner MUST pin a real device/OS: the default runner picks an invalid
# device and the test process exits 15.
ios_test_runner(
    name = "ContactsPeerItemTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ContactsPeerItemTests",
    minimum_os_version = "15.0",
    runner = ":ContactsPeerItemTestRunner",
    deps = [
        ":ContactsPeerItemTestsLib",
    ],
)
