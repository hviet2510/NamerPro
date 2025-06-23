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

-- Thêm tween info và vị trí đóng/mở
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local open = true
local openPos = UDim2.new(0.5, -250, 0.5, -150)
local closedPos = UDim2.new(0.5, -250, 0.5, -MainFrame.Size.Y.Offset - 20)

-- Nút bật/tắt menu ngoài UI (phải trên, không ảnh, bo góc, kéo được)
local MenuToggleButton = Instance.new("TextButton")
MenuToggleButton.Parent = ScreenGui
MenuToggleButton.Size = UDim2.new(0, 40, 0, 40)
MenuToggleButton.Position = UDim2.new(1, -50, 0, 20)
MenuToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MenuToggleButton.Text = "🌚"
MenuToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuToggleButton.Font = Enum.Font.GothamBold
MenuToggleButton.TextSize = 18
Instance.new("UICorner", MenuToggleButton).CornerRadius = UDim.new(0, 8)

-- Click -> Đóng/mở menu
MenuToggleButton.MouseButton1Click:Connect(function()
	open = not open
	local goal = {Position = open and openPos or closedPos}
	TweenService:Create(MainFrame, tweenInfo, goal):Play()
end)

-- Kéo lên xuống nút
local draggingButton = false
local dragInputB, dragStartB, startPosB
MenuToggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingButton = true
		dragStartB = input.Position
		startPosB = MenuToggleButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingButton = false
			end
		end)
	end
end)

MenuToggleButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInputB = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInputB and draggingButton then
		local delta = input.Position - dragStartB
		local newY = startPosB.Y.Offset + delta.Y
		MenuToggleButton.Position = UDim2.new(1, -50, 0, math.clamp(newY, 0, workspace.CurrentCamera.ViewportSize.Y - 50))
	end
end)

-- Example Tab + Button
local MainTab = CreateTab("Main")
CreateButton(MainTab, "Dí!", function()
	print("Ngon Thí!")
end)
local FlyTab = CreateTab("Fly")

local flying = false
local bodyGyro, bodyVelocity
local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local function setFly(state)
	flying = state
	if flying then
		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.P = 9e4
		bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.cframe = humanoidRootPart.CFrame
		bodyGyro.Parent = humanoidRootPart

		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.velocity = Vector3.new(0, 0, 0)
		bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
		bodyVelocity.Parent = humanoidRootPart

		local connection = game:GetService("RunService").Heartbeat:Connect(function()
			if not flying then connection:Disconnect() return end

			local camera = workspace.CurrentCamera
			local moveDirection = Vector3.new()
			if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camera.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camera.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end

			bodyVelocity.Velocity = moveDirection.Unit * 50
			bodyGyro.CFrame = camera.CFrame
		end)
	else
		if bodyGyro then bodyGyro:Destroy() end
		if bodyVelocity then bodyVelocity:Destroy() end
	end
end

-- ✅ Thêm toggle Fly vào tab Fly
CreateToggle(FlyTab, "Fly", false, function(state)
	setFly(state)
end)
MainTab.Visible = true
