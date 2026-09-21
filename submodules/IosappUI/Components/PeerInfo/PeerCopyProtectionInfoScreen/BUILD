load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerCopyProtectionInfoScreen",
    module_name = "PeerCopyProtectionInfoScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/PresentationDataUtils",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/AppBundle",
        "//submodules/Markdown",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/Gifts/InfoParagraphComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
