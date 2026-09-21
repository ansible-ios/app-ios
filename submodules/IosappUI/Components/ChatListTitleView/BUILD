load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatListTitleView",
    module_name = "ChatListTitleView",
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
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ActivityIndicator:ActivityIndicator",
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/AppBundle",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/Components/ComponentDisplayAdapters:ComponentDisplayAdapters",
    ],
    visibility = [
        "//visibility:public",
    ],
)
