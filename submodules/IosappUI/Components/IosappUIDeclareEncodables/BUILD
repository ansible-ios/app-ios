load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappUIDeclareEncodables",
    module_name = "IosappUIDeclareEncodables",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore",
        "//submodules/TemporaryCachedPeerDataManager",
        "//submodules/IosappUIPreferences",
        "//submodules/IosappNotices",
        "//submodules/InstantPageUI",
        "//submodules/AccountContext",
        "//submodules/LocalMediaResources",
        "//submodules/InstantPageCache",
        "//submodules/SettingsUI",
        "//submodules/WallpaperResources",
        "//submodules/MediaResources",
        "//submodules/LocationUI",
        "//submodules/ChatInterfaceState",
        "//submodules/ICloudResources",
    ],
    visibility = [
        "//visibility:public",
    ],
)
