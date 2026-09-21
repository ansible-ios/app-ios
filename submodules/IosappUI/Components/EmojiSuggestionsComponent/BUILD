load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "EmojiSuggestionsComponent",
    module_name = "EmojiSuggestionsComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/TextFormat:TextFormat",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
    ],
    visibility = [
        "//visibility:public",
    ],
)
