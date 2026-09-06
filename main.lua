local _0x1 = game:GetService("\80\108\097\121\101\114\115")
local _0x2 = game:GetService("\67\111\114\101\71\117\105")
local _0x3 = game:GetService("\85\115\101\114\73\110\112\117\116\83\101\114\118\105\99\101")
local _0x4 = game:GetService("\84\119\101\101\110\83\101\114\118\105\99\101")

local _0x5 = _0x1.LocalPlayer or _0x1.PlayerAdded:Wait()
local _0x6 = _0x5:WaitForChild("\80\108\097\121\101\114\71\117\105")

local _0x7 = _0x6
pcall(function()
local _0x8 = _0x2.Name
_0x7 = _0x2
end)

local library = {
CoreGui = _0x2,
PlayerGui = _0x6,
Gui = _0x7
}

local function _0x9(_0xA, _0xB, _0xC)
local _0xD = Instance.new(_0xA)
for _0xE, _0xF in pairs(_0xB or {}) do
_0xD[_0xE] = _0xF
end
_0xC = _0xC or {}
if _0xC.Corner then
local _0x10 = Instance.new("\85\73\67\111\114\110\101\114")
_0x10.CornerRadius = UDim.new(0, _0xC.Corner)
_0x10.Parent = _0xD
end
if _0xC.Stroke then
local _0x11 = Instance.new("\85\73\83\116\114\111\107\101")
_0x11.Thickness = _0xC.Stroke.Thickness or (15/10)
_0x11.Transparency = _0xC.Stroke.Transparency or (7/10)
_0x11.Color = _0xC.Stroke.Color or Color3.fromRGB(0, 0, 0)
_0x11.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
_0x11.Parent = _0xD
end
if _0xC.Gradient then
local _0x12 = Instance.new("\85\73\71\114\097\100\105\101\110\116")
_0x12.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
_0x12.Transparency = NumberSequence.new(_0xC.Gradient.Start or (75/100), _0xC.Gradient.End or 0)
_0x12.Parent = _0xD
end
return _0xD
end

function library:CreateWindow(options)
if type(options) == "\115\116\114\105\110\103" then
options = { Title = options }
else
options = options or {}
end

local _0x13 = options.Title or "\77\121\32\85\73\32\87\105\110\100\111\119"
local _0x14 = options.Version or "\49\46\48\46\48"
local _0x15 = options.Keybind or Enum.KeyCode.RightControl
local _0x16 = options.Image or "\114\098\120\097\115\115\101\116\105\100\58\47\47\49\48\53\54\54\54\57\54\54\48\54"
local _0x17 = options.ClickSound ~= nil and options.ClickSound or options.sound
if _0x17 == nil then
	_0x17 = "\114\098\120\097\115\115\101\116\105\100\58\47\47\56\51\56\56\55\50\52\56\48\54"
end

local Screen = _0x9("\83\99\114\101\101\110\71\117\105", {
	Name = _0x13 .. "\95\71\117\105",
	Enabled = true,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = _0x7
})

local Main = _0x9("\70\114\097\109\101", {
	Name = "\77\097\105\110",
	Size = UDim2.new(0, 420, 0, 260),
	Position = UDim2.new((5/10), 0, (5/10), 0),
	AnchorPoint = Vector2.new((5/10), (5/10)),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = (5/10),
	Active = true,
	Parent = Screen
}, { Corner = 10, Stroke = {Thickness = 2, Transparency = (7/10)}, Gradient = {Start = (9/10), End = 0} })

local _0x18 = Instance.new("\83\111\117\110\100")
if _0x17 ~= 0 and _0x17 ~= false then
	_0x18.SoundId = tostring(_0x17):find("\114\098\120\097\115\115\101\116\105\100\58\47\47") and _0x17 or ("\114\098\120\097\115\115\101\116\105\100\58\47\47" .. tostring(_0x17))
end
_0x18.Volume = (5/10)
_0x18.Parent = Main

local function _0x19()
	if _0x17 ~= 0 and _0x17 ~= false then
		_0x18:Play()
	end
end

local _0x1A, _0x1B, _0x1C, _0x1D
Main.InputBegan:Connect(function(_0x1E)
	if _0x1E.UserInputType == Enum.UserInputType.MouseButton1 or _0x1E.UserInputType == Enum.UserInputType.Touch then
		_0x1A = true
		_0x1C = _0x1E.Position
		_0x1D = Main.Position
		_0x1E.Changed:Connect(function()
			if _0x1E.UserInputState == Enum.UserInputState.End then
				_0x1A = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(_0x1E)
	if _0x1E.UserInputType == Enum.UserInputType.MouseMovement or _0x1E.UserInputType == Enum.UserInputType.Touch then
		_0x1B = _0x1E
	end
end)

_0x3.InputChanged:Connect(function(_0x1E)
	if _0x1E == _0x1B and _0x1A then
		local _0x1F = _0x1E.Position - _0x1C
		local _0x20 = UDim2.new(_0x1D.X.Scale, _0x1D.X.Offset + _0x1F.X, _0x1D.Y.Scale, _0x1D.Y.Offset + _0x1F.Y)
		Main.Position = Main.Position:Lerp(_0x20, (2/10))
	end
end)

_0x9("\73\109\097\103\101\76\097\98\101\108", {
	Name = "\105\109\097\103\101",
	Size = UDim2.new(0, 45, 0, 45),
	Position = UDim2.new((3/100), 0, (3/100), 0),
	BackgroundTransparency = 1,
	Image = _0x16,
	ImageTransparency = (1/10),
	Parent = Main
}, {Corner = 10, Stroke = {Thickness = (15/10), Transparency = (8/10)}})

_0x9("\84\101\120\116\76\097\98\101\108", {
	Name = "\78\097\109\101\71\117\105",
	Size = UDim2.new(0, 200, 0, 20),
	Position = UDim2.new((16/100), 0, (28/1000), 0),
	BackgroundTransparency = (8/10),
	Text = _0x13,
	TextColor3 = Color3.fromRGB(0, 0, 0),
	TextSize = 14,
	FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
	Parent = Main
}, {Corner = 10, Stroke = {Thickness = (15/10), Transparency = (8/10)}})

_0x9("\84\101\120\116\76\097\98\101\108", {
	Name = "\86\101\114\115\105\111\110",
	Size = UDim2.new(0, 100, 0, 18),
	Position = UDim2.new((16/100), 0, (12/100), 0),
	BackgroundTransparency = (8/10),
	Text = "\86\101\114\115\105\111\110\58\32\86" .. _0x14,
	TextColor3 = Color3.fromRGB(0, 0, 0),
	TextSize = 12,
	FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
	Parent = Main
}, {Corner = 10, Stroke = {Thickness = (15/10), Transparency = (8/10)}})

local _0x21 = _0x9("\84\101\120\116\66\117\116\116\111\110", {Name = "\67\108\111\115\101\98\116\110", Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new((92/100), 0, (28/1000), 0), BackgroundTransparency = 1, Text = "🔴", TextScaled = true, Parent = Main})
local _0x22 = _0x9("\84\101\120\116\66\117\116\116\111\110", {Name = "\83\99\097\108\101\98\116\110", Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new((84/100), 0, (28/1000), 0), BackgroundTransparency = 1, Text = "🟡", TextScaled = true, Parent = Main})
local _0x23 = _0x9("\84\101\120\116\66\117\116\116\111\110", {Name = "\77\105\110\105\115\105\122\101\98\116\110", Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new((76/100), 0, (28/1000), 0), BackgroundTransparency = 1, Text = "🟢", TextScaled = true, Parent = Main})

local _0x24 = _0x9("\70\114\097\109\101", {
	Name = "\67\111\110\102\105\114\109\72\111\108\100\101\114",
	Size = UDim2.new(0, 280, 0, 120),
	Position = UDim2.new((5/10), 0, (5/10), 0),
	AnchorPoint = Vector2.new((5/10), (5/10)),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = (5/10),
	Visible = false,
	ZIndex = 20,
	Parent = Screen
}, { Corner = 10, Stroke = {Thickness = 2, Transparency = (7/10)}, Gradient = {Start = (6/10), End = 0} })

_0x9("\84\101\120\116\76\097\98\101\108", {
	Name = "\67\111\110\102\105\114\109\84\101\120\116",
	Size = UDim2.new((9/10), 0, 0, 35),
	Position = UDim2.new((5/100), 0, (15/100), 0),
	BackgroundTransparency = (6/10),
	Text = "\65\114\101\32\121\111\117\32\115\111\117\114\101\32\116\111\32\99\108\111\115\101\32\71\85\73\63",
	TextColor3 = Color3.fromRGB(0, 0, 0),
	TextSize = 15,
	FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
	Parent = _0x24
}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (8/10)}})

local _0x25 = _0x9("\84\101\120\116\66\117\116\116\111\110", {
	Name = "\89\101\097\104",
	Size = UDim2.new(0, 100, 0, 35),
	Position = UDim2.new((1/10), 0, (55/100), 0),
	BackgroundTransparency = (5/10),
	Text = "\89\101\097\104",
	TextColor3 = Color3.fromRGB(0, 0, 0),
	TextSize = 14,
	FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
	Parent = _0x24
}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (8/10)}})

local _0x26 = _0x9("\84\101\120\116\66\117\116\116\111\110", {
	Name = "\78\111\112\101",
	Size = UDim2.new(0, 100, 0, 35),
	Position = UDim2.new((55/100), 0, (55/100), 0),
	BackgroundTransparency = (5/10),
	Text = "\78\111\112\101",
	TextColor3 = Color3.fromRGB(0, 0, 0),
	TextSize = 14,
	FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
	Parent = _0x24
}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (8/10)}})

_0x21.MouseButton1Click:Connect(function()
	_0x24.Visible = true
	Main.Visible = false
	_0x19()
	Main:SetAttribute("\105\115\99\104\111\111\115\101\100", true) 
end)

_0x25.MouseButton1Click:Connect(function()
	Screen.Enabled = false
	_0x19()
	task.wait((2/10))
	Screen:Destroy()
end)

_0x26.MouseButton1Click:Connect(function()
	_0x24.Visible = false
	_0x19()
	Main.Visible = true
	Main:SetAttribute("\105\115\99\104\111\111\115\101\100", false)
end)

local _0x27 = Instance.new("\85\73\83\99\097\108\101")
_0x27.Scale = 1
_0x27.Parent = Main

local _0x28 = false
local _0x29 = TweenInfo.new((4/10), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

_0x22.MouseButton1Click:Connect(function()
	_0x28 = not _0x28
	local _0x2A = _0x28 and (135/100) or 1 
	_0x4:Create(_0x27, _0x29, {Scale = _0x2A}):Play()
	_0x19()
end)

local _0x2B = _0x9("\70\114\097\109\101", {
	Name = "\110\111\116\105\99\097\116\105\111\110\102\114\097\109\101",
	Size = UDim2.new(0, 270, 0, 300),
	Position = UDim2.new(1, -280, 1, -310),
	BackgroundTransparency = 1,
	ZIndex = 2,
	Parent = Screen
})

local _0x2C = Instance.new("\70\111\108\100\101\114")
_0x2C.Name = "\70\111\108\100\101\114"
_0x2C.Parent = _0x2B

_0x9("\85\73\76\105\115\116\76\097\121\111\117\116", {
	Name = "\85\73\76\105\115\116\76\097\121\111\117\116",
	FillDirection = Enum.FillDirection.Vertical,
	Padding = UDim.new(0, 7),
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Bottom,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = _0x2C
})

local _0x2D = _0x15.Name
local _0x2E = _0x9("\70\114\097\109\101", {
	Name = "\72\105\110\116\70\114\097\109\101",
	Size = UDim2.new(0, 220, 0, 30),
	Position = UDim2.new((25/1000), 0, (925/1000), 0),
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	BackgroundTransparency = 1,
	Visible = false,
	ZIndex = 10,
	Parent = Screen
}, { Corner = 8, Stroke = {Thickness = (15/10), Transparency = 1, Color = Color3.fromRGB(255, 255, 255)} })

local _0x2F = _0x2E:FindFirstChildOfClass("\85\73\83\116\114\111\107\101")

local _0x30 = _0x9("\84\101\120\116\76\097\98\101\108", {
	Name = "\72\105\110\116\76\097\98\101\108",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "\80\114\101\115\115\32\91" .. _0x2D .. "\93\32\116\111\32\84\111\103\103\108\101\32\71\85\73",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextTransparency = 1,
	TextSize = 13,
	FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
	Parent = _0x2E
})

local _0x31 = false
local _0x32 = nil
local _0x33 = TweenInfo.new((15/10), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local _0x34 = TweenInfo.new((25/100), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function _0x35()
	_0x2E.Visible = true
	_0x4:Create(_0x2E, _0x34, {BackgroundTransparency = (3/10)}):Play()
	_0x4:Create(_0x30, _0x34, {TextTransparency = 0}):Play()
	if _0x2F then
		_0x4:Create(_0x2F, _0x34, {Transparency = (6/10)}):Play()
	end
end

local function _0x36()
	local _0x37 = _0x4:Create(_0x2E, _0x33, {BackgroundTransparency = 1})
	local _0x38 = _0x4:Create(_0x30, _0x33, {TextTransparency = 1})
	_0x37:Play()
	_0x38:Play()
	if _0x2F then
		_0x4:Create(_0x2F, _0x33, {Transparency = 1}):Play()
	end

	_0x37.Completed:Connect(function()
		if _0x2E.BackgroundTransparency >= (99/100) then
			_0x2E.Visible = false
		end
	end)
end

local function _0x39()
	if Main:GetAttribute("\105\115\99\104\111\111\115\101\100") == true then
		return
	end

	_0x31 = not _0x31
	Main.Visible = not _0x31

	if _0x32 then task.cancel(_0x32) end

	if _0x31 then
		_0x35()
		_0x32 = task.delay((16/10), function()
			_0x36()
		end)
	else
		_0x36()
	end
end

_0x23.MouseButton1Click:Connect(function()
	_0x19()
	_0x39()
end)

_0x3.InputBegan:Connect(function(_0x1E, _0x3A)
	if _0x3A then return end
	if _0x1E.KeyCode == _0x15 then
		if Main:GetAttribute("\105\115\99\104\111\111\115\101\100") == true then
			return
		end
		_0x19()
		_0x39()
	end
end)

local _0x3B = _0x9("\83\99\114\111\108\108\105\110\103\70\114\097\109\101", {
	Name = "\84\097\98\83\99\114\111\108\108",
	Size = UDim2.new(0, 100, 0, 200),
	Position = UDim2.new((74/100), 0, (2/10), 0),
	BackgroundTransparency = 1,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	ScrollBarThickness = 2,
	Parent = Main
})

local _0x3C = _0x9("\70\111\108\100\101\114", {Name = "\84\097\98\70\111\108\100\101\114", Parent = _0x3B})
_0x9("\85\73\76\105\115\116\76\097\121\111\117\116", {
	Name = "\85\73\76\105\115\116\76\097\121\111\117\116",
	FillDirection = Enum.FillDirection.Vertical,
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = _0x3C
})

local _0x3D = _0x9("\70\114\097\109\101", {
	Name = "\70\117\110\99\116\105\111\110\104\111\118\101\114",
	Size = UDim2.new(0, 290, 0, 200),
	Position = UDim2.new((3/100), 0, (22/100), 0),
	BackgroundTransparency = (4/10),
	Parent = Main
}, {Corner = 10, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

local _0x3E = _0x9("\70\111\108\100\101\114", {Name = "\70\117\110\99\116\105\111\110\116\097\98", Parent = _0x3D})

local windowInstance = {
	Screen = Screen,
	Main = Main,
	TabFolder = _0x3C,
	FunctionTabFolder = _0x3E,
	NotifFolder = _0x2C,
	Tabs = {},
	FirstTab = nil
}

local function _0x3F(_0x40, _0x41, _0x42)
	if not _0x40 or _0x40:GetAttribute("\73\115\67\108\111\115\105\110\103") then return end
	_0x40:SetAttribute("\73\115\67\108\111\115\105\110\103", true)

	if _0x41 then
		local _0x43 = _0x4:Create(_0x41, _0x42, {Position = UDim2.new((12/10), 0, 0, 0)})
		_0x43:Play()
		_0x43.Completed:Connect(function()
			_0x40:Destroy()
		end)
	else
		_0x40:Destroy()
	end
end

function windowInstance:Notify(notifTitle, notifText, duration)
	duration = duration or 3
	local _0x44 = TweenInfo.new((35/100), Enum.EasingStyle.Quart, Enum.EasingDirection.In)

	local _0x45 = self.NotifFolder:GetChildren()
	local _0x46 = {}

	for _, _0x47 in ipairs(_0x45) do
		if _0x47:IsA("\70\114\097\109\101") and not _0x47:GetAttribute("\73\115\67\108\111\115\105\110\103") then
			table.insert(_0x46, _0x47)
		end
	end

	if #_0x46 >= 2 then
		local _0x48 = _0x46[1]
		local _0x49 = _0x48:FindFirstChild("\102\114\097\109\101\104\111\108\100\101\114")
		_0x3F(_0x48, _0x49, _0x44)
	end

	local _0x4A = _0x9("\70\114\097\109\101", {
		Name = "\78\111\116\105\102\87\114\097\112\112\101\114",
		Size = UDim2.new(0, 270, 0, 75),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = self.NotifFolder
	})

	local _0x4B = _0x9("\70\114\097\109\101", {
		Name = "\102\114\097\109\101\104\111\108\100\101\114",
		Size = UDim2.new(1, 0, 0, 75),
		Position = UDim2.new((12/10), 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = (6/10),
		Parent = _0x4A
	}, { Corner = 10, Stroke = {Thickness = 2, Transparency = (7/10)}, Gradient = {Start = (9/10), End = 0} })

	local _0x4C = _0x9("\70\114\097\109\101", {
		Name = "\72\111\108\100\101\114",
		Size = UDim2.new(0, 241, 0, 20),
		Position = UDim2.new((37/1000), 0, (933/10000), 0),
		BackgroundTransparency = 1,
		Parent = _0x4B
	})

	_0x9("\84\101\120\116\76\097\98\101\108", {
		Name = "\78\111\116\105\99\097\116\105\111\110",
		Size = UDim2.new(0, 250, 0, 20),
		Position = UDim2.new(0, 0, -(1/10), 0),
		BackgroundTransparency = 1,
		Text = (notifTitle or "\78\111\116\105\102\105\99\097\116\105\111\110\33"),
		TextColor3 = Color3.fromRGB(51, 51, 51),
		TextSize = 14,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
		Parent = _0x4C
	})

	local _0x4D = _0x9("\70\114\097\109\101", {
		Name = "\108\101\116\116\101\114\95\104\111\108\100\101\114",
		Size = UDim2.new(0, 270, 0, 47),
		Position = UDim2.new(0, 0, (3333/10000), 0),
		BackgroundTransparency = 1,
		Parent = _0x4B
	}, {Corner = 10})

	_0x9("\84\101\120\116\76\097\98\101\108", {
		Name = "\108\101\116\116\101\114",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = notifText or "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
		Parent = _0x4D
	}, {Corner = 10})

	local _0x4E = TweenInfo.new((35/100), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	_0x4:Create(_0x4B, _0x4E, {Position = UDim2.new(0, 0, 0, 0)}):Play()

	task.delay(duration, function()
		if _0x4A and _0x4A.Parent then
			_0x3F(_0x4A, _0x4B, _0x44)
		end
	end)
end

function windowInstance:CreateTab(name)
	name = name or "\84\097\98"

	local _0x4F = _0x9("\84\101\120\116\66\117\116\116\111\110", {
		Name = name .. "\95\66\117\116\116\111\110",
		Size = UDim2.new(0, 95, 0, 30),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = (7/10),
		Text = name,
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 13,
		FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
		Parent = self.TabFolder
	}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

	local _0x50 = _0x9("\83\99\114\111\108\108\105\110\103\70\114\097\109\101", {
		Name = name .. "\95\67\111\110\116\097\105\110\101\114",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 3,
		Visible = false,
		Parent = self.FunctionTabFolder
	})

	_0x9("\85\73\80\097\100\100\105\110\103", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		PaddingLeft = UDim.new(0, 6),
		PaddingRight = UDim.new(0, 6),
		Parent = _0x50
	})

	_0x9("\85\73\76\105\115\116\76\097\121\111\117\116", {
		Name = "\85\73\76\105\115\116\76\097\121\111\117\116",
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = _0x50
	})

	local tabObj = {
		Button = _0x4F,
		Container = _0x50
	}

	_0x4F.MouseButton1Click:Connect(function()
		_0x19()
		for _, _0x51 in pairs(windowInstance.Tabs) do
			_0x51.Container.Visible = false
			_0x51.Button.BackgroundTransparency = (7/10)
		end
		_0x50.Visible = true
		_0x4F.BackgroundTransparency = (3/10)
	end)

	if not windowInstance.FirstTab then
		windowInstance.FirstTab = tabObj
		_0x50.Visible = true
		_0x4F.BackgroundTransparency = (3/10)
	end

	table.insert(windowInstance.Tabs, tabObj)

	function tabObj:CreateSection(sectionText)
		local _0x52 = _0x9("\70\114\097\109\101", {
			Name = (sectionText or "\83\101\99\116\105\111\110") .. "\95\83\101\99\116\105\111\110",
			Size = UDim2.new(1, 0, 0, 24),
			BackgroundTransparency = 1,
			Parent = self.Container
		})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\105\116\108\101",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "—  " .. (sectionText or "\83\101\99\116\105\111\110") .. "  —",
			TextColor3 = Color3.fromRGB(30, 30, 30),
			TextSize = 13,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54", Enum.FontWeight.Bold),
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = _0x52
		})

		return _0x52
	end

	function tabObj:CreateLabel(labelText)
		local _0x53 = _0x9("\70\114\097\109\101", {
			Name = "\76\097\98\101\108\70\114\097\109\101",
			Size = UDim2.new(1, 0, 0, 26),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (8/10),
			Parent = self.Container
		}, {Corner = 6, Stroke = {Thickness = 1, Transparency = (8/10)}})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\101\120\116",
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.new(0, 6, 0, 0),
			BackgroundTransparency = 1,
			Text = labelText or "\76\097\98\101\108",
			TextColor3 = Color3.fromRGB(20, 20, 20),
			TextSize = 12,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = _0x53
		})

		return _0x53
	end

	function tabObj:CreateButton(labelText, btnText, callback)
		if typeof(btnText) == "\102\117\110\99\116\105\111\110" then
			callback = btnText
			btnText = "\67\108\105\99\107"
		end
		btnText = btnText or "\67\108\105\99\107"

		local _0x54 = _0x9("\70\114\097\109\101", {
			Name = (labelText or "\66\117\116\116\111\110") .. "\95\70\114\097\109\101",
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (6/10),
			Parent = self.Container
		}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\105\116\108\101",
			Size = UDim2.new((65/100), 0, 1, 0),
			Position = UDim2.new((4/100), 0, 0, 0),
			BackgroundTransparency = 1,
			Text = labelText or "\66\117\116\116\111\110",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x54
		})

		local _0x55 = _0x9("\84\101\120\116\66\117\116\116\111\110", {
			Name = "\65\99\116\105\111\110\66\117\116\116\111\110",
			Size = UDim2.new(0, 70, 0, 22),
			Position = UDim2.new((96/100), -70, (5/10), -11),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (3/10),
			Text = btnText,
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x54
		}, {Corner = 6, Stroke = {Thickness = 1, Transparency = (7/10)}})

		local function _0x56()
			_0x19()
			_0x4:Create(_0x55, TweenInfo.new((1/10)), {BackgroundTransparency = (7/10)}):Play()
			task.delay((1/10), function()
				_0x4:Create(_0x55, TweenInfo.new((1/10)), {BackgroundTransparency = (3/10)}):Play()
			end)
			if callback then
				pcall(callback)
			end
		end

		_0x55.MouseButton1Click:Connect(_0x56)

		return _0x54
	end

	function tabObj:CreateToggle(toggleText, defaultState, callback)
		if typeof(defaultState) == "\102\117\110\99\116\105\111\110" then
			callback = defaultState
			defaultState = false
		end
		defaultState = defaultState or false

		local _0x57 = _0x9("\70\114\097\109\101", {
			Name = toggleText .. "\95\84\111\103\103\108\101",
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (6/10),
			Parent = self.Container
		}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\105\116\108\101",
			Size = UDim2.new((7/10), 0, 1, 0),
			Position = UDim2.new((4/100), 0, 0, 0),
			BackgroundTransparency = 1,
			Text = toggleText or "\84\111\103\103\108\101",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x57
		})

		local _0x58 = _0x9("\70\114\097\109\101", {
			Name = "\83\119\105\116\99\104",
			Size = UDim2.new(0, 42, 0, 20),
			Position = UDim2.new((96/100), -42, (5/10), -10),
			BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(150, 150, 150),
			BackgroundTransparency = (2/10),
			Parent = _0x57
		}, {Corner = 10, Stroke = {Thickness = 1, Transparency = (8/10)}})

		local _0x59 = _0x9("\70\114\097\109\101", {
			Name = "\75\110\111\98",
			Size = UDim2.new(0, 16, 0, 16),
			Position = defaultState and UDim2.new(1, -18, (5/10), -8) or UDim2.new(0, 2, (5/10), -8),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Parent = _0x58
		}, {Corner = 8})

		local _0x5A = _0x9("\84\101\120\116\66\117\116\116\111\110", {
			Name = "\67\108\105\99\107\101\114",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			Parent = _0x57
		})

		local _0x5B = defaultState
		local _0x5C = TweenInfo.new((25/100), Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

		_0x5A.MouseButton1Click:Connect(function()
			_0x19()
			_0x5B = not _0x5B

			local _0x5D = _0x5B and UDim2.new(1, -18, (5/10), -8) or UDim2.new(0, 2, (5/10), -8)
			local _0x5E = _0x5B and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(150, 150, 150)

			_0x4:Create(_0x59, _0x5C, {Position = _0x5D}):Play()
			_0x4:Create(_0x58, _0x5C, {BackgroundColor3 = _0x5E}):Play()

			if callback then
				pcall(callback, _0x5B)
			end
		end)

		return _0x57
	end

	function tabObj:CreateSlider(sliderText, min, max, default, callback)
		min = min or 0
		max = max or 100
		default = math.clamp(default or min, min, max)

		local _0x5F = _0x9("\70\114\097\109\101", {
			Name = (sliderText or "\83\108\105\100\101\114") .. "\95\83\108\105\100\101\114",
			Size = UDim2.new(1, 0, 0, 46),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (6/10),
			Parent = self.Container
		}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\105\116\108\101",
			Size = UDim2.new((6/10), 0, 0, 20),
			Position = UDim2.new((4/100), 0, (8/100), 0),
			BackgroundTransparency = 1,
			Text = sliderText or "\83\108\105\100\101\114",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x5F
		})

		local _0x60 = _0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\86\097\108\117\101",
			Size = UDim2.new((3/10), 0, 0, 20),
			Position = UDim2.new((66/100), 0, (8/100), 0),
			BackgroundTransparency = 1,
			Text = tostring(default),
			TextColor3 = Color3.fromRGB(40, 40, 40),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Right,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x5F
		})

		local _0x61 = _0x9("\70\114\097\109\101", {
			Name = "\84\114\097\99\107",
			Size = UDim2.new((92/100), 0, 0, 8),
			Position = UDim2.new((4/100), 0, (68/100), 0),
			BackgroundColor3 = Color3.fromRGB(180, 180, 180),
			BackgroundTransparency = (3/10),
			Parent = _0x5F
		}, {Corner = 4, Stroke = {Thickness = 1, Transparency = (8/10)}})

		local _0x62 = (default - min) / (max - min)
		local _0x63 = _0x9("\70\114\097\109\101", {
			Name = "\70\105\108\108",
			Size = UDim2.new(_0x62, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(0, 170, 255),
			Parent = _0x61
		}, {Corner = 4})

		_0x9("\70\114\097\109\101", {
			Name = "\75\110\111\98",
			Size = UDim2.new(0, 14, 0, 14),
			AnchorPoint = Vector2.new((5/10), (5/10)),
			Position = UDim2.new(1, 0, (5/10), 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Parent = _0x63
		}, {Corner = 7, Stroke = {Thickness = 1, Transparency = (5/10), Color = Color3.fromRGB(0, 120, 200)}})

		local _0x64 = _0x9("\84\101\120\116\66\117\116\116\111\110", {
			Name = "\84\114\105\103\103\101\114",
			Size = UDim2.new(1, 0, 1, 10),
			Position = UDim2.new(0, 0, 0, -5),
			BackgroundTransparency = 1,
			Text = "",
			Parent = _0x61
		})

		local _0x65 = false

		local function _0x66(_0x1E)
			local _0x67 = _0x61.AbsolutePosition.X
			local _0x68 = _0x61.AbsoluteSize.X
			local _0x69 = _0x1E.Position.X - _0x67
			local _0x6A = math.clamp(_0x69 / _0x68, 0, 1)

			local _0x6B = math.floor(min + (max - min) * _0x6A)
			_0x63.Size = UDim2.new(_0x6A, 0, 1, 0)
			_0x60.Text = tostring(_0x6B)

			if callback then
				pcall(callback, _0x6B)
			end
		end

		_0x64.InputBegan:Connect(function(_0x1E)
			if _0x1E.UserInputType == Enum.UserInputType.MouseButton1 or _0x1E.UserInputType == Enum.UserInputType.Touch then
				_0x65 = true
				_0x19()
				_0x66(_0x1E)
			end
		end)

		_0x3.InputChanged:Connect(function(_0x1E)
			if _0x65 and (_0x1E.UserInputType == Enum.UserInputType.MouseMovement or _0x1E.UserInputType == Enum.UserInputType.Touch) then
				_0x66(_0x1E)
			end
		end)

		_0x3.InputEnded:Connect(function(_0x1E)
			if _0x1E.UserInputType == Enum.UserInputType.MouseButton1 or _0x1E.UserInputType == Enum.UserInputType.Touch then
				_0x65 = false
			end
		end)

		return _0x5F
	end

	function tabObj:CreateInput(inputText, placeholderText, callback)
		local _0x6C = _0x9("\70\114\097\109\101", {
			Name = (inputText or "\73\110\112\117\116") .. "\95\70\114\097\109\101",
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (6/10),
			Parent = self.Container
		}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\105\116\108\101",
			Size = UDim2.new((5/10), 0, 1, 0),
			Position = UDim2.new((4/100), 0, 0, 0),
			BackgroundTransparency = 1,
			Text = inputText or "\73\110\112\117\116",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x6C
		})

		local _0x6D = _0x9("\84\101\120\116\66\111\120", {
			Name = "\84\101\120\116\66\111\120",
			Size = UDim2.new(0, 110, 0, 22),
			Position = UDim2.new((96/100), -110, (5/10), -11),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (2/10),
			PlaceholderText = placeholderText or "\69\110\116\101\114\32\116\101\120\116\46\46\46",
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			ClearTextOnFocus = false,
			Parent = _0x6C
		}, {Corner = 6, Stroke = {Thickness = 1, Transparency = (7/10)}})

		_0x6D.FocusLost:Connect(function(_0x6E)
			_0x19()
			if callback then
				pcall(callback, _0x6D.Text, _0x6E)
			end
		end)

		return _0x6C
	end

	function tabObj:CreateDropdown(dropdownText, optionsList, defaultOption, callback)
		optionsList = optionsList or {}
		local _0x6F = defaultOption or optionsList[1] or "\78\111\110\101"

		local _0x70 = _0x9("\70\114\097\109\101", {
			Name = (dropdownText or "\68\114\111\112\100\111\119\110") .. "\95\68\114\111\112\100\111\119\110",
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (6/10),
			ClipsDescendants = true,
			Parent = self.Container
		}, {Corner = 8, Stroke = {Thickness = (15/10), Transparency = (7/10)}})

		_0x9("\84\101\120\116\76\097\98\101\108", {
			Name = "\84\105\116\108\101",
			Size = UDim2.new((5/10), 0, 0, 32),
			Position = UDim2.new((4/100), 0, 0, 0),
			BackgroundTransparency = 1,
			Text = dropdownText or "\68\114\111\112\100\111\119\110",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x70
		})

		local _0x71 = _0x9("\84\101\120\116\66\117\116\116\111\110", {
			Name = "\83\101\108\101\99\116\66\117\116\116\111\110",
			Size = UDim2.new(0, 110, 0, 22),
			Position = UDim2.new((96/100), -110, 0, 5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = (3/10),
			Text = tostring(_0x6F) .. " ▼",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 11,
			FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
			Parent = _0x70
		}, {Corner = 6, Stroke = {Thickness = 1, Transparency = (7/10)}})

		local _0x72 = _0x9("\70\114\097\109\101", {
			Name = "\79\112\116\105\111\110\115\67\111\110\116\097\105\110\101\114",
			Size = UDim2.new((92/100), 0, 0, 0),
			Position = UDim2.new((4/100), 0, 0, 36),
			BackgroundTransparency = 1,
			Parent = _0x70
		})

		local _0x73 = _0x9("\85\73\76\105\115\116\76\097\121\111\117\116", {
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = _0x72
		})

		local _0x74 = false

		local function _0x75()
			for _, _0x76 in ipairs(_0x72:GetChildren()) do
				if _0x76:IsA("\84\101\120\116\66\117\116\116\111\110") then _0x76:Destroy() end
			end

			for _, _0x77 in ipairs(optionsList) do
				local _0x78 = _0x9("\84\101\120\116\66\117\116\116\111\110", {
					Name = "\79\112\116\95" .. tostring(_0x77),
					Size = UDim2.new(1, 0, 0, 22),
					BackgroundColor3 = Color3.fromRGB(240, 240, 240),
					BackgroundTransparency = (4/10),
					Text = tostring(_0x77),
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 11,
					FontFace = Font.new("\114\098\120\097\115\115\101\116\105\100\58\47\47\49\50\49\56\55\51\55\53\55\49\54"),
					Parent = _0x72
				}, {Corner = 4, Stroke = {Thickness = 1, Transparency = (8/10)}})

				_0x78.MouseButton1Click:Connect(function()
					_0x19()
					_0x6F = _0x77
					_0x71.Text = tostring(_0x6F) .. " ▼"
					_0x74 = false
					_0x4:Create(_0x70, TweenInfo.new((25/100)), {Size = UDim2.new(1, 0, 0, 32)}):Play()
					if callback then
						pcall(callback, _0x6F)
					end
				end)
			end
		end

		_0x71.MouseButton1Click:Connect(function()
			_0x19()
			_0x74 = not _0x74
			if _0x74 then
				_0x75()
				local _0x79 = 40 + _0x73.AbsoluteContentSize.Y
				_0x4:Create(_0x70, TweenInfo.new((25/100)), {Size = UDim2.new(1, 0, 0, _0x79)}):Play()
			else
				_0x4:Create(_0x70, TweenInfo.new((25/100)), {Size = UDim2.new(1, 0, 0, 32)}):Play()
			end
		end)

		return _0x70
	end

	tabObj.AddSection  = tabObj.CreateSection
	tabObj.AddLabel    = tabObj.CreateLabel
	tabObj.AddButton   = tabObj.CreateButton
	tabObj.AddToggle   = tabObj.CreateToggle
	tabObj.AddSlider   = tabObj.CreateSlider
	tabObj.AddInput    = tabObj.CreateInput
	tabObj.AddDropdown = tabObj.CreateDropdown

	return tabObj
end

windowInstance.AddTab = windowInstance.CreateTab

return windowInstance


end

return library
