--[[
Reminders manager
=================

This module ensures that the Reminders app stays open and visible in a
specific portion of the screen.
]]

local M = {} -- module table

--   ____             __ _
--  / ___|___  _ __  / _(_) __ _
-- | |   / _ \| '_ \| |_| |/ _` |
-- | |__| (_) | | | |  _| | (_| |
--  \____\___/|_| |_|_| |_|\__, |
--                         |___/

M.config = {
	bundleId = "com.apple.reminders",
	targetRect = { x = 0.667, y = 0.0, w = 0.333, h = 1.0 }, -- fraction of screen

	isEnabled = nil,

	-- The following variables are initialised in function `init`.
	timer = nil,
	wf = nil,
}

--  _   _ _   _ _
-- | | | | |_(_) |___
-- | | | | __| | / __|
-- | |_| | |_| | \__ \
--  \___/ \__|_|_|___/

-- Launch Reminders in the background using its bundle identifier.
function M.launchInBackground()
	hs.task.new(
		"/usr/bin/open",
		nil,
		{"--background", "-b", M.config.bundleId}
	):start()
	hs.timer.usleep(1 --[[ second]] * 1e6)
end

-- Ensure that the Reminders app is running and unhidden.
function M.ensureApp()
	-- Launch Reminders, if not running.
	local app = hs.application.get(M.config.bundleId)
	if not app or not app:isRunning() then
		M.launchInBackground()
		app = hs.application.get(M.config.bundleId)
	end
	if not app then
		print("Failed to launch Reminders app.")
		return
	end

	-- Unhide, if hidden.
	if app:isHidden() then
		app:unhide()
	end
end

-- Ensure that the Reminders window is unminimized and positioned
-- according to the target rectangle.
function M.ensureWindow()
	-- Find a usable window.
	local win = M.config.wf:getWindows()[1]
	if not win then
		print("Failed to find Reminders window.")
		return
	end

	-- Restore, if minimized.
	if win:isMinimized() then
		win:unminimize()
	end

	-- Position it to the target rectangle.
	local screen = win:screen()
	if screen then
		local screenFrame = screen:frame()
		local targetFrame = hs.geometry.unitrect(
			M.config.targetRect.x,
			M.config.targetRect.y,
			M.config.targetRect.w,
			M.config.targetRect.h
		):fromUnitRect(screenFrame)
		win:setFrame(targetFrame, nil, true)
	end
end

-- Ensure that Reminders is running, unhidden, unminimized, and
-- positioned as per target.
function M.ensureReminders()
	-- Remember what currently has focus so we can restore it later.
	local focusedWin = hs.window.focusedWindow()
	local focusedApp = hs.application.frontmostApplication()

	M.ensureApp()
	M.ensureWindow()

	-- Restore focus to previously focused window and app if needed.
	if focusedWin and focusedWin:application() then
		focusedWin:focus()
	elseif focusedApp then
		focusedApp:activate(false) -- best-effort restore
	end
end

--  _____       _                          _       _
-- | ____|_ __ | |_ _ __ _   _ _ __   ___ (_)_ __ | |_
-- |  _| | '_ \| __| '__| | | | '_ \ / _ \| | '_ \| __|
-- | |___| | | | |_| |  | |_| | |_) | (_) | | | | | |_
-- |_____|_| |_|\__|_|   \__, | .__/ \___/|_|_| |_|\__|
--                       |___/|_|

function M.init()
	M.config.wf = hs.window.filter.new(false):setAppFilter("Reminders", {})
	M.config.wf:subscribe(
		{
			hs.window.filter.windowMinimized,
			hs.window.filter.windowHidden,
			hs.window.filter.windowDestroyed,
			hs.window.filter.windowMoved,
		},
		function()
			hs.timer.doAfter(0.05 --[[ seconds ]], M.ensureReminders)
		end
	)
end

function M.start()
	M.config.isEnabled = true
	M.config.wf:resume()

	hs.alert.show("Reminders manager: started")
end

function M.stop()
	M.config.isEnabled = false
	M.config.wf:pause()

	hs.alert.show("Reminders manager: stopped")
end

return M
