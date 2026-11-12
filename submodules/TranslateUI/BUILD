load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "TranslateUI",
    module_name = "TranslateUI",
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
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
        "//submodules/AlertUI:AlertUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/Speak:Speak",
        "//submodules/ManagedAnimationNode:ManagedAnimationNode",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/IosappUIPreferences:IosappUIPreferences",        
        "//submodules/ComponentFlow:ComponentFlow",
        "//submodules/Components/ViewControllerComponent:ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent:MultilineTextComponent",
        "//submodules/Components/MultilineTextWithEntitiesComponent:MultilineTextWithEntitiesComponent",
        "//submodules/Components/BundleIconComponent:BundleIconComponent",
        "//submodules/UndoUI:UndoUI",
        "//submodules/ActivityIndicator:ActivityIndicator",
        "//submodules/ShimmerEffect:ShimmerEffect",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/TextFormat",
        "//submodules/Pasteboard",
        "//submodules/IosappUI/Components/TranslationLanguagesContextMenuContent",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "TranslateUITestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":TranslateUI",
        "//submodules/IosappCore:IosappCore",
    ],
)

ios_test_runner(
    name = "TranslateUITestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "TranslateUITests",
    minimum_os_version = "15.0",
    runner = ":TranslateUITestRunner",
    deps = [
        ":TranslateUITestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
