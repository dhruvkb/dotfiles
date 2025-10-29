--[[
Hammerspoon configuration
=========================

This is the main entrypoint for Hammerspoon. It loads modules and sets
up the configuration reload mechanism.
]]--

package.path = package.path .. ";" .. os.getenv("HOME") .. "/dotfiles/hammerspoon/?.lua"

--  __  __           _       _
-- |  \/  | ___   __| |_   _| | ___  ___
-- | |\/| |/ _ \ / _` | | | | |/ _ \/ __|
-- | |  | | (_) | (_| | |_| | |  __/\__ \
-- |_|  |_|\___/ \__,_|\__,_|_|\___||___/

local modules = {}
local moduleNames = {
	"reminders_man",
	"key_pairing",
}

for _, moduleName in ipairs(moduleNames) do
	local module = require("modules."	.. moduleName)

	if module.init then
		module.init()
	end

	if module.start then
		module.start()
	end

	modules[moduleName] = module
end

--  ____      _                 _
-- |  _ \ ___| | ___   __ _  __| |
-- | |_) / _ \ |/ _ \ / _` |/ _` |
-- |  _ <  __/ | (_) | (_| | (_| |
-- |_| \_\___|_|\___/ \__,_|\__,_|

-- Stop all modules and then reload configuration.
function reloadConfig()
	for _, module in pairs(modules) do
		if module.stop then
			module.stop()
		end

		if module.del then
			module.del()
		end
	end

	hs.reload()
end

-- Reload configuration with hotkey.
hs.hotkey.bind({"cmd", "ctrl"}, "H", reloadConfig) -- Cmd ⌘ + Ctrl ⌃ + H

hs.notify.new({title="Hammerspoon", informativeText="Configuration has been reloaded.", autoWithdraw=true, withdrawAfter=5}):send()
