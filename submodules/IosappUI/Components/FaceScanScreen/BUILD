load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "FaceScanScreen",
    module_name = "FaceScanScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/PresentationDataUtils",
        "//submodules/TextFormat",
        "//submodules/Markdown",
        "//submodules/Camera",
        "//submodules/FileMediaResourceStatus",
        "//submodules/IosappUIPreferences",
        "//submodules/UndoUI",
        "//submodules/DeviceAccess",
        "//third-party/ZipArchive",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BalancedTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/Components/SheetComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
