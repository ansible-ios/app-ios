load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CommunityEditScreen",
    module_name = "CommunityEditScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/AvatarNode",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Display",
        "//submodules/MapResourceToAvatarSizes",
        "//submodules/PeerInfoUI",
        "//submodules/Postbox",
        "//submodules/RadialStatusNode",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AvatarEditorScreen",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/CameraScreen",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListTextFieldItemComponent",
        "//submodules/IosappUI/Components/MediaEditor",
        "//submodules/IosappUI/Components/MediaEditorScreen",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/Settings/PeerSelectionScreen",
        "//submodules/IosappUI/Components/Stories/PeerListItemComponent",
        "//submodules/ItemListUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
