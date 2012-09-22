local nfnl = require("nfnetlink")

local nlif = nfnl.nlif_handle()
print("nlif handle:", nlif)

print("nlif fd:", nlif:fd())
print("nlif query:", nlif:query())

print("nlif index2name/get_ifflags:")
print("index", "name", "flags")
local ifidx = -1
repeat
	ifidx = ifidx + 1
	local ifname = nlif:index2name(ifidx)
	if ifname then
		local ifflags = nlif:get_ifflags(ifidx)
		print(ifidx, ifname, ifflags)
	end
until ifname == nil

nlif:close()
