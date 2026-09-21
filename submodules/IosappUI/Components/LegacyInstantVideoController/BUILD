load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LegacyInstantVideoController",
    module_name = "LegacyInstantVideoController",
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
        "//submodules/IosappPresentationData",
        "//submodules/MediaResources",
        "//submodules/LegacyComponents",
        "//submodules/AccountContext",
        "//submodules/LegacyUI",
        "//submodules/ImageCompression",
        "//submodules/LocalMediaResources",
        "//submodules/AppBundle",
        "//submodules/LegacyMediaPickerUI",
        "//submodules/ChatPresentationInterfaceState",
        "//submodules/IosappUI/Components/ChatSendButtonRadialStatusNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)
