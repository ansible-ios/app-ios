load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatScheduleTimeScreen",
    module_name = "ChatScheduleTimeScreen",
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
        "//submodules/AccountContext",
        "//submodules/IosappPresentationData",
        "//submodules/IosappStringFormatting",
        "//submodules/SolidRoundedButtonNode",
        "//submodules/PresentationDataUtils",
        "//submodules/UIKitRuntimeUtils",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/ToastComponent",
        "//submodules/Markdown",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/ComponentDisplayAdapters",
    ],
    visibility = [
        "//visibility:public",
    ],
)
