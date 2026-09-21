load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappVoip",
    module_name = "IosappVoip",
    srcs = glob([
        "Sources/**/*.swift",
    ], exclude = [
        "Sources/macOS/**/*",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/TgVoipWebrtc:TgVoipWebrtc",
        "//submodules/FFMpegBinding",
        "//submodules/ManagedFile",
        "//submodules/AppBundle",
    ],
    visibility = [
        "//visibility:public",
    ],
)
