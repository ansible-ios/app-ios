load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AvatarUploadToastScreen",
    module_name = "AvatarUploadToastScreen",
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
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/AccountContext",
        "//submodules/RadialStatusNode",
        "//submodules/IosappUI/Components/AnimatedTextComponent",
        "//submodules/IosappUI/Components/PlainButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
