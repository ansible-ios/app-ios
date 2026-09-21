load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SendInviteLinkScreen",
    module_name = "SendInviteLinkScreen",
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
        "//submodules/ComponentFlow",
        "//submodules/Components/ViewControllerComponent",
        "//submodules/Components/ComponentDisplayAdapters",
        "//submodules/Components/MultilineTextComponent",
        "//submodules/IosappPresentationData",
        "//submodules/AccountContext",
        "//submodules/AppBundle",
        "//submodules/IosappStringFormatting",
        "//submodules/PresentationDataUtils",
        "//submodules/Components/ResizableSheetComponent",
        "//submodules/Components/BundleIconComponent",
        "//submodules/IosappUI/Components/ButtonComponent",
        "//submodules/IosappUI/Components/GlassBarButtonComponent",
        "//submodules/AvatarNode",
        "//submodules/CheckNode",
        "//submodules/Markdown",
        "//submodules/PeerPresenceStatusManager",
        "//submodules/UndoUI",
        "//submodules/AnimatedAvatarSetNode",
        "//submodules/IosappUI/Components/Chat/ChatMessagePaymentAlertController",
    ],
    visibility = [
        "//visibility:public",
    ],
)
