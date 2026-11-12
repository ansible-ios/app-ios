load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappBaseController",
    module_name = "IosappBaseController",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
    	"//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/AvatarNode:AvatarNode",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/LiveLocationTimerNode:LiveLocationTimerNode",
        "//submodules/AccountContext:AccountContext",
        "//submodules/OverlayStatusController:OverlayStatusController",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/Markdown:Markdown",
        "//submodules/IosappCallsUI:IosappCallsUI",
        "//submodules/ManagedAnimationNode:ManagedAnimationNode",
        "//submodules/IosappNotices:IosappNotices",
        "//submodules/TooltipUI:TooltipUI",
        "//submodules/IosappUI/Components/SliderContextItem:SliderContextItem",
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/Gifts/GiftItemComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
