load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CommunitiesScreen",
    module_name = "CommunitiesScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Display",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappUI/Components/AvatarComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ListActionItemComponent",
        "//submodules/IosappUI/Components/ListSectionComponent",
        "//submodules/IosappUI/Components/Stories/PeerListItemComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
