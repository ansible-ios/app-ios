load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ContextControllerImpl",
    module_name = "ContextControllerImpl",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/AnimationUI",
        "//submodules/AppBundle",
        "//submodules/AsyncDisplayKit",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/ComponentFlow",
        "//submodules/ContextUI",
        "//submodules/Display",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/EntityKeyboard",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/ReactionSelectionNode",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/TextNodeWithEntities",
        "//submodules/TextSelectionNode",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/LensTransition",
        "//submodules/Components/BalancedTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
