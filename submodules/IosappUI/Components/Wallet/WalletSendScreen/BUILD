load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("//build-system/bazel-utils:plist_fragment.bzl", "plist_fragment")

plist_fragment(
    name = "WalletSendAmountMetalSourcesBundleInfoPlist",
    extension = "plist",
    template = """
    <key>CFBundleIdentifier</key>
    <string>org.telegram.WalletSendAmountMetalSources</string>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleName</key>
    <string>WalletSendAmount</string>
    """,
)

apple_resource_bundle(
    name = "WalletSendAmountMetalSourcesBundle",
    infoplists = [":WalletSendAmountMetalSourcesBundleInfoPlist"],
    resources = glob(["Resources/*.metal"]),
)

swift_library(
    name = "WalletSendScreen",
    module_name = "WalletSendScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    data = [":WalletSendAmountMetalSourcesBundle"],
    deps = [
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/AttachmentUI",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/Wallet/WalletSendKeyboardComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/ContextUI",
        "//submodules/Display",
        "//submodules/MetalEngine",
        "//submodules/LocalizedPeerData:LocalizedPeerData",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappStringFormatting",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/AvatarComponent",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertCheckComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertMultilineInputFieldComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/IosappUI/Components/GlassControls",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/Premium/PremiumDiamondComponent",
        "//submodules/IosappUI/Components/ShimmeringMask",
        "//submodules/QrCodeUI",
        "//submodules/WalletContext",
        "//submodules/PasscodeCore",
        "//submodules/IosappUI/Components/Wallet/WalletAuthorizationUI",
        "//submodules/UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
