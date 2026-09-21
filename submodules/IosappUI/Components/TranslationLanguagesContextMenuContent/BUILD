load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "TranslationLanguagesContextMenuContent",
    module_name = "TranslationLanguagesContextMenuContent",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/LocalizedPeerData",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/ContextUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
