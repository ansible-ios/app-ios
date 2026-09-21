load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AdminUserActionsSheet",
    module_name = "AdminUserActionsSheet",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/Markdown",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/AvatarNode",
        "//submodules/CheckNode",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertPeerComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
