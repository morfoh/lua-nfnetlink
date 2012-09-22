local nfnl = require("nfnetlink")

local nlif = nfnl.nlif_handle()
print("nlif handle:", nlif)

print("nlif fd:", nlif:fd())

nlif:close()
