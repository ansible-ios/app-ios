load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DiamondsAvatarComponent",
    module_name = "DiamondsAvatarComponent",
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
        "//submodules/IosappPresentationData",
        "//submodules/PhotoResources",
        "//submodules/AvatarNode",
        "//submodules/AccountContext",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/Gifts/GiftItemComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
