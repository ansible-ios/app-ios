load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

# Packages allowed to depend on Postbox. This list only shrinks: when a refactor wave frees a
# package, remove it here in the same commit (CLAUDE.md, "Postbox -> IosappEngine refactor").
package_group(
    name = "clients",
    packages = [
        "//iosapp",
        "//iosapp/NotificationService",
        "//submodules/AccountContext",
        "//submodules/AvatarNode",
        "//submodules/ChatListUI",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/DirectMediaImageCache",
        "//submodules/FeaturedStickersScreen",
        "//submodules/FetchManagerImpl",
        "//submodules/GalleryUI",
        "//submodules/LegacyMediaPickerUI",
        "//submodules/MediaPlayer",
        "//submodules/PassportUI",
        "//submodules/PhotoResources",
        "//submodules/PremiumUI",
        "//submodules/ShareController",
        "//submodules/ShareItems",
        "//submodules/StatisticsUI",
        "//submodules/StickerResources",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/IosappCallsUI",
        "//submodules/IosappCore",
        "//submodules/IosappPermissionsUI",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleItemNode",
        "//submodules/IosappUI/Components/Chat/ChatRecentActionsController",
        "//submodules/IosappUI/Components/ChatEntityKeyboardInputNode",
        "//submodules/IosappUI/Components/DebugCompanionScreen",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/IosappUI/Components/MediaEditorScreen",
        "//submodules/IosappUI/Components/Resources/FetchVideoMediaResource",
        "//submodules/IosappUI/Components/StickerPickerScreen",
        "//submodules/IosappUI/Components/Stories/StoryContainerScreen",
        "//submodules/IosappUI/Components/IosappAccountAuxiliaryMethods",
        "//submodules/IosappUniversalVideoContent",
        "//submodules/TemporaryCachedPeerDataManager",
    ],
)

# Packages whose remaining Postbox dependency is test targets only.
package_group(
    name = "test_clients",
    packages = [
        "//Tests/ComposerHarness",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/ChatRichTextEditorComposer",
        "//submodules/IosappUI/Components/Chat/EditableTokenListNode",
        "//submodules/IosappUI/Components/PeerInfo/PeerInfoPaneNode",
        "//submodules/IosappUI/Components/RichTextEditorMessageConversion",
        "//submodules/TextFormat",
    ],
)

swift_library(
    name = "Postbox",
    module_name = "Postbox",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Crc32:Crc32",
    	"//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
    	"//submodules/sqlcipher:sqlcipher",
        "//submodules/MurMurHash32:MurMurHash32",
        "//submodules/StringTransliteration:StringTransliteration",
        "//submodules/ManagedFile:ManagedFile",
        "//submodules/Utils/RangeSet:RangeSet",
        "//submodules/CryptoUtils",
        "//submodules/Utils/DarwinDirStat",
    ],
    visibility = [
        ":clients",
        ":test_clients",
    ],
)

swift_library(
    name = "PostboxTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":Postbox",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/sqlcipher:sqlcipher",
    ],
)

ios_test_runner(
    name = "PostboxTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "PostboxTests",
    minimum_os_version = "15.0",
    runner = ":PostboxTestRunner",
    deps = [
        ":PostboxTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
