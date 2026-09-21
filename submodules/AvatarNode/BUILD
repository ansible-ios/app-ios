load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "AvatarNode",
    module_name = "AvatarNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/Postbox",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/AnimationUI:AnimationUI",
        "//submodules/AppBundle:AppBundle",
        "//submodules/AccountContext:AccountContext",
        "//submodules/Emoji:Emoji",
        "//submodules/TinyThumbnail:TinyThumbnail",
        "//submodules/FastBlur:FastBlur",
        "//submodules/ComponentFlow",
        "//submodules/IosappUI/Components/Stories/AvatarStoryIndicatorComponent",
        "//submodules/DirectMediaImageCache",
    ],
    visibility = [
        "//visibility:public",
    ],
)
