#!/data/data/com.termux/files/usr/bin/bash
# Install the TuxTermux DNF compatibility shim as `dnf`.
# This installs command compatibility only; it does not add RPM support.

set -e

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
TARGET="$PREFIX/bin/dnf"
SOURCE="$SCRIPT_DIR/dnf-compat.sh"

if [ ! -f "$SOURCE" ]; then
    echo "Error: dnf-compat.sh was not found." >&2
    exit 1
fi

mkdir -p "$PREFIX/bin"
cp "$SOURCE" "$TARGET"
chmod 755 "$TARGET"

echo "TuxTermux DNF compatibility shim installed."
echo "Run: dnf --help"
echo "Note: this provides DNF-style commands backed by pkg; RPM packages are not supported."
