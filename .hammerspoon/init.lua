-- Reference Hammerspoon
hs = hs

-- Paths to SpoonInstall
local spoonInstallPath = hs.fs.pathToAbsolute("~/.hammerspoon/Spoons/SpoonInstall.spoon")
local spoonZipPath = hs.fs.pathToAbsolute("~/.hammerspoon/Spoons/SpoonInstall.spoon.zip")
local url = "https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons/SpoonInstall.spoon.zip"

-- Download and install SpoonInstall if not already installed
if not hs.fs.dir(spoonInstallPath) then
	local status, body = hs.http.get(url, nil)
	if status == 200 then
		-- Save the zip file
		local file = io.open(spoonZipPath, "wb")
		file:write(body)
		file:close()

		-- Create directory and unzip
		hs.fs.mkdir("~/.hammerspoon/Spoons")
		hs.fs.unzip(spoonZipPath, "~/.hammerspoon/Spoons")

		-- Remove zip file
		hs.fs.remove(spoonZipPath)

		hs.alert.show("SpoonInstall installed!")
	else
		hs.alert.show("Failed to download SpoonInstall.")
	end
else
	hs.alert.show("SpoonInstall is already installed.")
end

-- Load SpoonInstall
hs.loadSpoon("SpoonInstall")

-- === Application Launch Key Bindings ===
hs.hotkey.bind({ "cmd" }, "1", function()
	hs.application.launchOrFocus("WezTerm")
end)

hs.hotkey.bind({ "cmd" }, "2", function()
	hs.application.launchOrFocus("intellij idea ce")
end)

hs.hotkey.bind({ "cmd" }, "3", function()
	hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({ "cmd" }, "4", function()
	hs.application.launchOrFocus("Postman")
end)

hs.hotkey.bind({ "cmd" }, "5", function()
	hs.application.launchOrFocus("dbeaver")
end)

hs.hotkey.bind({ "cmd" }, "7", function()
	hs.application.launchOrFocus("visual studio code")
end)

hs.hotkey.bind({ "cmd" }, "8", function()
	hs.osascript.applescript('tell application "Finder" to reopen activate')
end)

hs.hotkey.bind({ "cmd" }, "9", function()
	hs.application.launchOrFocus("slack")
end)

hs.hotkey.bind({ "cmd" }, "0", function()
	hs.application.launchOrFocus("Notion")
end)

-- === System Sound and Brightness Hotkeys ===
local function sendSystemKey(key)
	hs.eventtap.event.newSystemKeyEvent(key, true):post()
	hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

-- Volume control
hs.hotkey.bind({ "ctrl", "cmd" }, "delete", function()
	sendSystemKey("MUTE")
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "-", function()
	sendSystemKey("SOUND_DOWN")
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "=", function()
	sendSystemKey("SOUND_UP")
end)

-- Brightness control
hs.hotkey.bind({ "ctrl", "cmd" }, "0", function()
	sendSystemKey("BRIGHTNESS_UP")
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "9", function()
	sendSystemKey("BRIGHTNESS_DOWN")
end)

-- === Window Management: WindowHalfsAndThirds Spoon ===
spoon.SpoonInstall:andUse("WindowHalfsAndThirds", {
	hotkeys = {
		left_half = { { "ctrl", "cmd" }, "Left" },
		right_half = { { "ctrl", "cmd" }, "Right" },
		top_half = { { "ctrl", "cmd" }, "Up" },
		bottom_half = { { "ctrl", "cmd" }, "Down" },
		max_toggle = { { "ctrl", "cmd" }, "F" }, -- Maximize
	},
})

-- === Clipboard Manager ===
spoon.SpoonInstall:andUse("ClipboardTool", {
	config = {
		deduplicate = true,
		display_max_length = 100,
		hist_size = 200,
		honor_ignoredidentifiers = false,
		show_copied_alert = false,
		paste_on_select = false,
	},
	start = true,
})

-- Toggle Clipboard History
hs.hotkey.bind({ "cmd", "shift" }, "V", function()
	spoon.ClipboardTool:toggleClipboard()
end)

-- === Toggle Dark Mode ===
hs.hotkey.bind({ "ctrl", "cmd" }, "d", function()
	hs.osascript.applescript([[
        tell application "System Events" to tell appearance preferences to set dark mode to not dark mode
    ]])
end)

-- === Auto-Reload Config on Change ===
spoon.SpoonInstall:andUse("ReloadConfiguration", {
	config = {
		watch_paths = { hs.configdir },
	},
	start = true,
})

-- Final notification
hs.alert.show("Hammerspoon config loaded!")
