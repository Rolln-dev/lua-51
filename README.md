# Building Lua with Zig

This project uses Zig to build the Lua 5.1.4 source code.  Original lua source code from [Lua Binaries](https://sourceforge.net/projects/luabinaries/files/)

## Prerequisites

- [Zig](https://ziglang.org/download/) (version 0.14.1 or later)

## Building

To build for the host architecture, run the following command in the root directory:

```sh
zig build
```

### Cross-compilation

You can also cross-compile for different architectures. Here are some examples for Windows:

**For 64-bit Windows:**

```sh
zig build -Dtarget=x86_64-windows
```

**For 32-bit Windows:**

```sh
zig build -Dtarget=i386-windows
```

## Artifacts

The build artifacts will be located in the `zig-out` directory:

- **Static Library:** `zig-out/lib/lua.lib` (on Windows) or `zig-out/lib/liblua.a` (on other platforms)
- **Executables:** `zig-out/bin/lua.exe` and `zig-out/bin/luac.exe`
