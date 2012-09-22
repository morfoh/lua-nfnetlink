#!/usr/bin/env lua

package	= 'lua-nfnetlink'
version	= 'scm-0'
source	= {
	url	= 'https://github.com/morfoh/lua-nfnetlink'
}
description	= {
	summary	= "Lua bindings for libnfnetlink.",
	detailed	= '',
	homepage	= 'https://github.com/morfoh/lua-nfnetlink',
	license	= 'MIT',
	maintainer = "Christian Wiese",
}
dependencies = {
	'lua >= 5.1',
}
external_dependencies = {
	NFNETLINK = {
		header = "libnfnetlink/libnfnetlink.h",
		library = "nfnetlink",
	}
}
build	= {
	type = "builtin",
	modules = {
		nfnetlink = {
			sources = { "src/pre_generated-nfnetlink.nobj.c" },
			libraries = { "nfnetlink" },
		}
	}
}
