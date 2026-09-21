load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(
    "@build_bazel_rules_apple//apple:resources.bzl",
    "apple_resource_bundle",
    "apple_resource_group",
)
load("//build-system/bazel-utils:plist_fragment.bzl",
    "plist_fragment",
)

filegroup(
    name = "StoryPeerListMetalResources",
    srcs = glob([
        "MetalResources/**/*.*",
    ]),
    visibility = ["//visibility:public"],
)

plist_fragment(
    name = "StoryPeerListBundleInfoPlist",
    extension = "plist",
    template =
    """
    <key>CFBundleIdentifier</key>
    <string>org.telegram.StoryPeerList</string>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleName</key>
    <string>StoryPeerList</string>
    """
)

apple_resource_bundle(
    name = "StoryPeerListBundle",
    infoplists = [
        ":StoryPeerListBundleInfoPlist",
    ],
    resources = [
        ":StoryPeerListMetalResources",
    ],
)

swift_library(
    name = "StoryPeerListComponent",
    module_name = "StoryPeerListComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    data = [
        ":StoryPeerListBundle",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/MetalEngine",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/Components/BundleIconComponent",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/AvatarNode",
        "//submodules/ContextUI",
        "//submodules/IosappUI/Components/Stories/StoryContainerScreen",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/IosappUI/Components/ChatListTitleView",
        "//submodules/IosappUI/Components/Utils/AnimatableProperty",
    ],
    visibility = [
        "//visibility:public",
    ],
)
