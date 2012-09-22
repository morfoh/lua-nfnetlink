local nfnl = require("nfnetlink")

local nlif = nfnl.nlif_handle()
print("nlif handle:", nlif)

print("nlif fd:", nlif:fd())
print("nlif query:", nlif:query())

print("nlif index2name:")
local ifidx = -1
repeat
	ifidx = ifidx + 1
	ifname = nlif:index2name(ifidx)
	if ifname then
		print(ifidx, ifname)
	end
until ifname == nil

nlif:close()
