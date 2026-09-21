load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

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
        "//submodules/MurMurHash32"
    ],
    visibility = [
        "//visibility:public",
    ],
)
