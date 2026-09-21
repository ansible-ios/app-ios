load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "EmojiStatusComponent",
    module_name = "EmojiStatusComponent",
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
        "//submodules/Components/HierarchyTrackingLayer:HierarchyTrackingLayer",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView:EmojiTextAttachmentView",
        "//submodules/AccountContext:AccountContext",
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AppBundle:AppBundle",
        "//submodules/TextFormat:TextFormat",
        "//submodules/lottie-ios:Lottie",
        "//submodules/GZip:GZip",
        "//submodules/IosappUIPreferences",
    ],
    visibility = [
        "//visibility:public",
    ],
)
