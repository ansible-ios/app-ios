load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "IosappPermissionsUI",
    module_name = "IosappPermissionsUI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
    	"//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/Postbox:Postbox",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
        "//submodules/ComponentFlow",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/TextFormat:TextFormat",
        "//submodules/Markdown:Markdown",
        "//submodules/IosappPermissions:IosappPermissions",
        "//submodules/DeviceAccess:DeviceAccess",
        "//submodules/AppBundle:AppBundle",
        "//submodules/AnimatedStickerNode:AnimatedStickerNode",
        "//submodules/IosappAnimatedStickerNode:IosappAnimatedStickerNode",
        "//submodules/IosappUI/Components/ButtonComponent",
    ],
    visibility = [
        "//visibility:public",
    ],
)
