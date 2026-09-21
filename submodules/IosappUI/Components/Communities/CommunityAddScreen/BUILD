load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CommunityAddScreen",
    module_name = "CommunityAddScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/ItemListUI",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AvatarComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
