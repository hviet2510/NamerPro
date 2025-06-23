local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "WindUI"
ScreenGui.ResetOnSpawn = false

-- Main Window
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- TitleBar
local TitleBar = Instance.new("TextLabel", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Text = "Wind UI"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 16
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

-- Tabs List
local TabsFrame = Instance.new("Frame", Main)
TabsFrame.Size = UDim2.new(0, 120, 1, -40)
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TabsFrame).CornerRadius = UDim.new(0, 6)

local TabsLayout = Instance.new("UIListLayout", TabsFrame)
TabsLayout.Padding = UDim.new(0, 6)
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Pages Area
local PagesFrame = Instance.new("Frame", Main)
PagesFrame.Size = UDim2.new(1, -130, 1, -50)
PagesFrame.Position = UDim2.new(0, 130, 0, 45)
PagesFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", PagesFrame).CornerRadius = UDim.new(0, 6)

-- Tabs Logic
local Tabs = {}
local function CreateTab(name)
	local TabButton = Instance.new("TextButton", TabsFrame)
	TabButton.Size = UDim2.new(1, -10, 0, 30)
	TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabButton.Text = name
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.Font = Enum.Font.Gotham
	TabButton.TextSize = 14
	Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

	local Page = Instance.new("Frame", PagesFrame)
	Page.Size = UDim2.new(1, -10, 1, -10)
	Page.Position = UDim2.new(0, 5, 0, 5)
	Page.BackgroundTransparency = 1
	Page.Visible = false

	local Layout = Instance.new("UIListLayout", Page)
	Layout.Padding = UDim.new(0, 6)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

	TabButton.MouseButton1Click:Connect(function()
		for _, v in pairs(PagesFrame:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		Page.Visible = true
	end)

	Tabs[name] = Page
	return Page
end

local function CreateButton(page, text, callback)
	local Button = Instance.new("TextButton", page)
	Button.Size = UDim2.new(0, 220, 0, 30)
	Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.Gotham
	Button.TextSize = 14
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
	Button.MouseButton1Click:Connect(callback)
end

local function CreateToggle(page, text, default, callback)
	local Toggle = Instance.new("TextButton", page)
	Toggle.Size = UDim2.new(0, 220, 0, 30)
	Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 14
	Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

	local state = default
	local function updateText()
		Toggle.Text = text .. ": " .. (state and "ON" or "OFF")
	end
	updateText()

	Toggle.MouseButton1Click:Connect(function()
		state = not state
		updateText()
		callback(state)
	end)
end

-- Example Tabs & Content
local MainTab = CreateTab("Main")
CreateButton(MainTab, "Click Me", function() print("Clicked") end)
CreateToggle(MainTab, "Auto Farm", false, function(v) print("Auto Farm:", v) end)
MainTab.Visible = true
