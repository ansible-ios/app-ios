load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PhotoResources",
    module_name = "PhotoResources",
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
        "//submodules/Display:Display",
        "//submodules/ImageTransparency:ImageTransparency",
        "//submodules/TinyThumbnail:TinyThumbnail",
        "//submodules/ImageBlur:ImageBlur",
        "//submodules/Tuples:Tuples",
        "//submodules/AccountContext:AccountContext",
        "//submodules/MediaResources:MediaResources",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/WebPBinding:WebPBinding",
        "//submodules/AppBundle:AppBundle",
        "//submodules/MusicAlbumArtResources:MusicAlbumArtResources",
        "//submodules/Svg/LegacyImpl",
        "//submodules/Utils/RangeSet:RangeSet",
        "//submodules/ImageCompression",
    ],
    visibility = [
        "//visibility:public",
    ],
)
