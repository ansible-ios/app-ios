load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

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

swift_library(
    name = "IosappPresentationDataTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":IosappPresentationData",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/IosappCore:IosappCore",
        "//submodules/Display:Display",
        "//submodules/Postbox:Postbox",
    ],
)

# The runner MUST pin a real device/OS: the default runner picks an invalid
# device and the test process exits 15. Matches //submodules/ChatMessageBackground:ChatMessageBackgroundTests.
ios_test_runner(
    name = "IosappPresentationDataTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "IosappPresentationDataTests",
    minimum_os_version = "15.0",
    runner = ":IosappPresentationDataTestRunner",
    deps = [
        ":IosappPresentationDataTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
