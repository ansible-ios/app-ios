load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CollectionTabItemComponent",
    module_name = "CollectionTabItemComponent",
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
        "//submodules/TextFormat",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/TabSelectorComponent",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
    ],
    visibility = [
        "//visibility:public",
    ],
)
