#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
OUTPUT_DIR=${1:-"$ROOT_DIR/dist"}
mkdir -p "$OUTPUT_DIR"
OUTPUT_DIR=$(CDPATH= cd -- "$OUTPUT_DIR" && pwd)
PACKAGE_DIR=$(mktemp -d)
PLUGIN_DIR="$PACKAGE_DIR/factory-utility-platform"

cleanup() {
  rm -rf "$PACKAGE_DIR"
}
trap cleanup EXIT INT TERM

mkdir -p "$PLUGIN_DIR"
cp "$ROOT_DIR/factory-utility-platform.php" "$ROOT_DIR/uninstall.php" "$ROOT_DIR/composer.json" "$ROOT_DIR/composer.lock" "$ROOT_DIR/readme.txt" "$ROOT_DIR/build-manifest.json" "$PLUGIN_DIR/"
cp -R "$ROOT_DIR/src" "$ROOT_DIR/assets" "$PLUGIN_DIR/"
COMPOSER_DISABLE_NETWORK=1 composer install --working-dir="$PLUGIN_DIR" --no-dev --classmap-authoritative --no-interaction --no-plugins --no-scripts --quiet

# The review ZIP carries only the approved Home Dashboard browser fixture.
# The production build profile must exclude this directory and remains unauthorized.
mkdir -p "$PLUGIN_DIR/tests/Fixtures"
cp -R "$ROOT_DIR/tests/Fixtures/HomeDashboard" "$PLUGIN_DIR/tests/Fixtures/"

ARCHIVE="$OUTPUT_DIR/factory-utility-platform-1.0.0-qa.zip"
rm -f "$ARCHIVE"
(cd "$PACKAGE_DIR" && zip -q -r "$ARCHIVE" factory-utility-platform)
shasum -a 256 "$ARCHIVE" > "$ARCHIVE.sha256"
printf '%s\n' "$ARCHIVE"
