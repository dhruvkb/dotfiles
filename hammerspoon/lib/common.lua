--[[
Common utilities
================

This module contains shared helpers used by other modules. This file should only
contain functions that are used by more than one module.
]]

local M = {} -- module table

-- Directory under the dotfiles repo where Hammerspoon assets live.
M.assetsPath = "~/dotfiles/hammerspoon/assets"

-- Default size for menu bar icons (pixels).
M.defaultIconSize = { h = 18, w = 18 }

-- Load a menu bar icon by name (no extension) from the assets path. Returns
-- the image sized for the menu bar, or nil if the file is missing.
-- `image:setSize` returns a new image rather than mutating in place, so the
-- return value must be captured.
function M.getIcon(name, size)
	local iconPath = M.assetsPath .. "/" .. name .. ".png"
	local image = hs.image.imageFromPath(iconPath)
	return image and image:setSize(size or M.defaultIconSize)
end

-- Default debounce delay for window-filter callbacks (seconds).
M.defaultDebounce = 0.05

-- Subscribe a window-filter callback that runs after a short debounce. This
-- prevents tight loops when the callback re-triggers the filter (e.g.,
-- positioning a window fires windowMoved) and absorbs noisy event bursts.
function M.subscribeDebounced(wf, events, callback, delay)
	delay = delay or M.defaultDebounce
	wf:subscribe(events, function(...)
		local args = table.pack(...)
		hs.timer.doAfter(delay, function()
			callback(table.unpack(args, 1, args.n))
		end)
	end)
end

return M
