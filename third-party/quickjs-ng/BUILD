load("@rules_cc//cc:cc_library.bzl", "cc_library")
load("@rules_cc//cc:cc_test.bzl", "cc_test")
load("@rules_cc//cc:objc_library.bzl", "objc_library")

quickjs_copts = [
    "-O2",
    "-w",
    "-D_GNU_SOURCE",
    "-DQUICKJS_NG_BUILD",
    "-Ithird-party/quickjs-ng/include",
    "-Ithird-party/quickjs-ng/quickjs",
]

cc_library(
    name = "quickjs",
    srcs = [
        "quickjs/quickjs.c",
        "quickjs/dtoa.c",
        "quickjs/libregexp.c",
        "quickjs/libunicode.c",
        "shim/qjs_shim.c",
    ] + glob(["quickjs/*.h"]),
    hdrs = [
        "include/quickjs.h",
        "include/qjs_shim.h",
    ],
    includes = ["include"],
    copts = quickjs_copts,
    visibility = ["//visibility:public"],
)

objc_library(
    name = "CQuickJS",
    module_name = "CQuickJS",
    enable_modules = True,
    hdrs = [
        "include/quickjs.h",
        "include/qjs_shim.h",
    ],
    includes = ["include"],
    deps = [":quickjs"],
    visibility = ["//visibility:public"],
)

cc_test(
    name = "QuickJSSmokeTests",
    srcs = ["tests/quickjs_smoke_test.c"],
    copts = quickjs_copts,
    deps = [":quickjs"],
)

# Fork changes 3-10 and 12 (VENDOR.md): host auto-init properties, class prototypes on first use, string access, a
# host-class global object, host time and randomness, an uncatchable error through a Promise executor, a host hook at the
# memory limit, the host's stop, no dumps without an explicit opt-in.
cc_test(
    name = "QuickJSHostTests",
    srcs = ["tests/quickjs_host_test.c"],
    copts = quickjs_copts,
    deps = [":quickjs"],
)

# The sources :quickjs compiles, for WidgetRuntime's no-I/O scan (NoIOScanTests).
filegroup(
    name = "ScanSources",
    testonly = True,
    srcs = [
        "quickjs/quickjs.c",
        "quickjs/dtoa.c",
        "quickjs/libregexp.c",
        "quickjs/libunicode.c",
        "shim/qjs_shim.c",
    ] + glob(["quickjs/*.h", "include/*.h"]),
    visibility = ["//submodules/IosappUI/Components/MessageWidget/WidgetRuntime:__pkg__"],
)

# Security backports tracked in VENDOR.md: the same native engine and builtin.
cc_test(
    name = "QuickJSSecurityTests",
    srcs = ["tests/quickjs_security_test.c"],
    copts = quickjs_copts,
    data = [
        "tests/security/assert.js",
        "tests/security/bug1795.js",
        "tests/security/bug1835.js",
        "tests/security/direct-eval-closure-var-overflow.js",
        "tests/security/finalizationregistry-unregister-held-target.js",
        "tests/security/map-clear-iterator-value-uaf.js",
        "tests/security/mapped-arguments-var-ref-overflow.js",
        "tests/security/regexp-delete-lastindex-order.js",
        "tests/security/regexp-delete-lastindex-recompile.js",
        "tests/security/weakref-weakmap-value-same-target.js",
        "tests/security/array-fromasync-internal-call.js",
    ],
    args = [
        "$(location tests/security/assert.js)",
        "$(location tests/security/bug1795.js)",
        "$(location tests/security/bug1835.js)",
        "$(location tests/security/direct-eval-closure-var-overflow.js)",
        "$(location tests/security/finalizationregistry-unregister-held-target.js)",
        "$(location tests/security/map-clear-iterator-value-uaf.js)",
        "$(location tests/security/mapped-arguments-var-ref-overflow.js)",
        "$(location tests/security/regexp-delete-lastindex-order.js)",
        "$(location tests/security/regexp-delete-lastindex-recompile.js)",
        "$(location tests/security/weakref-weakmap-value-same-target.js)",
        "$(location tests/security/array-fromasync-internal-call.js)",
    ],
    deps = [":quickjs"],
)
