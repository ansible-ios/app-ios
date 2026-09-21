load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GiftDemoScreen",
    module_name = "GiftDemoScreen",
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
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/SheetComponent",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/ScrollComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/PremiumUI",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/EdgeEffect",
        "//submodules/IosappUI/Components/Gifts/InfoParagraphComponent",        
    ],
    visibility = [
        "//visibility:public",
    ],
)
