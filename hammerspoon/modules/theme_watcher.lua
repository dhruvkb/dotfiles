--[[
Theme watcher
=============

This module watches macOS's appearance mode and performs actions to align apps
that don't handle the appearance change automatically.

Apps like Ghostty, Zed, and VS Code (specifically workbench color theme) all
take separate light and dark values. This module handles the holdouts.

- Helix: Rewrite `theme` in config and sends `SIGUSR1` to reload.
- VS Code (icon theme) — Rewrites `workbench.iconTheme` in config.

]]--

local M = {} -- module table

--   ____             __ _
--  / ___|___  _ __  / _(_) __ _
-- | |   / _ \| '_ \| |_| |/ _` |
-- | |__| (_) | | | |  _| | (_| |
--  \____\___/|_| |_|_| |_|\__, |
--                         |___/

local home = os.getenv("HOME")

M.config = {
	notificationName = "AppleInterfaceThemeChangedNotification",

	apps = {
		{
			name = "Helix",
			path = home .. "/dotfiles/helix/config.toml",
			pattern = 'theme = "[^"]*"',
			dark = 'theme = "catppuccin_mocha"',
			light = 'theme = "catppuccin_latte"',
			-- Helix reloads its config on SIGUSR1. `|| true` keeps the call
			-- silent when no hx process is running. `-x` requires an exact
			-- process-name match so we don't signal unrelated binaries.
			postCmd = "/usr/bin/pkill -USR1 -x hx || true",
		},
		{
			name = "VS Code icon theme",
			path = home .. "/dotfiles/Code/User/settings.json",
			pattern = '"workbench%.iconTheme": "[^"]*"',
			dark = '"workbench.iconTheme": "catppuccin-mocha"',
			light = '"workbench.iconTheme": "catppuccin-latte"',
		},
	},

	-- The following variables are initialised in function `init`.
	watcher = nil,
}

--  _   _ _   _ _
-- | | | | |_(_) |___
-- | | | | __| | / __|
-- | |_| | |_| | \__ \
--  \___/ \__|_|_|___/

-- True when macOS is currently in Dark Mode.
function M.isDark()
	return hs.host.interfaceStyle() == "Dark"
end

-- Rewrite a single line in `path` from `pattern` to `replacement`. No-op
-- if the file is missing or the substitution leaves contents unchanged
-- (keeps mtimes stable so editors don't see spurious reloads).
function M.substituteInFile(path, pattern, replacement)
	local f = io.open(path, "r")
	if not f then return false end
	local contents = f:read("*a")
	f:close()

	local updated, count = contents:gsub(pattern, replacement, 1)
	if count == 0 or updated == contents then return false end

	f = io.open(path, "w")
	if not f then return false end
	f:write(updated)
	f:close()
	return true
end

-- Apply the macOS appearance to every managed app.
function M.apply()
	local isDark = M.isDark()
	for _, app in ipairs(M.config.apps) do
		local replacement = isDark and app.dark or app.light
		local changed = M.substituteInFile(app.path, app.pattern, replacement)
		if changed and app.postCmd then
			hs.execute(app.postCmd)
		end
	end
end

--  _____       _                          _       _
-- | ____|_ __ | |_ _ __ _   _ _ __   ___ (_)_ __ | |_
-- |  _| | '_ \| __| '__| | | | '_ \ / _ \| | '_ \| __|
-- | |___| | | | |_| |  | |_| | |_) | (_) | | | | | |_
-- |_____|_| |_|\__|_|   \__, | .__/ \___/|_|_| |_|\__|
--                       |___/|_|

function M.init()
	M.config.watcher = hs.distributednotifications.new(function()
		M.apply()
	end, M.config.notificationName)
end

function M.start()
	if M.config.watcher then
		M.config.watcher:start()
	end
	-- Sync once on load so configs match the current appearance even if it
	-- changed while Hammerspoon was reloading.
	M.apply()

	hs.alert.show("Theme watcher: started")
end

function M.stop()
	if M.config.watcher then
		M.config.watcher:stop()
	end

	hs.alert.show("Theme watcher: stopped")
end

return M
