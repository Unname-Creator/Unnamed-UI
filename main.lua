local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
--/check/
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Môi trường Executor vs Studio
local targetGui = PlayerGui
pcall(function()
	local test = CoreGui.Name
	targetGui = CoreGui
end)

local library = {
	CoreGui = CoreGui,
	PlayerGui = PlayerGui,
	Gui = targetGui
}

-- HELPER FUNCTION: Tạo UI & tự động gắn UICorner / UIStroke / UIGradient
local function createUI(className, properties, styles)
	local instance = Instance.new(className)
	for prop, val in pairs(properties or {}) do
		instance[prop] = val
	end

	styles = styles or {}
	if styles.Corner then
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, styles.Corner)
		corner.Parent = instance
	end
	if styles.Stroke then
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = styles.Stroke.Thickness or 1.5
		stroke.Transparency = styles.Stroke.Transparency or 0.7
		stroke.Color = styles.Stroke.Color or Color3.fromRGB(0, 0, 0)
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Parent = instance
	end
	if styles.Gradient then
		local grad = Instance.new("UIGradient")
		grad.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
		grad.Transparency = NumberSequence.new(styles.Gradient.Start or 0.75, styles.Gradient.End or 0)
		grad.Parent = instance
	end

	return instance


end

function library:CreateWindow(options)
	if type(options) == "string" then
		options = { Title = options }
	else
		options = options or {}
	end

	local title = options.Title or "My UI Window"
	local version = options.Version or "1.0.0"
	local toggleKey = options.Keybind or Enum.KeyCode.RightControl
	local imageid = options.Image or "rbxassetid://10566696606"
	local soundId = options.ClickSound ~= nil and options.ClickSound or options.sound
	if soundId == nil then
		soundId = "rbxassetid://8388724806"
	end

	-- 1. ScreenGui
	local Screen = createUI("ScreenGui", {
		Name = title .. "_Gui",
		Enabled = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = targetGui
	})

	-- 2. Main Frame
	local Main = createUI("Frame", {
		Name = "Main",
		Size = UDim2.new(0, 420, 0, 260),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Active = true,
		Parent = Screen
	}, {
		Corner = 10,
		Stroke = {Thickness = 2, Transparency = 0.7},
		Gradient = {Start = 0.9, End = 0}
	})

	local soundbutton = Instance.new("Sound")
	if soundId ~= 0 and soundId ~= false then
		soundbutton.SoundId = tostring(soundId):find("rbxassetid://") and soundId or ("rbxassetid://" .. tostring(soundId))
	end
	soundbutton.Volume = 0.5
	soundbutton.Parent = Main

	local function activesound()
		if soundId ~= 0 and soundId ~= false then
			soundbutton:Play()
		end
	end

	-- Smooth Dragging
	local dragging, dragInput, dragStart, startPos

	Main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	Main.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			Main.Position = Main.Position:Lerp(targetPos, 0.2)
		end
	end)

	-- Logo Frame
	createUI("ImageLabel", {
		Name = "image",
		Size = UDim2.new(0, 45, 0, 45),
		Position = UDim2.new(0.03, 0, 0.03, 0),
		BackgroundTransparency = 1,
		Image = imageid,
		ImageTransparency = 0.1,
		Parent = Main
	}, {Corner = 10, Stroke = {Thickness = 1.5, Transparency = 0.8}})

	-- Title
	createUI("TextLabel", {
		Name = "NameGui",
		Size = UDim2.new(0, 200, 0, 20),
		Position = UDim2.new(0.16, 0, 0.028, 0),
		BackgroundTransparency = 0.8,
		Text = title,
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14,
		FontFace = Font.new("rbxassetid://12187375716"),
		Parent = Main
	}, {Corner = 10, Stroke = {Thickness = 1.5, Transparency = 0.8}})

	-- Version
	createUI("TextLabel", {
		Name = "Version",
		Size = UDim2.new(0, 100, 0, 18),
		Position = UDim2.new(0.16, 0, 0.12, 0),
		BackgroundTransparency = 0.8,
		Text = "Version: V" .. version,
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 12,
		FontFace = Font.new("rbxassetid://12187375716"),
		Parent = Main
	}, {Corner = 10, Stroke = {Thickness = 1.5, Transparency = 0.8}})

	-- Window Buttons
	local CloseBtn = createUI("TextButton", {Name = "Closebtn", Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new(0.92, 0, 0.028, 0), BackgroundTransparency = 1, Text = "🔴", TextScaled = true, Parent = Main})
	local ScaleBtn = createUI("TextButton", {Name = "Scalebtn", Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new(0.84, 0, 0.028, 0), BackgroundTransparency = 1, Text = "🟡", TextScaled = true, Parent = Main})
	local MinisizeBtn = createUI("TextButton", {Name = "Minisizebtn", Size = UDim2.new(0, 25, 0, 25), Position = UDim2.new(0.76, 0, 0.028, 0), BackgroundTransparency = 1, Text = "🟢", TextScaled = true, Parent = Main})

	-- Confirm Close Dialog
	local ConfirmHolder = createUI("Frame", {
		Name = "ConfirmHolder",
		Size = UDim2.new(0, 280, 0, 120),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Visible = false,
		ZIndex = 20,
		Parent = Screen
	}, {
		Corner = 10,
		Stroke = {Thickness = 2, Transparency = 0.7},
		Gradient = {Start = 0.6, End = 0}
	})

	createUI("TextLabel", {
		Name = "ConfirmText",
		Size = UDim2.new(0.9, 0, 0, 35),
		Position = UDim2.new(0.05, 0, 0.15, 0),
		BackgroundTransparency = 0.6,
		Text = "Are you sure to close GUI?",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 15,
		FontFace = Font.new("rbxassetid://12187375716"),
		Parent = ConfirmHolder
	}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.8}})

	local YeahBtn = createUI("TextButton", {
		Name = "Yeah",
		Size = UDim2.new(0, 100, 0, 35),
		Position = UDim2.new(0.1, 0, 0.55, 0),
		BackgroundTransparency = 0.5,
		Text = "Yeah",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14,
		FontFace = Font.new("rbxassetid://12187375716"),
		Parent = ConfirmHolder
	}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.8}})

	local NopeBtn = createUI("TextButton", {
		Name = "Nope",
		Size = UDim2.new(0, 100, 0, 35),
		Position = UDim2.new(0.55, 0, 0.55, 0),
		BackgroundTransparency = 0.5,
		Text = "Nope",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14,
		FontFace = Font.new("rbxassetid://12187375716"),
		Parent = ConfirmHolder
	}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.8}})

	CloseBtn.MouseButton1Click:Connect(function()
		ConfirmHolder.Visible = true
		Main.Visible = false
		activesound()
		Main:SetAttribute("ischoosed", true) 
	end)

	YeahBtn.MouseButton1Click:Connect(function()
		Screen.Enabled = false
		activesound()
		task.wait(0.2)
		Screen:Destroy()
	end)

	NopeBtn.MouseButton1Click:Connect(function()
		ConfirmHolder.Visible = false
		activesound()
		Main.Visible = true
		Main:SetAttribute("ischoosed", false)
	end)

	-- UIScale
	local UIScale = Instance.new("UIScale")
	UIScale.Scale = 1
	UIScale.Parent = Main

	local isScaled = false
	local scaleTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	ScaleBtn.MouseButton1Click:Connect(function()
		isScaled = not isScaled
		local targetScale = isScaled and 1.35 or 1 
		TweenService:Create(UIScale, scaleTweenInfo, {Scale = targetScale}):Play()
		activesound()
	end)

	-- Notification Container
	local NotifFrame = createUI("Frame", {
		Name = "noticationframe",
		Size = UDim2.new(0, 270, 0, 300),
		Position = UDim2.new(1, -280, 1, -310),
		BackgroundTransparency = 1,
		ZIndex = 2,
		Parent = Screen
	})

	local NotifFolder = Instance.new("Folder")
	NotifFolder.Name = "Folder"
	NotifFolder.Parent = NotifFrame

	createUI("UIListLayout", {
		Name = "UIListLayout",
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 7),
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = NotifFolder
	})

	-- Toggle Hint UI
	local keyName = toggleKey.Name
	local HintFrame = createUI("Frame", {
		Name = "HintFrame",
		Size = UDim2.new(0, 220, 0, 30),
		Position = UDim2.new(0.025, 0, 0.925, 0),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 1,
		Visible = false,
		ZIndex = 10,
		Parent = Screen
	}, {
		Corner = 8,
		Stroke = {Thickness = 1.5, Transparency = 1, Color = Color3.fromRGB(255, 255, 255)}
	})

	local HintStroke = HintFrame:FindFirstChildOfClass("UIStroke")

	local HintLabel = createUI("TextLabel", {
		Name = "HintLabel",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "Press [" .. keyName .. "] to Toggle GUI",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextTransparency = 1,
		TextSize = 13,
		FontFace = Font.new("rbxassetid://12187375716"),
		Parent = HintFrame
	})

	-- Logic Minisize
	local isMinimized = false
	local hintThread = nil
	local tweenFast = TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local tweenFast2 = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	local function showHint()
		HintFrame.Visible = true
		TweenService:Create(HintFrame, tweenFast2, {BackgroundTransparency = 0.3}):Play()
		TweenService:Create(HintLabel, tweenFast2, {TextTransparency = 0}):Play()
		if HintStroke then
			TweenService:Create(HintStroke, tweenFast2, {Transparency = 0.6}):Play()
		end
	end

	local function hideHint()
		local t1 = TweenService:Create(HintFrame, tweenFast, {BackgroundTransparency = 1})
		local t2 = TweenService:Create(HintLabel, tweenFast, {TextTransparency = 1})
		t1:Play()
		t2:Play()
		if HintStroke then
			TweenService:Create(HintStroke, tweenFast, {Transparency = 1}):Play()
		end

		t1.Completed:Connect(function()
			if HintFrame.BackgroundTransparency >= 0.99 then
				HintFrame.Visible = false
			end
		end)
	end

	local function toggleMinimize()
		if Main:GetAttribute("ischoosed") == true then
			return
		end

		isMinimized = not isMinimized
		Main.Visible = not isMinimized

		if hintThread then task.cancel(hintThread) end

		if isMinimized then
			showHint()
			hintThread = task.delay(1.6, function()
				hideHint()
			end)
		else
			hideHint()
		end
	end

	MinisizeBtn.MouseButton1Click:Connect(function()
		activesound()
		toggleMinimize()
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end

		if input.KeyCode == toggleKey then
			if Main:GetAttribute("ischoosed") == true then
				return
			end
			activesound()
			toggleMinimize()
		end
	end)

	-- Tab Scroll Frame
	local TabScroll = createUI("ScrollingFrame", {
		Name = "TabScroll",
		Size = UDim2.new(0, 100, 0, 200),
		Position = UDim2.new(0.74, 0, 0.2, 0),
		BackgroundTransparency = 1,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 2,
		Parent = Main
	})

	local TabFolder = createUI("Folder", {Name = "TabFolder", Parent = TabScroll})
	createUI("UIListLayout", {
		Name = "UIListLayout",
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = TabFolder
	})

	-- Function Frame
	local FunctionHover = createUI("Frame", {
		Name = "Functionhover",
		Size = UDim2.new(0, 290, 0, 200),
		Position = UDim2.new(0.03, 0, 0.22, 0),
		BackgroundTransparency = 0.4,
		Parent = Main
	}, {Corner = 10, Stroke = {Thickness = 1.5, Transparency = 0.7}})

	local FunctionTabFolder = createUI("Folder", {Name = "Functiontab", Parent = FunctionHover})

	-- Object Window Instance
	local windowInstance = {
		Screen = Screen,
		Main = Main,
		TabFolder = TabFolder,
		FunctionTabFolder = FunctionTabFolder,
		NotifFolder = NotifFolder,
		Tabs = {},
		FirstTab = nil
	}

	-- Hàm đóng Notification
	local function closeNotification(wrapper, frameholder, tweenInfo)
		if not wrapper or wrapper:GetAttribute("IsClosing") then return end
		wrapper:SetAttribute("IsClosing", true)

		if frameholder then
			local slideOut = TweenService:Create(frameholder, tweenInfo, {Position = UDim2.new(1.2, 0, 0, 0)})
			slideOut:Play()

			slideOut.Completed:Connect(function()
				wrapper:Destroy()
			end)
		else
			wrapper:Destroy()
		end
	end

	-- Hàm xuất Inform/Notify
	function windowInstance:Notify(notifTitle, notifText, duration)
		duration = duration or 3
		local tweenOut = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

		local activeNotifs = self.NotifFolder:GetChildren()
		local notifWrappers = {}

		for _, child in ipairs(activeNotifs) do
			if child:IsA("Frame") and not child:GetAttribute("IsClosing") then
				table.insert(notifWrappers, child)
			end
		end

		if #notifWrappers >= 2 then
			local oldestWrapper = notifWrappers[1]
			local oldestFrame = oldestWrapper:FindFirstChild("frameholder")
			closeNotification(oldestWrapper, oldestFrame, tweenOut)
		end

		local wrapper = createUI("Frame", {
			Name = "NotifWrapper",
			Size = UDim2.new(0, 270, 0, 75),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Parent = self.NotifFolder
		})

		local frameholder = createUI("Frame", {
			Name = "frameholder",
			Size = UDim2.new(1, 0, 0, 75),
			Position = UDim2.new(1.2, 0, 0, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.6,
			Parent = wrapper
		}, {
			Corner = 10,
			Stroke = {Thickness = 2, Transparency = 0.7},
			Gradient = {Start = 0.9, End = 0}
		})

		local Holder = createUI("Frame", {
			Name = "Holder",
			Size = UDim2.new(0, 241, 0, 20),
			Position = UDim2.new(0.037, 0, 0.0933, 0),
			BackgroundTransparency = 1,
			Parent = frameholder
		})

		createUI("TextLabel", {
			Name = "Notication",
			Size = UDim2.new(0, 250, 0, 20),
			Position = UDim2.new(0, 0, -0.1, 0),
			BackgroundTransparency = 1,
			Text = (notifTitle or "Notification!"),
			TextColor3 = Color3.fromRGB(51, 51, 51),
			TextSize = 14,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("rbxassetid://12187375716"),
			Parent = Holder
		})

		local letterHolder = createUI("Frame", {
			Name = "letter_holder",
			Size = UDim2.new(0, 270, 0, 47),
			Position = UDim2.new(0, 0, 0.3333, 0),
			BackgroundTransparency = 1,
			Parent = frameholder
		}, {Corner = 10})

		createUI("TextLabel", {
			Name = "letter",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = notifText or "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			FontFace = Font.new("rbxassetid://12187375716"),
			Parent = letterHolder
		}, {Corner = 10})

		local tweenIn = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		TweenService:Create(frameholder, tweenIn, {Position = UDim2.new(0, 0, 0, 0)}):Play()

		task.delay(duration, function()
			if wrapper and wrapper.Parent then
				closeNotification(wrapper, frameholder, tweenOut)
			end
		end)
	end

	function windowInstance:CreateTab(name)
		name = name or "Tab"

		local tabButton = createUI("TextButton", {
			Name = name .. "_Button",
			Size = UDim2.new(0, 95, 0, 30),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.7,
			Text = name,
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 13,
			FontFace = Font.new("rbxassetid://12187375716"),
			Parent = self.TabFolder
		}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.7}})

		local tabContainer = createUI("ScrollingFrame", {
			Name = name .. "_Container",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 3,
			Visible = false,
			Parent = self.FunctionTabFolder
		})

		createUI("UIPadding", {
			PaddingTop = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 6),
			PaddingLeft = UDim.new(0, 6),
			PaddingRight = UDim.new(0, 6),
			Parent = tabContainer
		})

		createUI("UIListLayout", {
			Name = "UIListLayout",
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = tabContainer
		})

		local tabObj = {
			Button = tabButton,
			Container = tabContainer
		}

		tabButton.MouseButton1Click:Connect(function()
			activesound()
			for _, t in pairs(windowInstance.Tabs) do
				t.Container.Visible = false
				t.Button.BackgroundTransparency = 0.7
			end
			tabContainer.Visible = true
			tabButton.BackgroundTransparency = 0.3
		end)

		if not windowInstance.FirstTab then
			windowInstance.FirstTab = tabObj
			tabContainer.Visible = true
			tabButton.BackgroundTransparency = 0.3
		end

		table.insert(windowInstance.Tabs, tabObj)

		-- 1. HÀM TẠO SECTION HEADER
		function tabObj:CreateSection(sectionText)
			local sectionFrame = createUI("Frame", {
				Name = (sectionText or "Section") .. "_Section",
				Size = UDim2.new(1, 0, 0, 24),
				BackgroundTransparency = 1,
				Parent = self.Container
			})

			createUI("TextLabel", {
				Name = "Title",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = "—  " .. (sectionText or "Section") .. "  —",
				TextColor3 = Color3.fromRGB(30, 30, 30),
				TextSize = 13,
				FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Bold),
				TextXAlignment = Enum.TextXAlignment.Center,
				Parent = sectionFrame
			})

			return sectionFrame
		end

		-- 2. HÀM TẠO LABEL THÔNG TIN
		function tabObj:CreateLabel(labelText)
			local labelFrame = createUI("Frame", {
				Name = "LabelFrame",
				Size = UDim2.new(1, 0, 0, 26),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.8,
				Parent = self.Container
			}, {Corner = 6, Stroke = {Thickness = 1, Transparency = 0.8}})

			createUI("TextLabel", {
				Name = "Text",
				Size = UDim2.new(1, -12, 1, 0),
				Position = UDim2.new(0, 6, 0, 0),
				BackgroundTransparency = 1,
				Text = labelText or "Label",
				TextColor3 = Color3.fromRGB(20, 20, 20),
				TextSize = 12,
				FontFace = Font.new("rbxassetid://12187375716"),
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = labelFrame
			})

			return labelFrame
		end

		-- 3. HÀM TẠO BUTTON
		function tabObj:CreateButton(labelText, btnText, callback)
			if typeof(btnText) == "function" then
				callback = btnText
				btnText = "Click"
			end
			btnText = btnText or "Click"

			local buttonFrame = createUI("Frame", {
				Name = (labelText or "Button") .. "_Frame",
				Size = UDim2.new(1, 0, 0, 32),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.6,
				Parent = self.Container
			}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.7}})

			createUI("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0.65, 0, 1, 0),
				Position = UDim2.new(0.04, 0, 0, 0),
				BackgroundTransparency = 1,
				Text = labelText or "Button",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = buttonFrame
			})

			local actionBtn = createUI("TextButton", {
				Name = "ActionButton",
				Size = UDim2.new(0, 70, 0, 22),
				Position = UDim2.new(0.96, -70, 0.5, -11),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.3,
				Text = btnText,
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 12,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = buttonFrame
			}, {Corner = 6, Stroke = {Thickness = 1, Transparency = 0.7}})

			local function trigger()
				activesound()
				TweenService:Create(actionBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.7}):Play()
				task.delay(0.1, function()
					TweenService:Create(actionBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.3}):Play()
				end)
				if callback then
					pcall(callback)
				end
			end

			actionBtn.MouseButton1Click:Connect(trigger)

			return buttonFrame
		end

		-- 4. HÀM TẠO TOGGLE
		function tabObj:CreateToggle(toggleText, defaultState, callback)
			if typeof(defaultState) == "function" then
				callback = defaultState
				defaultState = false
			end
			defaultState = defaultState or false

			local toggleFrame = createUI("Frame", {
				Name = toggleText .. "_Toggle",
				Size = UDim2.new(1, 0, 0, 32),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.6,
				Parent = self.Container
			}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.7}})

			createUI("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0.7, 0, 1, 0),
				Position = UDim2.new(0.04, 0, 0, 0),
				BackgroundTransparency = 1,
				Text = toggleText or "Toggle",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = toggleFrame
			})

			local switchFrame = createUI("Frame", {
				Name = "Switch",
				Size = UDim2.new(0, 42, 0, 20),
				Position = UDim2.new(0.96, -42, 0.5, -10),
				BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(150, 150, 150),
				BackgroundTransparency = 0.2,
				Parent = toggleFrame
			}, {Corner = 10, Stroke = {Thickness = 1, Transparency = 0.8}})

			local knob = createUI("Frame", {
				Name = "Knob",
				Size = UDim2.new(0, 16, 0, 16),
				Position = defaultState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = switchFrame
			}, {Corner = 8})

			local clickBtn = createUI("TextButton", {
				Name = "Clicker",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = "",
				Parent = toggleFrame
			})

			local toggled = defaultState
			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

			clickBtn.MouseButton1Click:Connect(function()
				activesound()
				toggled = not toggled

				local targetKnobPos = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
				local targetBgColor = toggled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(150, 150, 150)

				TweenService:Create(knob, tweenInfo, {Position = targetKnobPos}):Play()
				TweenService:Create(switchFrame, tweenInfo, {BackgroundColor3 = targetBgColor}):Play()

				if callback then
					pcall(callback, toggled)
				end
			end)

			return toggleFrame
		end


		-- 5. HÀM TẠO SLIDER
		function tabObj:CreateSlider(sliderText, min, max, default, callback)
			min = min or 0
			max = max or 100
			default = math.clamp(default or min, min, max)

			local sliderFrame = createUI("Frame", {
				Name = (sliderText or "Slider") .. "_Slider",
				Size = UDim2.new(1, 0, 0, 46),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.6,
				Parent = self.Container
			}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.7}})

			createUI("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0.6, 0, 0, 20),
				Position = UDim2.new(0.04, 0, 0.08, 0),
				BackgroundTransparency = 1,
				Text = sliderText or "Slider",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = sliderFrame
			})

			local valLabel = createUI("TextLabel", {
				Name = "Value",
				Size = UDim2.new(0.3, 0, 0, 20),
				Position = UDim2.new(0.66, 0, 0.08, 0),
				BackgroundTransparency = 1,
				Text = tostring(default),
				TextColor3 = Color3.fromRGB(40, 40, 40),
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Right,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = sliderFrame
			})

			local track = createUI("Frame", {
				Name = "Track",
				Size = UDim2.new(0.92, 0, 0, 8),
				Position = UDim2.new(0.04, 0, 0.68, 0),
				BackgroundColor3 = Color3.fromRGB(180, 180, 180),
				BackgroundTransparency = 0.3,
				Parent = sliderFrame
			}, {Corner = 4, Stroke = {Thickness = 1, Transparency = 0.8}})

			local initialPercent = (default - min) / (max - min)
			local fill = createUI("Frame", {
				Name = "Fill",
				Size = UDim2.new(initialPercent, 0, 1, 0),
				BackgroundColor3 = Color3.fromRGB(0, 170, 255),
				Parent = track
			}, {Corner = 4})

			local knob = createUI("Frame", {
				Name = "Knob",
				Size = UDim2.new(0, 14, 0, 14),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(1, 0, 0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = fill
			}, {Corner = 7, Stroke = {Thickness = 1, Transparency = 0.5, Color = Color3.fromRGB(0, 120, 200)}})

			local triggerBtn = createUI("TextButton", {
				Name = "Trigger",
				Size = UDim2.new(1, 0, 1, 10),
				Position = UDim2.new(0, 0, 0, -5),
				BackgroundTransparency = 1,
				Text = "",
				Parent = track
			})

			local isDragging = false

			local function updateSlider(input)
				local trackAbsPos = track.AbsolutePosition.X
				local trackAbsSize = track.AbsoluteSize.X
				local relativeX = input.Position.X - trackAbsPos
				local percent = math.clamp(relativeX / trackAbsSize, 0, 1)

				local value = math.floor(min + (max - min) * percent)
				fill.Size = UDim2.new(percent, 0, 1, 0)
				valLabel.Text = tostring(value)

				if callback then
					pcall(callback, value)
				end
			end

			triggerBtn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true
					activesound()
					updateSlider(input)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateSlider(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end)

			return sliderFrame
		end

		-- 6. HÀM TẠO INPUT (TEXTBOX)
		function tabObj:CreateInput(inputText, placeholderText, callback)
			local inputFrame = createUI("Frame", {
				Name = (inputText or "Input") .. "_Frame",
				Size = UDim2.new(1, 0, 0, 32),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.6,
				Parent = self.Container
			}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.7}})

			createUI("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0.5, 0, 1, 0),
				Position = UDim2.new(0.04, 0, 0, 0),
				BackgroundTransparency = 1,
				Text = inputText or "Input",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = inputFrame
			})

			local textBox = createUI("TextBox", {
				Name = "TextBox",
				Size = UDim2.new(0, 110, 0, 22),
				Position = UDim2.new(0.96, -110, 0.5, -11),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.2,
				PlaceholderText = placeholderText or "Enter text...",
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 12,
				FontFace = Font.new("rbxassetid://12187375716"),
				ClearTextOnFocus = false,
				Parent = inputFrame
			}, {Corner = 6, Stroke = {Thickness = 1, Transparency = 0.7}})

			textBox.FocusLost:Connect(function(enterPressed)
				activesound()
				if callback then
					pcall(callback, textBox.Text, enterPressed)
				end
			end)

			return inputFrame
		end

		-- 7. HÀM TẠO DROPDOWN
		function tabObj:CreateDropdown(dropdownText, optionsList, defaultOption, callback)
			optionsList = optionsList or {}
			local selected = defaultOption or optionsList[1] or "None"

			local dropFrame = createUI("Frame", {
				Name = (dropdownText or "Dropdown") .. "_Dropdown",
				Size = UDim2.new(1, 0, 0, 32),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.6,
				ClipsDescendants = true,
				Parent = self.Container
			}, {Corner = 8, Stroke = {Thickness = 1.5, Transparency = 0.7}})

			createUI("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0.5, 0, 0, 32),
				Position = UDim2.new(0.04, 0, 0, 0),
				BackgroundTransparency = 1,
				Text = dropdownText or "Dropdown",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = dropFrame
			})

			local selectBtn = createUI("TextButton", {
				Name = "SelectButton",
				Size = UDim2.new(0, 110, 0, 22),
				Position = UDim2.new(0.96, -110, 0, 5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.3,
				Text = tostring(selected) .. " ▼",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 11,
				FontFace = Font.new("rbxassetid://12187375716"),
				Parent = dropFrame
			}, {Corner = 6, Stroke = {Thickness = 1, Transparency = 0.7}})

			local optionContainer = createUI("Frame", {
				Name = "OptionsContainer",
				Size = UDim2.new(0.92, 0, 0, 0),
				Position = UDim2.new(0.04, 0, 0, 36),
				BackgroundTransparency = 1,
				Parent = dropFrame
			})

			local dropLayout = createUI("UIListLayout", {
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = optionContainer
			})

			local isOpen = false

			local function renderOptions()
				for _, child in ipairs(optionContainer:GetChildren()) do
					if child:IsA("TextButton") then child:Destroy() end
				end

				for _, opt in ipairs(optionsList) do
					local optBtn = createUI("TextButton", {
						Name = "Opt_" .. tostring(opt),
						Size = UDim2.new(1, 0, 0, 22),
						BackgroundColor3 = Color3.fromRGB(240, 240, 240),
						BackgroundTransparency = 0.4,
						Text = tostring(opt),
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 11,
						FontFace = Font.new("rbxassetid://12187375716"),
						Parent = optionContainer
					}, {Corner = 4, Stroke = {Thickness = 1, Transparency = 0.8}})

					optBtn.MouseButton1Click:Connect(function()
						activesound()
						selected = opt
						selectBtn.Text = tostring(selected) .. " ▼"
						isOpen = false
						TweenService:Create(dropFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 0, 32)}):Play()
						if callback then
							pcall(callback, selected)
						end
					end)
				end
			end

			selectBtn.MouseButton1Click:Connect(function()
				activesound()
				isOpen = not isOpen
				if isOpen then
					renderOptions()
					local targetHeight = 40 + dropLayout.AbsoluteContentSize.Y
					TweenService:Create(dropFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
				else
					TweenService:Create(dropFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 0, 32)}):Play()
				end
			end)

			return dropFrame
		end

		-- ALIASES NGẮN GỌN (CHO DỄ VIẾT CODE)
		tabObj.AddSection  = tabObj.CreateSection
		tabObj.AddLabel    = tabObj.CreateLabel
		tabObj.AddButton   = tabObj.CreateButton
		tabObj.AddToggle   = tabObj.CreateToggle
		tabObj.AddSlider   = tabObj.CreateSlider
		tabObj.AddInput    = tabObj.CreateInput
		tabObj.AddDropdown = tabObj.CreateDropdown

		return tabObj
	end

	-- ALIASES NGẮN GỌN CHO WINDOW
	windowInstance.AddTab = windowInstance.CreateTab

	return windowInstance


end

return library
