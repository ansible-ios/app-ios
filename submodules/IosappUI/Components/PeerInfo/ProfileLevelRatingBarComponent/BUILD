load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ProfileLevelRatingBarComponent",
    module_name = "ProfileLevelRatingBarComponent",
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
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/MultiAnimationRenderer",
        "//submodules/IosappUI/Components/AnimationCache",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/HierarchyTrackingLayer",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/LottieComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
