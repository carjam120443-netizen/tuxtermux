# DNF compatibility

TuxTermux includes an experimental **DNF command compatibility shim**.

## Status

🚧 Experimental.

The shim translates a small set of familiar DNF commands to TuxTermux's native `pkg` package manager. It does **not** provide RPM package installation or a Fedora userspace.

## Supported commands

```text
dnf install <package>...
dnf remove <package>...
dnf erase <package>...
dnf update
dnf upgrade
dnf search <term>
dnf list installed
dnf --version
dnf --help
```

The implementation is in [`dnf-compat.sh`](./dnf-compat.sh).

## Important

Termux/TuxTermux packages and Fedora RPM packages are different package ecosystems. This compatibility layer only provides familiar command names and translates supported operations to `pkg`.

Future work may add an isolated RPM/Fedora userspace for real DNF support without interfering with the native TuxTermux environment.
