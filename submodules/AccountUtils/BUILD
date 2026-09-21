load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AccountUtils",
    module_name = "AccountUtils",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
    ],
    visibility = [
        "//visibility:public",
    ],
)
