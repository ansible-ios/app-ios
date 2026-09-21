load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CollectibleItemInfoScreen",
    module_name = "CollectibleItemInfoScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/Components/SheetComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/SolidRoundedButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Markdown",
        "//submodules/IosappStringFormatting",
        "//submodules/AvatarNode",
        "//submodules/PhoneNumberFormat",
        "//submodules/UndoUI",
        "//submodules/IosappUI/Components/LottieComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
