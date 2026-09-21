load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AuthConfirmationScreen",
    module_name = "AuthConfirmationScreen",
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
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/AvatarComponent",
        "//submodules/Markdown",
        "//submodules/PhoneNumberFormat",
        "//submodules/ContextUI",
        "//submodules/AccountUtils",
        "//submodules/ActivityIndicator",
        "//submodules/IosappUI/Components/PeerInfo/AccountPeerContextItem",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/LottieComponentResourceContent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
