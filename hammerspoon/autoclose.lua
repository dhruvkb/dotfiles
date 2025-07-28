-- Hammerspoon script for automatic closing of brackets and quotes
--
-- Features:
-- - If an opening character is typed, the corresponding closing
--   character is automatically added. The cursor is placed between the
--   opening and closing characters.
-- - If some text is selected, it will be wrapped in the opening and
--   closing characters. The selection will expand to include the
--   opening and closing characters.

local CHARACTER_PAIRS = {
	["("] = ")",
	["{"] = "}",
	["["] = "]",
	["<"] = ">",
	['"'] = '"',
	["`"] = "`",
}
local TIMEOUT = 0.1 -- seconds
local ICON_SIZE = { h = 18, w = 18 }

--   ____ _       _           _
--  / ___| | ___ | |__   __ _| |___
-- | |  _| |/ _ \| '_ \ / _` | / __|
-- | |_| | | (_) | |_) | (_| | \__ \
--  \____|_|\___/|_.__/ \__,_|_|___/

local eventTap = nil -- tap for key press events
local menubarItem = hs.menubar.new()

--  _   _ _   _ _
-- | | | | |_(_) |___
-- | | | | __| | / __|
-- | |_| | |_| | \__ \
--  \___/ \__|_|_|___/

-- Get the icon from disk using the name and set its dimensions.
function getIcon(name)
	local iconPath = "~/dotfiles/hammerspoon/" .. name .. ".png"
	return hs.image.imageFromPath(iconPath):setSize(ICON_SIZE)
end

local onIcon = getIcon("autoclose_on")
local offIcon = getIcon("autoclose_off")

-- Set the menubar icon based on whether autoclose is enabled or not.
function setIcon(enabled)
	if enabled then
		menubarItem:setIcon(onIcon)
	else
		menubarItem:setIcon(offIcon)
	end
end

-- Type the given text safely.
--
-- This function enters the given text while preventing infinite loops
-- by disabling the event tap temporarily.
function safelyType(opening, selection, closing)
	-- Stop listening.
	if eventTap then
		eventTap:stop()
	end

	hs.eventtap.keyStrokes(opening)
	if selection and selection ~= "" then
		hs.eventtap.keyStroke({"cmd"}, "v", 0)
		-- Wait for the paste to complete.
		hs.timer.usleep(TIMEOUT * 1e6)
	end
	hs.eventtap.keyStrokes(closing)

	-- Resume listening.
	hs.timer.doAfter(TIMEOUT, function ()
		if eventTap then
			eventTap:start()
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
function getSelection(callbackFn)
  -- Store original clipboard content.
	local originalContent = hs.pasteboard.getContents()
	hs.pasteboard.clearContents()

	hs.eventtap.keyStroke({"cmd"}, "c", 0)
	hs.pasteboard.callbackWhenChanged(TIMEOUT, function (hasChanged)
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
function wrapSelection(opening, closing, callbackFn)
	-- Insert the open-close pair, including any selected text.
	--
	-- This function takes the selected text and safely inserts it wrapped
	-- between the opening and closing characters. It also handles cursor
	-- positioning and selection.
	--
	-- It invokes `callbackFn` with no arguments.
	function inner(selection)
		if selection and selection ~= "" then
			safelyType(opening, selection, closing)
			-- Extend the selection to include the open-close pair.
			local length = #selection
			for i = 1, length + 2 do -- +2 for the opening and closing characters
				hs.eventtap.keyStroke({"shift"}, "left", 0)
			end
		else
			safelyType(opening, selection, closing)
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
function handleKeyDown(event)
	local flags = event:getFlags()
	local char = event:getCharacters()

	local hasMods = flags.alt or flags.ctrl or flags.fn or flags.cmd
	if hasMods or not CHARACTER_PAIRS[char] then
		return false -- Let the event pass through.
	end

	local wrapFunction = wrapSelection(char, CHARACTER_PAIRS[char], function () end)
	getSelection(wrapFunction)
	return true -- Consume the event.
end

--   ____            _             _
--  / ___|___  _ __ | |_ _ __ ___ | |___
-- | |   / _ \| '_ \| __| '__/ _ \| / __|
-- | |__| (_) | | | | |_| | | (_) | \__ \
--  \____\___/|_| |_|\__|_|  \___/|_|___/

-- Start autoclose functionality.
function start()
	eventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, handleKeyDown)

	eventTap:start()

	hs.alert.show("Key pairing: enabled")
	setIcon(true)
end

-- Stop autoclose functionality.
function stop()
	if eventTap then
		eventTap:stop()
	end

	eventTap = nil

	hs.alert.show("Key pairing: disabled")
	setIcon(false)
end

-- Turn autoclose on if it is off, or off if it is on.
function toggle()
	if eventTap and eventTap:isEnabled() then
		stop()
	else
		start()
	end
end

menubarItem:setClickCallback(toggle)
hs.hotkey.bind({"cmd", "shift"}, "9", toggle) -- equal to Cmd ⌘ + (

--  _____       _                          _       _
-- | ____|_ __ | |_ _ __ _   _ _ __   ___ (_)_ __ | |_
-- |  _| | '_ \| __| '__| | | | '_ \ / _ \| | '_ \| __|
-- | |___| | | | |_| |  | |_| | |_) | (_) | | | | | |_
-- |_____|_| |_|\__|_|   \__, | .__/ \___/|_|_| |_|\__|
--                       |___/|_|

start()
