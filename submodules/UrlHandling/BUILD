load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "UrlHandling",
    module_name = "UrlHandling",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/MtProtoKit:MtProtoKit",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/IosappNotices:IosappNotices",
    ],
    visibility = [
        "//visibility:public",
    ],
)
