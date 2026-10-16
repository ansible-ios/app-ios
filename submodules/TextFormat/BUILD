load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "TextFormat",
    module_name = "TextFormat",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit",
    	"//submodules/IosappCore:IosappCore",
        "//submodules/Display:Display",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/Markdown:Markdown",
        "//submodules/Emoji:Emoji",
        "//third-party/libprisma",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "TextFormatTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":TextFormat",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/Postbox:Postbox",
        # Needed by ReplyMarkupButtonActionTests to construct Api.ButtonType /
        # Api.InlineButtonType values for the shared action mappers.
        "//submodules/IosappApi:IosappApi",
        # Needed by the FlatBuffers round-trip tests: the flatc-generated
        # IosappCore_* types live in the FlatSerialization module.
        "//submodules/IosappCore/FlatSerialization",
        # Needed by SpoilerStrikethroughLayoutTests: TextNode's layout.
        "//submodules/Display:Display",
    ],
)

ios_test_runner(
    name = "TextFormatTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "TextFormatTests",
    minimum_os_version = "15.0",
    runner = ":TextFormatTestRunner",
    deps = [
        ":TextFormatTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
