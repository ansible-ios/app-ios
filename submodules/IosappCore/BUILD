load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple/testing/default_runner:ios_test_runner.bzl", "ios_test_runner")

swift_library(
    name = "IosappCore",
    module_name = "IosappCore",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappApi:IosappApi",
        "//submodules/MtProtoKit:MtProtoKit",
        "//submodules/MediaPreuploadRegistry:MediaPreuploadRegistry",
        "//submodules/WebProxyTransport:WebProxyTransport",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Postbox:Postbox",
        "//submodules/CloudData:CloudData",
        "//submodules/EncryptionProvider:EncryptionProvider",
        "//submodules/CryptoUtils:CryptoUtils",
        "//submodules/NetworkLogging:NetworkLogging",
        "//submodules/Reachability:Reachability",
        "//submodules/ManagedFile:ManagedFile",
        "//submodules/Utils/RangeSet:RangeSet",
        "//submodules/Utils/DarwinDirStat",
        "//submodules/Emoji",
        "//submodules/IosappCore/FlatBuffers",
        "//submodules/IosappCore/FlatSerialization",
        "//submodules/MurMurHash32",
    ],
    visibility = [
        "//visibility:public",
    ],
)

swift_library(
    name = "IosappCoreTestsLib",
    testonly = True,
    srcs = glob([
        "Tests/**/*.swift",
    ]),
    deps = [
        ":IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappApi:IosappApi",
        "//submodules/MtProtoKit:MtProtoKit",
        "//submodules/Postbox:Postbox",
        "//submodules/WebProxyTransport:WebProxyTransport",
    ],
)

ios_test_runner(
    name = "IosappCoreTestRunner",
    device_type = "iPhone 17",
    os_version = "26.5",
)

ios_unit_test(
    name = "IosappCoreTests",
    minimum_os_version = "15.0",
    runner = ":IosappCoreTestRunner",
    deps = [
        ":IosappCoreTestsLib",
    ],
    visibility = [
        "//visibility:public",
    ],
)
