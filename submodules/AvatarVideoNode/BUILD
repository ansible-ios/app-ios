load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AvatarVideoNode",
    module_name = "AvatarVideoNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AnimationUI:AnimationUI",
        "//submodules/AppBundle:AppBundle",
        "//submodules/AccountContext:AccountContext",
        "//submodules/MediaPlayer:UniversalMediaPlayer",
        "//submodules/IosappUniversalVideoContent:IosappUniversalVideoContent",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/GradientBackground:GradientBackground",
        "//submodules/IosappUI/Components/EntityKeyboard:EntityKeyboard",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
        "//submodules/AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode",
        "//submodules/StickerResources:StickerResources",
    ],
    visibility = [
        "//visibility:public",
    ],
)
