// SPDX-License-Identifier: MIT

const builtin = @import("builtin");

const ffi = @import("ffi.zig");
const default = @import("default.zig");

pub const have_complex_type = true;

pub const Abi = if (builtin.cpu.arch == .sparc64) enum(i32) {
    v9 = 1,
    _,

    pub const default: Abi = .v9;
} else enum(i32) {
    v8 = 1,
    _,

    pub const default: Abi = .v8;
};

pub const Function = if (builtin.cpu.arch == .sparc64) extern struct {
    abi: Abi,
    nargs: c_uint,
    arg_types: ?[*]*ffi.Type,
    rtype: *ffi.Type,
    bytes: c_uint,
    flags: c_uint,
    nfixedargs: c_uint,

    pub usingnamespace @import("function.zig");
} else default.Function(Abi);
