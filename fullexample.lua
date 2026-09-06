local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = require(ReplicatedStorage:WaitForChild("Library"))

-- ====================================================================
-- 1. CREATE MAIN WINDOW
-- ====================================================================
-- Initialize the main window with title, version, keybind, and icon logo.
local window = Library:CreateWindow({
	Title = "Vietnam - On Top",
	Version = "1.0.0",
	Keybind = Enum.KeyCode.RightControl, -- Keybind to show/hide the UI
	Image = "rbxassetid://10566696606"     -- Top-left logo asset ID
})

-- ====================================================================
-- 2. CREATE TABS
-- ====================================================================
local MainTab   = window:AddTab("Main")     -- Main feature tab
local PlayerTab = window:AddTab("Player")   -- Player modifications tab
local MiscTab   = window:AddTab("Misc")     -- Miscellaneous utility tab

-- ====================================================================
-- TAB 1: MAIN (SECTION, LABEL, BUTTON, TOGGLE, DROPDOWN)
-- ====================================================================

-- [SECTION]: Categorizes controls into dedicated visual groups
MainTab:AddSection("🌾 Farming Zone")

-- [LABEL]: Displays informative guide text or warnings
MainTab:AddLabel("📌 Note: Enable Auto Equip before farming")

-- [TOGGLE]: On/Off switch (returns true when enabled, false when disabled)
-- Parameters: ("Toggle Name", Default State (true/false), Callback Function)
MainTab:AddToggle("Auto Farm Mobs", false, function(state)
	if state then
		print("Auto Farm ENABLED!")
		window:Notify("Auto Farm", "Farming mobs automatically...")
	else
		print("Auto Farm DISABLED!")
		window:Notify("Auto Farm", "Stopped farming mobs!")
	end
end)

-- [BUTTON]: Triggers a single action on click
-- Parameters: ("Feature Name", "Button Label", Callback Function)
MainTab:AddButton("Collect All Chests", "Collect", function()
	print("Collecting chests...")
	window:Notify("Chests", "All chests collected successfully!")
end)

-- [DROPDOWN]: Selectable option menu (Select 1 from multiple items)
-- Parameters: ("Dropdown Name", {Options Table}, "Default Option", Callback Function)
MainTab:AddDropdown("Select Farm Spot", {"Monkey Area", "Snow Area", "Desert Area", "Volcano Area"}, "Monkey Area", function(selectedOption)
	print("Selected farm spot:", selectedOption)
	window:Notify("Farm Spot", "Target changed to: " .. tostring(selectedOption))
end)

-- ====================================================================
-- TAB 2: PLAYER (SLIDER, INPUT)
-- ====================================================================

PlayerTab:AddSection("⚡ Player Stats")

-- [SLIDER]: Adjustable numeric slider with minimum, maximum, and default values
-- Parameters: ("Slider Name", Min, Max, Default, Callback Function)
PlayerTab:AddSlider("WalkSpeed", 16, 200, 16, function(value)
	local char = game.Players.LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = value
	end
end)

PlayerTab:AddSlider("JumpPower", 50, 300, 50, function(value)
	local char = game.Players.LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.JumpPower = value
	end
end)

PlayerTab:AddSection("📝 Data Input")

-- [INPUT]: Text input box for user strings or numerical data
-- Parameters: ("Feature Name", "Placeholder Text", Callback Function)
PlayerTab:AddInput("Redeem Promo Code", "Enter code here...", function(text, enterPressed)
	if enterPressed then -- enterPressed = true when user presses Enter
		print("Submitted code:", text)
		window:Notify("Promo Code", "Entered code: " .. tostring(text))
	end
end)

-- ====================================================================
-- TAB 3: MISC (NOTIFICATIONS & SYSTEM)
-- ====================================================================

MiscTab:AddSection("⚙️ System & Notifications")

-- [NOTIFY]: Displays a popup notification on the bottom-right of the screen
MiscTab:AddButton("Test Notification", "Trigger", function()
	window:Notify("Sample Notification", "This is a test notification message!", 4) -- Auto-hide after 4 seconds
end)
