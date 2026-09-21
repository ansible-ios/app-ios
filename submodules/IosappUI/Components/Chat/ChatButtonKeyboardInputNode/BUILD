load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatButtonKeyboardInputNode",
    module_name = "ChatButtonKeyboardInputNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/WallpaperBackgroundNode",
        "//submodules/IosappUI/Components/ChatControllerInteraction",
        "//submodules/IosappUI/Components/ChatInputNode",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
