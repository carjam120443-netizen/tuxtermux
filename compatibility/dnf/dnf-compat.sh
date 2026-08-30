#!/data/data/com.termux/files/usr/bin/bash
# TuxTermux DNF compatibility shim
#
# This provides a small set of familiar DNF commands by translating them
# to TuxTermux's native package manager. It does NOT install RPM packages.

set -e

if ! command -v pkg >/dev/null 2>&1; then
    echo "Error: TuxTermux 'pkg' command was not found." >&2
    exit 1
fi

case "${1:-}" in
    install)
        shift
        [ "$#" -gt 0 ] || { echo "Usage: dnf install <package>..." >&2; exit 2; }
        exec pkg install "$@"
        ;;
    remove|erase)
        shift
        [ "$#" -gt 0 ] || { echo "Usage: dnf remove <package>..." >&2; exit 2; }
        exec pkg uninstall "$@"
        ;;
    update|upgrade)
        exec pkg upgrade
        ;;
    search)
        shift
        [ "$#" -gt 0 ] || { echo "Usage: dnf search <term>" >&2; exit 2; }
        exec pkg search "$@"
        ;;
    list)
        shift
        case "${1:-}" in
            installed)
                exec pkg list-installed
                ;;
            *)
                echo "Supported: dnf list installed" >&2
                exit 2
                ;;
        esac
        ;;
    --version|version)
        echo "TuxTermux DNF compatibility shim 0.1"
        echo "Backend: pkg"
        echo "Note: RPM/DPKG package formats are not supported by this shim."
        ;;
    --help|help|-h)
        cat <<'EOF'
TuxTermux DNF compatibility shim

Supported commands:
  dnf install <pkg>...    Install packages using pkg
  dnf remove <pkg>...     Remove packages using pkg
  dnf erase <pkg>...      Alias for remove
  dnf update              Upgrade packages using pkg
  dnf upgrade             Alias for update
  dnf search <term>       Search packages using pkg
  dnf list installed      List installed packages
  dnf --version           Show shim version

This is command compatibility only. It does not provide RPM package support.
EOF
        ;;
    *)
        echo "Unsupported DNF command: ${1:-<none>}" >&2
        echo "Run 'dnf --help' for supported commands." >&2
        exit 2
        ;;
esac
