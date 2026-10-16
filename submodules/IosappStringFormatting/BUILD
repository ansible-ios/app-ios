load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

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

swift_library(
    name = "IosappStringFormattingTestsLib",
    testonly = True,
    srcs = glob(["Tests/**/*.swift"]),
    deps = [
        ":IosappStringFormatting",
        "//submodules/IosappCore:IosappCore",
        "//submodules/Postbox:Postbox",
        "//submodules/TextFormat:TextFormat",
    ],
)

ios_test_runner(
    name = "IosappStringFormattingTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "IosappStringFormattingTests",
    minimum_os_version = "15.0",
    runner = ":IosappStringFormattingTestRunner",
    deps = [":IosappStringFormattingTestsLib"],
    visibility = ["//visibility:public"],
)
