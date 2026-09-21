load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "MusicAlbumArtResources",
    module_name = "MusicAlbumArtResources",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
    	"//submodules/IosappCore:IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/UrlEscaping:UrlEscaping",
    ],
    visibility = [
        "//visibility:public",
    ],
)
