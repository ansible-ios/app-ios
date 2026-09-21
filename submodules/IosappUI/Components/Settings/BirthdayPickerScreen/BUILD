load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "BirthdayPickerScreen",
    module_name = "BirthdayPickerScreen",
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
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/Components/SheetComponent",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
