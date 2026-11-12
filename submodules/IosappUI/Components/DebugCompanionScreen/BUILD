load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DebugCompanionScreen",
    module_name = "DebugCompanionScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/CompanionRenderer",
        "//submodules/ComponentFlow",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/ContextUI",
        "//submodules/Display",
        "//submodules/MetalEngine",
        "//submodules/Postbox",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/UndoUI",
        "//submodules/WallpaperBackgroundNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
