load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PaymentMethodUI",
    module_name = "PaymentMethodUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display:Display",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/ViewControllerComponent:ViewControllerComponent",
        "//submodules/Components/SheetComponent:SheetComponent",
        "//submodules/Components/LottieAnimationComponent:LottieAnimationComponent",
        "//submodules/Components/AnimatedStickerComponent:AnimatedStickerComponent",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/Components/UndoPanelComponent:UndoPanelComponent",
        "//submodules/Components/SolidRoundedButtonComponent:SolidRoundedButtonComponent",
        "//submodules/AccountContext:AccountContext",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/Components/Forms/PrefixSectionGroupComponent:PrefixSectionGroupComponent",
        "//submodules/Components/Forms/TextInputComponent:TextInputComponent",
        "//submodules/Markdown:Markdown",
        "//submodules/InviteLinksUI:InviteLinksUI",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/UndoUI:UndoUI",
        "//submodules/Stripe:Stripe",
        "//submodules/Components/Forms/CreditCardInputComponent:CreditCardInputComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
