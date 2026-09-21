load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "GraphUI",
    module_name = "GraphUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/AppBundle:AppBundle",
        "//submodules/GraphCore:GraphCore",
    ],
    visibility = [
        "//visibility:public",
    ],
)
