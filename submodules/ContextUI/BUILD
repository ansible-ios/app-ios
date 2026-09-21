load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ContextUI",
    module_name = "ContextUI",
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
        "//submodules/TextSelectionNode:TextSelectionNode",
        "//submodules/AppBundle:AppBundle",
        "//submodules/AccountContext:AccountContext",
        "//submodules/ReactionSelectionNode:ReactionSelectionNode",
        "//submodules/Markdown:Markdown",
        "//submodules/TextFormat:TextFormat",
        "//submodules/IosappUI/Components/TextNodeWithEntities:TextNodeWithEntities",
        "//submodules/IosappUI/Components/EntityKeyboard:EntityKeyboard",
        "//submodules/UndoUI:UndoUI",
        "//submodules/AnimationUI:AnimationUI",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/TabSelectorComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
