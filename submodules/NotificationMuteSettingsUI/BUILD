load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NotificationMuteSettingsUI",
    module_name = "NotificationMuteSettingsUI",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
    	"//submodules/Display:Display",
        "//submodules/IosappCore:IosappCore",
        "//submodules/IosappPresentationData:IosappPresentationData",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
    ],
    visibility = [
        "//visibility:public",
    ],
)
