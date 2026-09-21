load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappIntents",
    module_name = "IosappIntents",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
    	"//submodules/IosappCore:IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AvatarNode:AvatarNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
