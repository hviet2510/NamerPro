local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "StackFlowCustom"

-- Drag function
local UIS = game:GetService("UserInputService")
local function MakeDraggable(frame)
	local dragging, dragInput, dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
		end
	end)
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

MakeDraggable(MainFrame)

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- TitleBar
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "StackFlow Custom UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Tabs Holder
local TabsFrame = Instance.new("Frame")
TabsFrame.Parent = MainFrame
TabsFrame.Size = UDim2.new(0, 120, 1, -35)
TabsFrame.Position = UDim2.new(0, 0, 0, 35)
TabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", TabsFrame).CornerRadius = UDim.new(0, 8)

-- Tabs Buttons Layout
local TabLayout = Instance.new("UIListLayout", TabsFrame)
TabLayout.Padding = UDim.new(0, 5)
TabLayout.FillDirection = Enum.FillDirection.Vertical
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Pages Holder
local PagesFrame = Instance.new("Frame")
PagesFrame.Parent = MainFrame
PagesFrame.Size = UDim2.new(1, -130, 1, -40)
PagesFrame.Position = UDim2.new(0, 130, 0, 40)
PagesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", PagesFrame).CornerRadius = UDim.new(0, 8)

-- Function to create Tabs + Pages
local Tabs = {}
local function CreateTab(name)
	local TabButton = Instance.new("TextButton")
	TabButton.Parent = TabsFrame
	TabButton.Size = UDim2.new(1, -10, 0, 30)
	TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.Font = Enum.Font.Gotham
	TabButton.Text = name
	TabButton.TextSize = 14
	Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

	local Page = Instance.new("Frame")
	Page.Parent = PagesFrame
	Page.Size = UDim2.new(1, -10, 1, -10)
	Page.Position = UDim2.new(0, 5, 0, 5)
	Page.BackgroundTransparency = 1
	Page.Visible = false

	local Layout = Instance.new("UIListLayout", Page)
	Layout.Padding = UDim.new(0, 8)
	Layout.FillDirection = Enum.FillDirection.Vertical
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

	TabButton.MouseButton1Click:Connect(function()
		for _, v in pairs(PagesFrame:GetChildren()) do
			if v:IsA("Frame") then
				v.Visible = false
			end
		end
		Page.Visible = true
	end)

	Tabs[name] = Page
	return Page
end

-- Function to create Buttons inside Pages
local function CreateButton(page, text, callback)
	local Button = Instance.new("TextButton")
	Button.Parent = page
	Button.Size = UDim2.new(0, 200, 0, 30)
	Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.Gotham
	Button.TextSize = 14
	Button.Text = text
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
	Button.MouseButton1Click:Connect(callback)
end

-- Function to create Toggle
local function CreateToggle(page, text, callback)
	local Toggle = Instance.new("TextButton")
	Toggle.Parent = page
	Toggle.Size = UDim2.new(0, 200, 0, 30)
	Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 14
	Toggle.Text = text .. ": OFF"
	Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

	local state = false
	Toggle.MouseButton1Click:Connect(function()
		state = not state
		Toggle.Text = text .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

-- Example Tabs & Buttons
local MainTab = CreateTab("Main")
local SettingsTab = CreateTab("Settings")

-- Example Buttons
CreateButton(MainTab, "Click Me", function()
	print("Button clicked!")
end)

CreateToggle(SettingsTab, "God Mode", function(state)
	print("God Mode:", state)
end)

-- Show first tab by default
for _, v in pairs(PagesFrame:GetChildren()) do
	if v:IsA("Frame") then
		v.Visible = false
	end
end
MainTab.Visible = true
