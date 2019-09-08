const builtin = @import("builtin");
const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("zig-sokol-test", null);
    exe.setBuildMode(mode);

    if (builtin.os == .linux) {
        exe.linkSystemLibrary("c");
        exe.linkSystemLibrary("X11");
        exe.linkSystemLibrary("GL");

        const c_args = [_][]const u8{};
        exe.addCSourceFile("src/sokol.c", c_args);
        exe.addCSourceFile("src/clear-sapp.c", c_args);
    } else if (builtin.os == .macosx) {
        exe.addFrameworkDir("/System/Library/Frameworks");
        exe.linkFramework("Cocoa");
        exe.linkFramework("OpenGL");
        exe.enableSystemLinkerHack(); // Uses system linker instead of embedded ldd, I think...

        const c_args = [2][]const u8{
            "-ObjC",
            "-fobjc-arc",
        };
        exe.addCSourceFile("src/sokol.c", c_args);
        exe.addCSourceFile("src/clear-sapp.c", c_args);
    }
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
