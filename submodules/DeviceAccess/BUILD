load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DeviceAccess",
    module_name = "DeviceAccess",
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
        "//submodules/LegacyComponents:LegacyComponents",
    ],
    visibility = [
        "//visibility:public",
    ],
)
