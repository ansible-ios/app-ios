#!/bin/bash
# Build + install + launch Ansible iOS on the booted iPhone Simulator.
# Usage: ./run-on-sim.sh
#
# Why this exists: Xcode UI build (Cmd+B) currently breaks at the
# rules_xcodeproj copy phase when target_environments = ["simulator"]
# (it looks for swiftdoc/swiftmodule in Objects-normal/arm64/ but bazel
# emits arm64-apple-ios-simulator/). The bazel CLI path works fine —
# this script wraps it.

set -euo pipefail

cd "$(dirname "$0")"

BAZEL="$HOME/.local/bin/bazel"
BUNDLE_ID="app.behappy.messenger"

echo "==> bazel build //iosapp:iosapp (sim_arm64)"
"$BAZEL" build //iosapp:iosapp \
  --cpu=ios_sim_arm64 \
  --apple_platform_type=ios \
  --//iosapp:disableProvisioningProfiles \
  --//iosapp:disableExtensions \
  --//iosapp:disableStripping

IPA="bazel-bin/iosapp/iosapp.ipa"
[ -f "$IPA" ] || { echo "ipa not found at $IPA"; exit 1; }

EXTRACT_DIR="$(mktemp -d -t iosapp-extract-XXXXXX)"
trap 'rm -rf "$EXTRACT_DIR"' EXIT
unzip -q -o "$IPA" -d "$EXTRACT_DIR"
APP_PATH="$EXTRACT_DIR/Payload/iosapp.app"

echo "==> boot simulator (if needed)"
xcrun simctl bootstatus booted >/dev/null 2>&1 || {
  # pick first iPhone in list if none booted
  DEVICE=$(xcrun simctl list devices available | grep -E "iPhone [0-9]+ \(" | head -1 | sed -E 's/.*\(([A-F0-9-]+)\).*/\1/')
  echo "    booting $DEVICE"
  xcrun simctl boot "$DEVICE" || true
}

echo "==> install $APP_PATH"
xcrun simctl install booted "$APP_PATH"

echo "==> launch $BUNDLE_ID"
xcrun simctl launch booted "$BUNDLE_ID"

open -a Simulator
