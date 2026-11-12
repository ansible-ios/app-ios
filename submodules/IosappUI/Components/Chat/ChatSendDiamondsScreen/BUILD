load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "ChatSendDiamondsScreen",
    module_name = "ChatSendDiamondsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/ContextUI",
        "//submodules/AppBundle",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/SliderComponent",
        "//submodules/IosappUI/Components/Utils/RoundedRectWithTailPath",
        "//submodules/IosappUI/Components/CheckComponent",
        "//submodules/AvatarNode",
        "//submodules/Components/BundleIconComponent",
        "//submodules/CheckNode",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/Diamonds/DiamondsBalanceOverlayComponent",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/ChatScheduleTimeController",
        "//submodules/IosappUI/Components/Stories/LiveChat/StoryLiveChatMessageComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "ChatSendDiamondsScreenTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":ChatSendDiamondsScreen",
        "//submodules/IosappCore",
    ],
)

ios_test_runner(
    name = "ChatSendDiamondsScreenTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "ChatSendDiamondsScreenTests",
    minimum_os_version = "15.0",
    runner = ":ChatSendDiamondsScreenTestRunner",
    deps = [
        ":ChatSendDiamondsScreenTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
