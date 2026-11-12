load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NewsScreen",
    module_name = "NewsScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/ContextUI",
        "//submodules/SearchUI",
        "//submodules/SearchBarNode",
        "//submodules/IosappUI/Components/ChatListHeaderComponent",
        "//submodules/IosappUI/Components/NavigationBarComponent",
        "//submodules/IosappUI/Components/ChatListTitleView",
        "//submodules/IosappUI/Components/HorizontalTabsComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/CoreList:CoreList",
        "//submodules/IosappUI/Components/CoreListComponentHost",
        "//submodules/IosappUI/Components/News/NewsFeedSupport",
        "//submodules/IosappUI/Components/News/NewsFeedComponents",
    ],
    visibility = [
        "//visibility:public",
    ],
)
