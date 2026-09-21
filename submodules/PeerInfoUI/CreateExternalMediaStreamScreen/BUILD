load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CreateExternalMediaStreamScreen",
    module_name = "CreateExternalMediaStreamScreen",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/PresentationDataUtils",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/Components/AnimatedStickerComponent",
        "//submodules/Components/ActivityIndicatorComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
