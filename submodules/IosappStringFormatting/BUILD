load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappStringFormatting",
    module_name = "IosappStringFormatting",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappCore:IosappCore",
        "//submodules/Display:Display",
        "//submodules/PlatformRestrictionMatching:PlatformRestrictionMatching",
        "//submodules/LocalizedPeerData:LocalizedPeerData",
        "//submodules/TextFormat:TextFormat",
        "//submodules/Markdown:Markdown",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AppBundle:AppBundle",
    ],
    visibility = [
        "//visibility:public",
    ],
)
