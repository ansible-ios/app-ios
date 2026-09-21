load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ListComposePollOptionComponent",
    module_name = "ListComposePollOptionComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/IosappCore",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/SliderComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/TextFieldComponent",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/Components/BundleIconComponent",
        "//submodules/CheckNode",
        "//submodules/AccountContext",
        "//submodules/TextFormat",
        "//submodules/PresentationDataUtils",
        "//submodules/PhotoResources",
        "//submodules/LocationResources",
        "//submodules/RadialStatusNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
