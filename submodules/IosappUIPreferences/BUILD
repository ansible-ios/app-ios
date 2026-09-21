load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappUIPreferences",
    module_name = "IosappUIPreferences",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/Postbox:Postbox",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
    ],
    visibility = [
        "//visibility:public",
    ],
)
