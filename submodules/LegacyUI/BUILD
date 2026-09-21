load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "LegacyUI",
    module_name = "LegacyUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SSignalKit",
    	"//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/IosappCore:IosappCore",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/ContextUI:ContextUI",
        "//submodules/Display:Display",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappAudio:IosappAudio",
        "//submodules/DeviceAccess:DeviceAccess",
        "//submodules/LegacyComponents:LegacyComponents",
        "//submodules/StickerResources:StickerResources",
        "//submodules/Camera",
        "//submodules/Utils/DeviceModel",
        "//submodules/TooltipUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
