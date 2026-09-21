load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "QuickShareScreen",
    module_name = "QuickShareScreen",
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
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/PresentationDataUtils",
        "//submodules/IosappUI/Components/LottieComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
        "//submodules/AvatarNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
