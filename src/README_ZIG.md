# Building Lua 5.1 with Zig

This directory contains build scripts to compile Lua 5.1 using the Zig build system, which provides excellent cross-compilation support.

## Prerequisites

1. Install Zig from [https://ziglang.org/download/](https://ziglang.org/download/)
2. Ensure `zig` is in your PATH

## Quick Start

### Windows (64-bit)
```powershell
# Using PowerShell
.\build.ps1

# Or using batch file
.\build.bat

# Or directly with zig
zig build
```

### Cross-Platform Build
```bash
# For current platform
zig build

# For specific targets
zig build -Dtarget=x86_64-windows
zig build -Dtarget=x86_64-linux-gnu
zig build -Dtarget=x86_64-macos
zig build -Dtarget=aarch64-linux-gnu
zig build -Dtarget=aarch64-macos
```

## Build Options

### Optimization Levels
```bash
zig build -Doptimize=Debug      # Debug build
zig build -Doptimize=ReleaseSafe # Release with safety checks
zig build -Doptimize=ReleaseFast # Release optimized for speed
zig build -Doptimize=ReleaseSmall # Release optimized for size
```

### Build Targets
The build system creates three main artifacts:
- `liblua.a` - Static library
- `lua` - Lua interpreter
- `luac` - Lua compiler

## Output Locations
After building, you'll find:
- Executables in: `zig-out/bin/`
- Library in: `zig-out/lib/`

## Running
```bash
# Run lua interpreter
zig build run-lua

# Run lua compiler
zig build run-luac

# Test the build
zig build test
```

## Cross-Compilation Examples

### Build for Windows 64-bit from any platform:
```bash
zig build -Dtarget=x86_64-windows-msvc
```

### Build for Linux ARM64:
```bash
zig build -Dtarget=aarch64-linux-gnu
```

### Build for macOS (Intel):
```bash
zig build -Dtarget=x86_64-macos
```

### Build for macOS (Apple Silicon):
```bash
zig build -Dtarget=aarch64-macos
```

## Platform-Specific Features

The build system automatically sets appropriate compiler flags based on the target:

- **Windows**: Sets `-DLUA_WIN`
- **Linux**: Sets `-DLUA_USE_LINUX`, `-DLUA_USE_POSIX`, `-DLUA_USE_DLOPEN` and links with `dl`, `readline`, etc.
- **macOS**: Sets `-DLUA_USE_MACOSX`, `-DLUA_USE_POSIX` and links with `readline`
- **Other POSIX**: Sets `-DLUA_USE_POSIX`

## Troubleshooting

1. **Zig not found**: Ensure Zig is installed and in your PATH
2. **Build errors**: Make sure you're in the correct directory (lua5.1/src)
3. **Missing libraries on Linux**: Install development packages for readline and ncurses

## Integration

To use the built Lua in your projects:

1. Copy the generated `liblua.a` to your project
2. Include the `lua.h`, `luaconf.h`, `lauxlib.h`, and `lualib.h` headers
3. Link against the static library and platform-specific libraries as needed

## Advantages of Zig Build

- **Cross-compilation**: Easily build for any supported target
- **No external dependencies**: Zig includes its own C compiler
- **Consistent builds**: Same result across different development machines  
- **Fast builds**: Excellent caching and parallelization
- **Static linking**: Easy deployment without runtime dependencies