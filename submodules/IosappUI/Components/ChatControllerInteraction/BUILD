load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatControllerInteraction",
    module_name = "ChatControllerInteraction",
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
        "//submodules/ChatPresentationInterfaceState:ChatPresentationInterfaceState",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/TextSelectionNode:TextSelectionNode",
        "//submodules/ContextUI:ContextUI",
        "//submodules/ChatInterfaceState:ChatInterfaceState",
        "//submodules/UndoUI:UndoUI",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/TextFormat:TextFormat",
        "//submodules/WallpaperBackgroundNode:WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/AnimationCache:AnimationCache",
        "//submodules/IosappUI/Components/MultiAnimationRenderer:MultiAnimationRenderer",
    ],
    visibility = [
        "//visibility:public",
    ],
)
