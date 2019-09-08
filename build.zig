const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("zig-sokol-test", null);
    exe.setBuildMode(mode);
    exe.addCSourceFile("src/sokol.c", [_][]const u8{});
    exe.addCSourceFile("src/clear-sapp.c", [_][]const u8{});
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("X11");
    exe.linkSystemLibrary("GL");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
