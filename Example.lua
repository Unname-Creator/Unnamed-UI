-- Mini Example, examplereal Comingsoon
local player = game:GetService("Players").LocalPlayer
local Character = player.Character
local humanoid = Character.Humanoid

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Unname-Creator/Unnamed-UI/refs/heads/main/main.lua"))()

local Window = Library:CreateWindow({
    Title   = "Unnamed-UI",
    Version = "0.0.1",
    Keybind = Enum.KeyCode.RightControl,
    Image   = "rbxassetid://10566696606"
})

Window:Notify("Notification!", "has active ui", 3)

local Home = Window:AddTab("Home")
Home:AddSection("Function")
Home:AddLabel("Notthing")

local Player = Window:AddTab("Player")
Player:AddSection("WIP")
Player:AddLabel("nope")
Player:AddButton("Test", "clickhere", function()
    Window:Notify("Notification!", "u has active Button", 3)
end)

Player:AddToggle("Speedhack", false ,function(state)
    if state then
        humanoid.WalkSpeed = 50
    else
        humanoid.WalkSpeed = 16
    end
end)
