"""Pinned WASI SDK for the architecture of the macOS build host."""

def _wasi_sdk_macos_impl(ctx):
    host = ctx.os.arch.lower()
    if host in ["arm64", "aarch64"]:
        arch = "arm64"
        sha256 = "85c997a2665ead91673b5bb88b7d0df3fc8900df3bfa244f720d478187bbdc78"
    elif host in ["x86_64", "amd64"]:
        arch = "x86_64"
        sha256 = "18f3f201ba9734e6a4455b0b6410690395a55e9ffa9f6f5066f66083a94b93b3"
    else:
        fail("Unsupported macOS WASI build host: " + host)
    prefix = "wasi-sdk-33.0-" + arch + "-macos"
    ctx.download_and_extract(
        "https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-33/" + prefix + ".tar.gz",
        "",
        sha256,
        "tar.gz",
        prefix,
        canonical_id = prefix,
    )
    ctx.file("BUILD.bazel", ctx.attr.build_file_content, executable = False)

wasi_sdk_macos = repository_rule(
    implementation = _wasi_sdk_macos_impl,
    configure = True,
    attrs = {"build_file_content": attr.string(mandatory = True)},
)
