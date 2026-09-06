local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Unname-Creator/Unnamed-UI/refs/heads/main/main.lua"))()

local window = library:CreateWindow({
    Title = "My UI",
    Version = "0.0.2",
    Keybind = Enum.KeyCode.RightControl,
    Image = "rbxassetid://7258425744",
})
--notify
local function Notification(text, time)
    window:Notify("Notification!",text ,time)
end 

    Notification("UI has active", 3)
--tab
local tab = {
    ["Home"] = window:AddTab("Home"),
    ["Player"] = window:AddTab("ButtonTest"),
    ["Setting"] = window:AddTab("Setting")
}

local FunctionHome = {
    tab.Home:AddSection("Home"),
    tab.Home:AddLabel("Open ButtonTest for all button"),
}

local FunctionPlayer = {
        tab.Player:AddSection("Button, Drop, toggle, slide, textbox"),
    ["Button"] = tab.Player:AddButton("Click the Button","Click Me",function() Notification("Is Clicked", 2) end),
    ["Dropdown"] = tab.Player:AddDropdown("DropDown", {"one","two","three","four","five"}, "one",function(selectedOption)
    Notification("Player Choose" .. " " .. tostring(selectedOption), 2) end),
    ["toggle"] = tab.Player:AddToggle("Is toggle", false, function(state) 
        if state == true then
            Notification("true",2)
        else
            Notification("false",2)
        end
    end),

    ["slider"] = tab.Player:AddSlider("WalkSpeed", 16, 200 ,16 ,function(value)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local humanoid = character.Humanoid

    humanoid.WalkSpeed = value
    end),

    tab.Player:AddSection("Redeem text and enter for active"),

    ["boxtext"] = tab.Player:AddInput("Redeem text", "Enter text here...", function(text, enterPressed)
	    if enterPressed then -- enterPressed = true when user presses Enter
		    window:Notify("Promo Code", "Entered code: " .. tostring(text))
	    end
    end)
}

local setting = {
    tab.Setting:AddSection("Nothing bluh"),
    tab.Setting:AddLabel("Nothing")
}

