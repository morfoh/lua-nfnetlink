-- make generated variable nicer
set_variable_format "%s"

c_module "nfnetlink" {

-- enable FFI bindings support.
luajit_ffi = true,

-- load NFNETLINK shared library.
ffi_load"nfnetlink",

sys_include "libnfnetlink/libnfnetlink.h",

subfiles {
"src/nfnl.nobj.lua",
},
}

