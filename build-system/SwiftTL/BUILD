load("@build_bazel_rules_swift//swift:swift.bzl", "swift_binary")

# The TL code generator, built for the host and run by the IosappApiGenerated genrule in
# submodules/IosappApi/BUILD. SwiftPM builds the same sources for the generator's own tests and
# for submodules/IosappApi/generate-swiftpm.sh.
swift_binary(
    name = "SwiftTL",
    module_name = "SwiftTL",
    srcs = glob(["Sources/SwiftTL/**/*.swift"]),
    # SchemaBlob compresses the schema table with zlib.
    linkopts = ["-lz"],
    visibility = ["//submodules/IosappApi:__pkg__"],
)
