load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "PeerAvatarGalleryUI",
    module_name = "PeerAvatarGalleryUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/ComponentFlow",
        "//submodules/ContextUI:ContextUI",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
    	"//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AccountContext:AccountContext",
        "//submodules/GalleryUI:GalleryUI",
        "//submodules/IosappUIPreferences:IosappUIPreferences",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PhotoResources:PhotoResources",
        "//submodules/RadialStatusNode:RadialStatusNode",
        "//submodules/ShareController:ShareController",
        "//submodules/IosappUI/Components/GlassControls",
        "//submodules/AppBundle:AppBundle",
        "//submodules/LegacyComponents:LegacyComponents",
        "//submodules/LegacyMediaPickerUI:LegacyMediaPickerUI",
        "//submodules/SaveToCameraRoll:SaveToCameraRoll",
        "//submodules/UndoUI:UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
