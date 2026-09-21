load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerMessagesMediaPlaylist",
    module_name = "PeerMessagesMediaPlaylist",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappUIPreferences",
        "//submodules/AccountContext",
        "//submodules/MusicAlbumArtResources",
        "//submodules/TextFormat",
    ],
    visibility = [
        "//visibility:public",
    ],
)
