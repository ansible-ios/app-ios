load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "QuickReactionSetupController",
    module_name = "QuickReactionSetupController",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/AsyncDisplayKit",
        "//submodules/ComponentFlow",
        "//submodules/Display",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/EmojiStatusSelectionComponent",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/ItemListUI",
        "//submodules/Postbox",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/ReactionImageComponent",
        "//submodules/ReactionSelectionNode",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUIPreferences",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/WebPBinding",
    ],
    visibility = [
        "//visibility:public",
    ],
)
