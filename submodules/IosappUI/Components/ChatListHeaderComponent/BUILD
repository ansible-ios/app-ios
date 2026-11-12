load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatListHeaderComponent",
    module_name = "ChatListHeaderComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/ChatListTitleView",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/AppBundle",
        "//submodules/AsyncDisplayKit",
        "//submodules/AnimationUI",
        "//submodules/IosappUI/Components/Stories/StoryPeerListComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/SearchUI",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/SideColumnLayout",
        "//submodules/IosappUI/Components/NavigationBarComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
