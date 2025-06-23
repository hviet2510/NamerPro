local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Tạo Tool AK47 Rồng Xanh nếu chưa có
if not ReplicatedStorage:FindFirstChild("ak47") then
	local ak = Instance.new("Tool")
	ak.Name = "ak47"
	ak.RequiresHandle = true

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(2, 1, 6)
	handle.BrickColor = BrickColor.new("Bright blue")
	handle.Material = Enum.Material.Neon
	handle.Parent = ak

	local particle = Instance.new("ParticleEmitter", handle)
	particle.Texture = "rbxassetid://243660364"
	particle.Rate = 15
	particle.Lifetime = NumberRange.new(0.4, 0.8)
	particle.Speed = NumberRange.new(4, 6)
	particle.LightEmission = 1

	ak.Activated:Connect(function()
		local bullet = Instance.new("Part")
		bullet.Size = Vector3.new(0.2, 0.2, 2)
		bullet.BrickColor = BrickColor.new("Bright blue")
		bullet.Material = Enum.Material.Neon
		bullet.CFrame = handle.CFrame
		bullet.Velocity = handle.CFrame.LookVector * 300
		bullet.CanCollide = false
		bullet.Anchored = false
		bullet.Parent = workspace
		game:GetService("Debris"):AddItem(bullet, 5)
	end)

	ak.Parent = ReplicatedStorage
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "StackFlowUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -35, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "StackFlow Admin UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(0, 120, 1, -35)
TabsFrame.Position = UDim2.new(0, 0, 0, 35)
TabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", TabsFrame).CornerRadius = UDim.new(0, 8)

local TabLayout = Instance.new("UIListLayout", TabsFrame)
TabLayout.Padding = UDim.new(0, 5)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local PagesFrame = Instance.new("Frame", MainFrame)
PagesFrame.Size = UDim2.new(1, -130, 1, -40)
PagesFrame.Position = UDim2.new(0, 130, 0, 40)
PagesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", PagesFrame).CornerRadius = UDim.new(0, 8)

-- Tabs
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
	Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

	TabButton.MouseButton1Click:Connect(function()
		for _, v in pairs(PagesFrame:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		Page.Visible = true
	end)

	Tabs[name] = Page
	return Page
end

local function CreateInput(page, placeholder, callback)
	local Box = Instance.new("TextBox", page)
	Box.Size = UDim2.new(0, 240, 0, 30)
	Box.PlaceholderText = placeholder
	Box.Text = ""
	Box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Box.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box.Font = Enum.Font.Gotham
	Box.TextSize = 14
	Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

	Box.FocusLost:Connect(function(enter)
		if enter and Box.Text ~= "" then
			callback(Box.Text)
			Box.Text = ""
		end
	end)
end

-- Admin tab + lệnh
local AdminTab = CreateTab("Admin")
CreateInput(AdminTab, "Nhập lệnh (give ak47, kill me...)", function(cmd)
	local args = string.split(cmd:lower(), " ")
	local action = args[1]

	if action == "kill" then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.Health = 0
		end

	elseif action == "tp" then
		local target = args[2]
		for _, plr in pairs(Players:GetPlayers()) do
			if plr.Name:lower():sub(1, #target) == target then
				if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character:MoveTo(plr.Character.HumanoidRootPart.Position + Vector3.new(2,0,0))
				end
			end
		end

	elseif action == "give" then
		local toolName = args[2]
		local tool = ReplicatedStorage:FindFirstChild(toolName)
		if tool then
			tool:Clone().Parent = LocalPlayer.Backpack
		else
			warn("Không tìm thấy tool:", toolName)
		end
	end
end)
AdminTab.Visible = true

-- Toggle Menu Button
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

-- Toggle logic
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local open = true
local openPos = MainFrame.Position
local closedPos = UDim2.new(0.5, -250, -1, 0)

MenuToggleButton.MouseButton1Click:Connect(function()
	open = not open
	local goal = {Position = open and openPos or closedPos}
	TweenService:Create(MainFrame, tweenInfo, goal):Play()
end)

-- Kéo nút toggle
local dragging, dragInput, dragStart, startPos
MenuToggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MenuToggleButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
MenuToggleButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		local newY = startPos.Y.Offset + delta.Y
		MenuToggleButton.Position = UDim2.new(1, -50, 0, math.clamp(newY, 0, workspace.CurrentCamera.ViewportSize.Y - 50))
	end
end)
