load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PremiumPeerShortcutComponent",
    module_name = "PremiumPeerShortcutComponent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/AvatarNode",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/AccountContext",
        "//submodules/IosappUI/Components/EmojiTextAttachmentView",
        "//submodules/TextFormat",
    ],
    visibility = [
        "//visibility:public",
    ],
)
