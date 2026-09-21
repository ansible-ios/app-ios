load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatInputMessageAccessoryPanel",
    module_name = "ChatInputMessageAccessoryPanel",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/IosappPresentationData",
        "//submodules/ComponentFlow",
        "//submodules/AccountContext",
        "//submodules/IosappCore",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappUI/Components/Chat/ChatInputAccessoryPanel",
        "//submodules/Display",
        "//submodules/IosappUI/Components/GlassBackgroundComponent",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/Components/MultilineTextWithEntitiesComponent",
        "//submodules/IosappStringFormatting",
        "//submodules/PhotoResources",
        "//submodules/TextFormat",
        "//submodules/IosappUI/Components/CompositeTextNode",
        "//submodules/ChatInterfaceState",
    ],
    visibility = [
        "//visibility:public",
    ],
)
