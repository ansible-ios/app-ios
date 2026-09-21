load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NotificationPeerExceptionController",
    module_name = "NotificationPeerExceptionController",
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
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/LocalizedPeerData:LocalizedPeerData",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/NotificationSoundSelectionUI:NotificationSoundSelectionUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
