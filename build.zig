const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "lua",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(b.path("src"));
    lib.addIncludePath(b.path("include"));
    lib.linkLibC();

    lib.addCSourceFiles(.{
        .files = &.{
            "src/lapi.c",
            "src/lauxlib.c",
            "src/lbaselib.c",
            "src/lcode.c",
            "src/ldblib.c",
            "src/ldebug.c",
            "src/ldo.c",
            "src/ldump.c",
            "src/lfunc.c",
            "src/lgc.c",
            "src/linit.c",
            "src/liolib.c",
            "src/llex.c",
            "src/lmathlib.c",
            "src/lmem.c",
            "src/loadlib.c",
            "src/lobject.c",
            "src/lopcodes.c",
            "src/loslib.c",
            "src/lparser.c",
            "src/lstate.c",
            "src/lstring.c",
            "src/lstrlib.c",
            "src/ltable.c",
            "src/ltablib.c",
            "src/ltm.c",
            "src/lundump.c",
            "src/lvm.c",
            "src/lzio.c",
        },
    });

    const lua_exe = b.addExecutable(.{
        .name = "lua",
        .target = target,
        .optimize = optimize,
    });

    lua_exe.addIncludePath(b.path("src"));
    lua_exe.addIncludePath(b.path("include"));
    lua_exe.addCSourceFile(.{ .file = b.path("src/lua.c") });
    lua_exe.linkLibrary(lib);
    lua_exe.linkLibC();

    b.installArtifact(lua_exe);

    const luac_exe = b.addExecutable(.{
        .name = "luac",
        .target = target,
        .optimize = optimize,
    });

    luac_exe.addIncludePath(b.path("src"));
    luac_exe.addIncludePath(b.path("include"));
    luac_exe.addCSourceFiles(.{
        .files = &.{ "src/luac.c", "src/print.c" },
    });
    luac_exe.linkLibrary(lib);
    luac_exe.linkLibC();

    b.installArtifact(luac_exe);
}
