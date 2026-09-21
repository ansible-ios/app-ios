load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CreateBotScreen",
    module_name = "CreateBotScreen",
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
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AccountContext",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/AvatarComponent",
        "//submodules/IosappUI/Components/ListMultilineTextFieldItemComponent",
        "//submodules/Markdown",
    ],
    visibility = [
        "//visibility:public",
    ],
)
