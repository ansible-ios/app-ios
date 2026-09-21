load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LocalizedPeerData",
    module_name = "LocalizedPeerData",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
    ],
    visibility = [
        "//visibility:public",
    ],
)
