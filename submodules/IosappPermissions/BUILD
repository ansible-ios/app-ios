load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappPermissions",
    module_name = "IosappPermissions",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AccountContext:AccountContext",
        "//submodules/DeviceAccess:DeviceAccess",
    ],
    visibility = [
        "//visibility:public",
    ],
)
