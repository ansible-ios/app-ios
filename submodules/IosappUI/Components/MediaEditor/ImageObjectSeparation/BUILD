load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ImageObjectSeparation",
    module_name = "ImageObjectSeparation",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit",
        "//submodules/Display",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/ImageTransparency",
        "//submodules/IosappUI/Components/AnimationCache/ImageDCT",
        "//submodules/FileMediaResourceStatus",
        "//third-party/ZipArchive:ZipArchive",
    ],
    visibility = [
        "//visibility:public",
    ],
)
