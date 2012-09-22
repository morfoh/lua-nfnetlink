-- Copyright (c) 2012 by Christian Wiese <chris@opensde.org>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-- typedefs
local typedefs = [[
typedef struct nlif_handle nlif_handle;
]]
c_source "typedefs" (typedefs)
-- pass extra C type info to FFI.
ffi_cdef (typedefs)

--
-- nlif handle
--
object "nlif_handle" {
	--
	-- Library setup
	--

	-- open a nlif handle
	constructor {
		c_call "nlif_handle *" "nlif_open" {}
	},

	-- close a nlif handle
	destructor "close" {
		c_method_call "void" "nlif_close" {}
	},

	-- get fd of the nlif handle 
	method "fd" {
		c_method_call "int" "nlif_fd" {}
	},

	-- request a dump of interfaces available in the system 
	method "query" {
		c_method_call "int" "nlif_query" {}
	},

	-- get the name for an ifindex
	method "index2name" {
		var_in { "unsigned int", "ifindex" },
		var_out { "char *", "ifname" },
		c_source "pre_src" [[
  int rc;
  char name[IFNAMSIZ];
		]],
		c_source [[
  rc = nlif_index2name(${this}, ${ifindex}, name);
  if (rc == -1) {
	  lua_pushnil(L);
	  return 1;
  }
  ${ifname} = name;
		]],
	},
}
