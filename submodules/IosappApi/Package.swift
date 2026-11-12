// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "IosappApi",
    platforms: [.macOS(.v10_13)],
    products: [
        .library(name: "IosappApi", targets: ["IosappApi"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "IosappApiObjC",
            path: "ObjC",
            // SwiftPMGenerated (and Sources/SwiftPMGenerated, Tests/SwiftPMGenerated) hold the
            // generated sources, written by generate-swiftpm.sh and gitignored: run it before
            // building. Bazel generates its own.
            sources: ["Sources", "SwiftPMGenerated"],
            publicHeadersPath: "PublicHeaders",
            // The TLObject root implements retain/release itself (MRC); SwiftPM defaults to ARC.
            cSettings: [.unsafeFlags(["-fno-objc-arc"])],
            linkerSettings: [.linkedFramework("Foundation"), .linkedLibrary("z")]),
        .target(
            name: "IosappApi",
            dependencies: ["IosappApiObjC"],
            path: "Sources"),
        .target(
            name: "TLRuntimeFixture",
            dependencies: ["IosappApiObjC"],
            path: "TestSupport/RuntimeFixture",
            cSettings: [.unsafeFlags(["-fno-objc-arc"])]),
        .testTarget(
            name: "IosappApiTests",
            dependencies: ["IosappApi", "IosappApiObjC", "TLRuntimeFixture"],
            path: "Tests"),
    ]
)
