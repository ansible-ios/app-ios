load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LanguageSelectionScreen",
    module_name = "LanguageSelectionScreen",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappPresentationData",
        "//submodules/MergeLists",
        "//submodules/ItemListUI",
        "//submodules/PresentationDataUtils",
        "//submodules/AccountContext",
        "//submodules/SearchBarNode",
        "//submodules/SearchUI",
        "//submodules/IosappUIPreferences",
        "//submodules/TranslateUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
