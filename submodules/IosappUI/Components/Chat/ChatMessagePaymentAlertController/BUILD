load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessagePaymentAlertController",
    module_name = "ChatMessagePaymentAlertController",
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
        "//submodules/ComponentFlow",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/TextFormat",
        "//submodules/AvatarNode",
        "//submodules/CheckNode",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappUI/Components/Stars/StarsBalanceOverlayComponent",
        "//submodules/IosappUI/Components/AlertComponent",
        "//submodules/IosappUI/Components/AlertComponent/AlertCheckComponent",
        "//submodules/Markdown",
    ],
    visibility = [
        "//visibility:public",
    ],
)
