load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "OwnershipTransferController",
    module_name = "OwnershipTransferController",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/PresentationDataUtils",
        "//submodules/AccountContext",
        "//submodules/TextFormat",
        "//submodules/PasswordSetupUI",
        "//submodules/Markdown",
        "//submodules/ActivityIndicator",
        "//submodules/IosappUI/Components/PeerManagement/OldChannelsController",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertInputFieldComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
