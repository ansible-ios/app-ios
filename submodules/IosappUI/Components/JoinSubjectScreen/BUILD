load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "JoinSubjectScreen",
    module_name = "JoinSubjectScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AppBundle",
        "//submodules/AccountContext",
        "//submodules/Markdown",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappCore",
        "//submodules/AvatarNode",
        "//submodules/IosappStringFormatting",
        "//submodules/AnimatedAvatarSetNode",
        "//submodules/UndoUI",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/CheckComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/EmojiStatusComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
