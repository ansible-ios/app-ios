load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SinglePhoneInputNode",
    module_name = "SinglePhoneInputNode",
    srcs = glob([
		"Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/AsyncDisplayKit:AsyncDisplayKit",
        "//submodules/Display:Display",
        "//submodules/IosappStringFormatting:IosappStringFormatting",
        "//submodules/PhoneNumberFormat:PhoneNumberFormat",
    ],
    visibility = [
        "//visibility:public",
    ],
)
