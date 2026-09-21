load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ChatMessageFactCheckBubbleContentNode",
    module_name = "ChatMessageFactCheckBubbleContentNode",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/AsyncDisplayKit",
        "//submodules/SSignalKit/SwiftSignalKit",
        "//submodules/IosappCore",
        "//submodules/IosappPresentationData",
        "//submodules/IosappStringFormatting",
        "//submodules/TextFormat",
        "//submodules/Geocoding",
        "//submodules/UrlEscaping",
        "//submodules/IosappUI/Components/Chat/ChatMessageDateAndStatusNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageBubbleContentNode",
        "//submodules/IosappUI/Components/Chat/ChatMessageItemCommon",
        "//submodules/IosappUI/Components/Chat/MessageInlineBlockBackgroundView",
        "//submodules/TextSelectionNode",
    ],
    visibility = [
        "//visibility:public",
    ],
)

