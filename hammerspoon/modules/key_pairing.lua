--[[
Key pairing
===========

This module automatically closes brackets and quotes. When text is
selected, it wraps the selection with the paired characters.
]]

local M = {} -- module table

--   ____             __ _
--  / ___|___  _ __  / _(_) __ _
-- | |   / _ \| '_ \| |_| |/ _` |
-- | |__| (_) | | | |  _| | (_| |
--  \____\___/|_| |_|_| |_|\__, |
--                         |___/

M.config = {
	keycodePairs = {
		[25] = { -- 9 key
			shift = { opening = "(", closing = ")" },
		},
		[33] = { -- [ key
			none = { opening = "[", closing = "]" },
			shift = { opening = "{", closing = "}" },
		},
		[43] = { -- , key
			shift = { opening = "<", closing = ">" },
		},
		[39] = { -- ; key
			shift = { opening = '"', closing = '"' },
		},
		[50] = { -- ` key
			none = { opening = "`", closing = "`" },
		},
	},
	timeout = 0.1, -- seconds
	iconSize = { h = 18, w = 18 }, -- pixels

  isEnabled = nil,

	-- The following variables are initialised in function `init`.
	eventTap = nil,

	onIcon = nil,
	offIcon = nil,

	keyBinding = nil,
	menubarItem = nil,
}

--  _   _ _   _ _
-- | | | | |_(_) |___
-- | | | | __| | / __|
-- | |_| | |_| | \__ \
--  \___/ \__|_|_|___/

-- Get the icon from disk using the name and set its dimensions.
function M.getIcon(name)
	local iconPath = "~/dotfiles/hammerspoon/" .. name .. ".png"
	return hs.image.imageFromPath(iconPath):setSize(M.config.iconSize)
end

-- Set the menubar icon based on whether autoclose is enabled or not.
function M.updateIcon()
	if M.config.isEnabled then
		M.config.menubarItem:setIcon(M.config.onIcon)
	else
		M.config.menubarItem:setIcon(M.config.offIcon)
	end
end

-- Type the given text safely.
--
-- This function enters the given text while preventing infinite loops
-- by disabling the event tap temporarily.
function M.safelyType(opening, selection, closing)
	-- Stop listening.
	if M.config.eventTap then
		M.config.eventTap:stop()
	end

	hs.eventtap.keyStrokes(opening)
	if selection and selection ~= "" then
		hs.eventtap.keyStroke({"cmd"}, "v", 0)
		-- Wait for the paste to complete.
		hs.timer.usleep(M.config.timeout * 1e6) -- µs
	end
	hs.eventtap.keyStrokes(closing)

	-- Resume listening.
	hs.timer.doAfter(M.config.timeout, function ()
		if M.config.eventTap then
			M.config.eventTap:start()
		end
	end)
end

-- Get the currently highlighted text.
--
-- This function gets the currently selected text by firing a Cmd ⌘ + C
-- event and watching the clipboard for changes, with a timeout.
--
-- It invokes `callbackFn` with the selected text, if there is any
-- selection in the current window, or an empty string.
function M.getSelection(callbackFn)
  -- Store original clipboard content.
	local originalContent = hs.pasteboard.getContents()
	hs.pasteboard.clearContents()

	hs.eventtap.keyStroke({"cmd"}, "c", 0)
	hs.pasteboard.callbackWhenChanged(M.config.timeout, function (hasChanged)
		if hasChanged then
			local currentContent = hs.pasteboard.getContents() or ""
			callbackFn(currentContent)
		else
			callbackFn("")
		end
		-- Restore original clipboard content.
		hs.pasteboard.setContents(originalContent)
	end)
end

-- Get a customised insertion function.
function M.wrapSelection(opening, closing, callbackFn)
	-- Insert the open-close pair, including any selected text.
	--
	-- This function takes the selected text and safely inserts it wrapped
	-- between the opening and closing characters. It also handles cursor
	-- positioning and selection.
	--
	-- It invokes `callbackFn` with no arguments.
	function inner(selection)
		if selection and selection ~= "" then
			M.safelyType(opening, selection, closing)
			-- Extend the selection to include the open-close pair.
			local length = #selection
			for i = 1, length + 2 do -- +2 for the opening and closing characters
				hs.eventtap.keyStroke({"shift"}, "left", 0)
			end
		else
			M.safelyType(opening, selection, closing)
			-- Move cursor between the open-close pair.
			hs.eventtap.keyStroke({}, "left", 0)
		end

		callbackFn()
	end

	return inner
end

-- Handle key down events.
--
-- This function determines if the pressed key is one of the character
-- pairs that this script should handle. If it is, it handles the key
-- press. If it is not, it lets the event pass through.
function M.handleKeyDown(event)
	local flags = event:getFlags()
	local keyCode = event:getKeyCode()

	-- We handle Shift ⇧ and Opt ⌥ mods. If there is any other mod, we let the
	-- event pass through.
	local hasMods = flags.ctrl or flags.fn or flags.cmd
	if hasMods then
		return false -- Let the event pass through.
	end

	-- Look up the key code in our mapping
	local keyMapping = M.config.keycodePairs[keyCode]
	if not keyMapping then
		return false -- Key code is not handled by this script.
	end

	local pair = nil
	if flags.shift and keyMapping.shift then
		pair = keyMapping.shift
	elseif not flags.shift and keyMapping.none then
		pair = keyMapping.none
	end
	if not pair then
		-- There is no mapping for this keycode - modifier combination.
		return false -- Let the event pass through.
	end

	local wrapFunction = M.wrapSelection(pair.opening, pair.closing, function () end)
	M.getSelection(wrapFunction)

	return true -- Consume the event.
end

--  _____       _                          _       _
-- | ____|_ __ | |_ _ __ _   _ _ __   ___ (_)_ __ | |_
-- |  _| | '_ \| __| '__| | | | '_ \ / _ \| | '_ \| __|
-- | |___| | | | |_| |  | |_| | |_) | (_) | | | | | |_
-- |_____|_| |_|\__|_|   \__, | .__/ \___/|_|_| |_|\__|
--                       |___/|_|

function M.init()
	M.config.onIcon = M.getIcon("autoclose_on")
	M.config.offIcon = M.getIcon("autoclose_off")

	M.config.eventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, M.handleKeyDown)

	M.config.keyBinding = hs.hotkey.new({"cmd", "ctrl", "shift"}, "9", M.toggle) -- equal to "Cmd ⌘" + "Ctrl ⌃" + "("
	M.config.menubarItem = hs.menubar.new()
	M.config.menubarItem:setClickCallback(M.toggle)
end

function M.start()
	M.config.isEnabled = true
	M.config.keyBinding:enable()
	M.config.eventTap:start()
	M.updateIcon()

	hs.alert.show("Key pairing: started")
end

function M.stop()
	M.config.isEnabled = false
	M.config.keyBinding:disable()
	M.config.eventTap:stop()
	M.updateIcon()

	hs.alert.show("Key pairing: stopped")
end

function M.toggle()
	if M.config.isEnabled then
		M.stop()
	else
		M.start()
	end
end

return M
