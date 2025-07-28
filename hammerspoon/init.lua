-- Hammerspoon Configuration

package.path = package.path .. ";" .. os.getenv("HOME") .. "/dotfiles/hammerspoon/?.lua"

-- Load key pairs module for automatic bracket and quote pairing
-- local keyPairs = require("key_pairs")
local selectionAlert = require("autoclose")

-- Reload configuration when this file changes
hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/hammerspoon/", function()
    hs.reload()
end):start()

hs.notify.new({title="Hammerspoon", informativeText="Configuration has been reloaded.", autoWithdraw=true, withdrawAfter=5}):send()
