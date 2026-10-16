load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

filegroup(
    name = "PasswordSetupUIResources",
    srcs = glob([
        "Resources/**/*",
    ], exclude = ["Resources/**/.*"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "PasswordSetupUIAssets",
    srcs = glob(["PasswordSetupUIImages.xcassets/**"]),
    visibility = ["//visibility:public"],
)

swift_library(
    name = "PasswordSetupUI",
    module_name = "PasswordSetupUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ProgressNavigationButtonNode:ProgressNavigationButtonNode",
        "//submodules/ActivityIndicator:ActivityIndicator",
        "//submodules/AlertUI:AlertUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/AppBundle:AppBundle",
        "//submodules/OverlayStatusController:OverlayStatusController",
        "//submodules/LottieBinding:LottieBinding",
        "//submodules/LottieSettings:LottieSettings",
        "//submodules/ManagedAnimationNode:ManagedAnimationNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
