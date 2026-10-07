load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "DiamondsParticleEffect",
    module_name = "DiamondsParticleEffect",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/Display",
        "//submodules/ComponentFlow",
    ],
    visibility = [
        "//visibility:public",
    ],
)
