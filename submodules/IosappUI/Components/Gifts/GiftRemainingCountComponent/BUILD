load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GiftRemainingCountComponent",
    module_name = "GiftRemainingCountComponent",
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
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/Components/MultilineTextComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
