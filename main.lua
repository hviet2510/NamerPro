local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "StackFlowUI"

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- TitleBar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -35, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "StackFlow Custom"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)

-- Tabs Holder
local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(0, 120, 1, -35)
TabsFrame.Position = UDim2.new(0, 0, 0, 35)
TabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", TabsFrame).CornerRadius = UDim.new(0, 8)

local TabLayout = Instance.new("UIListLayout", TabsFrame)
TabLayout.Padding = UDim.new(0, 5)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Pages Frame
local PagesFrame = Instance.new("Frame", MainFrame)
PagesFrame.Size = UDim2.new(1, -130, 1, -40)
PagesFrame.Position = UDim2.new(0, 130, 0, 40)
PagesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", PagesFrame).CornerRadius = UDim.new(0, 8)

-- Tabs system
local Tabs = {}
local function CreateTab(name)
	local TabButton = Instance.new("TextButton", TabsFrame)
	TabButton.Size = UDim2.new(1, -10, 0, 30)
	TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
	Layout.Padding = UDim.new(0, 8)
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
	Button.Size = UDim2.new(0, 200, 0, 30)
	Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.Gotham
	Button.TextSize = 14
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
	Button.MouseButton1Click:Connect(callback)
end

-- Animation Close/Open
local open = true
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local closedPos = UDim2.new(0.5, -250, 0.5, -400)
local openPos = UDim2.new(0.5, -250, 0.5, -150)

CloseButton.MouseButton1Click:Connect(function()
	open = not open
	local goal = {Position = open and openPos or closedPos}
	TweenService:Create(MainFrame, tweenInfo, goal):Play()
end)

-- Dragging
local dragging = false
local dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
	end
end)

-- Thêm Spacer để đẩy Toggle xuống giữa TabsFrame
local Spacer = Instance.new("Frame", TabsFrame)
Spacer.Size = UDim2.new(1, 0, 0, 80)
Spacer.BackgroundTransparency = 1

-- Thêm Toggle vào TabsFrame (giữa bên trái)
local function CreateSidebarToggle(name, callback)
	local Toggle = Instance.new("TextButton", TabsFrame)
	Toggle.Size = UDim2.new(1, -10, 0, 30)
	Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 14
	Toggle.Text = name .. ": OFF"
	Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

	local state = false
	Toggle.MouseButton1Click:Connect(function()
		state = not state
		Toggle.Text = name .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

-- Thêm Toggle mẫu vào bên trái giữa
CreateSidebarToggle("Auto Farm", function(state)
	print("Auto Farm:", state)
end)

-- Thêm Tabs + Button vào nội dung chính
local MainTab = CreateTab("Main")
CreateButton(MainTab, "Test Button", function()
	print("Clicked!")
end)
MainTab.Visible = true
