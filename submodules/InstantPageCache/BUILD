load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "InstantPageCache",
    module_name = "InstantPageCache",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/PersistentStringHash:PersistentStringHash",
        "//submodules/AccountContext:AccountContext",
        "//submodules/UrlHandling:UrlHandling",
    ],
    visibility = [
        "//visibility:public",
    ],
)
