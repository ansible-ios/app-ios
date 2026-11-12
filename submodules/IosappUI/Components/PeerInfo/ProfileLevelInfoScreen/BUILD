load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ProfileLevelInfoScreen",
    module_name = "ProfileLevelInfoScreen",
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
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/PremiumUI",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/Utils/RoundedRectWithTailPath",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/PeerInfo/ProfileLevelRatingBarComponent",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
