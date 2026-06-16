--[[
Key pairing
===========

This module automatically closes brackets and quotes. When text is
selected, it wraps the selection with the paired characters.
]]

local common = require("lib.common")

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
		[39] = { -- ' key
			shift = { opening = '"', closing = '"' },
		},
		[50] = { -- ` key
			none = { opening = "`", closing = "`" },
		},
	},
	timeout = 0.1, -- seconds

	-- Selection-detection strategy.
	--
	-- "ax": Trust the accessibility API. If `selectedText` is not empty, it is
	--   is the selection. If it is empty, nothing is selected.
	--
	--   This strategy is correct in the vast majority of contexts (native fields,
	--   web pages, CodeMirror/Monaco in the browser). Because we query against
	--   the live focused element on every keypress, it adapts to context
	--   automatically and never has to consult the clipboard.
	--
	-- "clipboard": Ignore the accessibility API and treat any clipboard change
	--   from a Cmd ⌘ + C probe as the real unambiguous selection.
	--
	--   This strategy is useful for contexts (like VS Code) whose AX lies and
	--   reports an empty selection even when text is selected, and which do not
	--   do a line-copy on an empty selection.
	--
	-- "disable": Turn off key pairing. Let the key through untouched.
	--
	--   This strategy is useful for the few contexts where key pairing is just
	--   irreparably broken.
	defaultStrategy = "ax",

	-- Per-context overrides for the few "bad apples" for which the accessibility
	-- API is unreliable and breaks the default strategy. Each rule contains two
	-- fields:
	--
	-- - `match`: `fn(app, element) -> bool` - returns true if the rule applies to
	--   the current context.
	-- - `strategy`: `"ax" | "clipboard" | "disable"` - the strategy to use if the
	--   rule matches.
	--
	-- Since behaviour can vary within a single app (different panes, frameworks,
	-- editor widgets etc.), `match` receives the focused element too and can be
	-- as fine-grained as needed - it is not limited to a bundle-ID check.
	overrides = {
		{
			match = function(app) return app ~= nil and app:bundleID() == "com.microsoft.VSCode" end,
			strategy = "clipboard",
		},
	},

	-- Flip to `true` to log the resolved strategy and selection decision for
	-- every keypress - useful for identifying a new bad apple.
	debug = false,

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

function M.updateIcon()
	if M.config.isEnabled then
		M.config.menubarItem:setIcon(M.config.onIcon)
	else
		M.config.menubarItem:setIcon(M.config.offIcon)
	end
end

-- Post a key-down / key-up pair with explicit modifier flags.
--
-- `newKeyEvent` carries the modifiers on the event itself, so a
-- modifier the user is still physically holding when we fire (e.g.
-- the Shift used to type `<`) doesn't get OR-ed in. Without this,
-- shift-pair characters arrive at the app as their counterpart
-- (`<` -> `>`) and our Cmd ⌘ + V arrives as Cmd ⌘ + Shift ⇧ + V.
function M.postKey(modifiers, key)
	hs.eventtap.event.newKeyEvent(modifiers, key, true):post()
	hs.eventtap.event.newKeyEvent(modifiers, key, false):post()
end

-- Log a formatted message when `M.config.debug` is enabled.
function M.debugLog(format, ...)
	if M.config.debug then print("[key_pairing] " .. string.format(format, ...)) end
end

-- Resolve the selection-detection strategy for the focused context.
--
-- Walks `M.config.overrides` in order and returns the first matching rule's
-- strategy, falling back to `M.config.defaultStrategy`. `match` receives both
-- the frontmost application and the focused element so a rule can target a
-- specific pane / widget, not just an app.
function M.resolveStrategy(app, element)
	for _, rule in ipairs(M.config.overrides) do
		if rule.match(app, element) then return rule.strategy end
	end
	return M.config.defaultStrategy
end

-- Resolve the current selection and pass it to `callbackFn`.
function M.getSelection(strategy, element, callbackFn)
	if strategy == "ax" then
		if element then
			local ok, selected = pcall(function() return element:selectedText() end)
			if ok and selected ~= nil then
				M.debugLog("ax: selected=%q", selected)
				callbackFn(selected)
				return
			end
		end
		-- AX is unavailable here. Probe the clipboard as a last resort, but
		-- fail safe: a single-line clipboard change is indistinguishable from
		-- a no-selection line-copy, so don't treat it as a selection.
		M.debugLog("ax: unavailable, probing clipboard (fail-safe)")
		M.probeClipboard(false, callbackFn)
	else -- "clipboard"
		M.probeClipboard(true, callbackFn)
	end
end

-- Probe the selection via the clipboard: stash it, clear it, fire Cmd ⌘ + C,
-- and inspect what lands.
--
-- Restores the user's real clipboard before invoking `callbackFn`, so `wrap`
-- sees the actual clipboard rather than our probe copy.
function M.probeClipboard(trustAnyChange, callbackFn)
	local originalContent = hs.pasteboard.getContents()
	hs.pasteboard.clearContents()

	M.postKey({ "cmd" }, "c")
	hs.pasteboard.callbackWhenChanged(M.config.timeout, function(hasChanged)
		local selected = ""
		if hasChanged then
			local content = hs.pasteboard.getContents() or ""
			if content ~= "" then
				if trustAnyChange then
					selected = content
				else
					-- An interior newline can only come from a genuine
					-- multi-line selection; a single-line line-copy never
					-- contains one.
					local firstNewline = content:find("\n", 1, true)
					if firstNewline and firstNewline ~= #content then selected = content end
				end
			end
		end
		M.debugLog(
			"clipboard: trustAnyChange=%s hasChanged=%s selected=%q",
			tostring(trustAnyChange),
			tostring(hasChanged),
			selected
		)
		hs.pasteboard.setContents(originalContent)
		callbackFn(selected)
	end)
end

-- Replace the current selection with `opening .. selection .. closing`.
--
-- Implemented as a single paste, which avoids the per-character latency
-- of `keyStrokes` for long selections and side-steps modifier bleed on
-- shift-pair output characters (e.g. `<` getting re-shifted to `>`).
-- The clipboard is stashed before seeding and restored after the paste
-- has landed.
--
-- After the paste, the cursor is moved between the pair if `selection`
-- was empty, or the selection is extended back over the wrapped text.
function M.wrap(opening, selection, closing)
	local wrapped = opening .. selection .. closing

	local originalContent = hs.pasteboard.getContents()
	hs.pasteboard.setContents(wrapped)
	M.postKey({ "cmd" }, "v")

	-- Wait for the paste to land before restoring the clipboard and
	-- positioning the cursor.
	hs.timer.doAfter(M.config.timeout, function()
		hs.pasteboard.setContents(originalContent)

		if selection == "" then
			M.postKey({}, "left")
		else
			for i = 1, #wrapped do
				M.postKey({ "shift" }, "left")
			end
		end
	end)
end

-- Handle key down events.
--
-- If the key is a pair trigger and Ctrl/Fn/Cmd are clear, wrap the
-- current selection (or insert an empty pair). Anything else passes
-- through.
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

	local pair = keyMapping[flags.shift and "shift" or "none"]
	if not pair then
		return false -- Let the event pass through.
	end

	local app = hs.application.frontmostApplication()
	local element = hs.uielement.focusedElement()
	local strategy = M.resolveStrategy(app, element)
	M.debugLog("app=%s strategy=%s", app and app:bundleID() or "?", strategy)
	if strategy == "disable" then
		return false -- Pairing is disabled for this context; pass through.
	end

	M.getSelection(strategy, element, function(selection) M.wrap(pair.opening, selection, pair.closing) end)

	return true -- Consume the event.
end

--  _____       _                          _       _
-- | ____|_ __ | |_ _ __ _   _ _ __   ___ (_)_ __ | |_
-- |  _| | '_ \| __| '__| | | | '_ \ / _ \| | '_ \| __|
-- | |___| | | | |_| |  | |_| | |_) | (_) | | | | | |_
-- |_____|_| |_|\__|_|   \__, | .__/ \___/|_|_| |_|\__|
--                       |___/|_|

function M.init()
	M.config.onIcon = common.getIcon("autoclose_on")
	M.config.offIcon = common.getIcon("autoclose_off")

	M.config.eventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, M.handleKeyDown)

	M.config.keyBinding = hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "9", M.toggle) -- Cmd ⌘ + Ctrl ⌃ + Shift ⇧ + 9
	M.config.menubarItem = hs.menubar.new()
	M.config.menubarItem:setClickCallback(M.toggle)
end

function M.del()
	M.config.keyBinding:disable()
	M.config.menubarItem:delete()
end

function M.start()
	M.config.isEnabled = true
	M.config.eventTap:start()
	M.updateIcon()

	hs.alert.show("Key pairing: started")
end

function M.stop()
	M.config.isEnabled = false
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
