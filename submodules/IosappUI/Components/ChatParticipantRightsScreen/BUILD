load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatParticipantRightsScreen",
    module_name = "ChatParticipantRightsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ItemListUI",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListTextFieldItemComponent",
        "//submodules/IosappUI/Components/ListItemComponentAdaptor",
        "//submodules/ItemListAvatarAndNameInfoItem",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemImpl",
        "//submodules/PeerInfoUI",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/RankChatPreviewItem",
    ],
    visibility = [
        "//visibility:public",
    ],
)
