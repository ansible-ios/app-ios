load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NotificationSoundSelectionUI",
    module_name = "NotificationSoundSelectionUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
    	"//submodules/SSignalKit/SwiftSignalKit:SwiftSignalKit",
        "//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/ItemListUI:ItemListUI",
        "//submodules/AccountContext:AccountContext",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PresentationDataUtils:PresentationDataUtils",
        "//submodules/LegacyMediaPickerUI:LegacyMediaPickerUI",
        "//submodules/UndoUI:UndoUI",
    ],
    visibility = [
        "//visibility:public",
    ],
)
