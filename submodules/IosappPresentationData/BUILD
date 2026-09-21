load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappPresentationData",
    module_name = "IosappPresentationData",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/Postbox:Postbox",
        "//submodules/Display:Display",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/MediaResources:MediaResources",
        "//submodules/AppBundle:AppBundle",
        "//submodules/StringPluralization:StringPluralization",
        "//submodules/Sunrise:Sunrise",
        "//submodules/TinyThumbnail:TinyThumbnail",
        "//submodules/FastBlur:FastBlur",
        "//iosapp:PresentationStrings",
    ],
    visibility = [
        "//visibility:public",
    ],
)
