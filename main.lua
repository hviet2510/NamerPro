local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Main UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "RedzBF_UI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 420, 0, 260)
Frame.Position = UDim2.new(0.5, -210, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "Redz Hub | Auto Farm"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0, 380, 0, 40)
Toggle.Position = UDim2.new(0, 20, 0, 60)
Toggle.Text = "Bật Auto Farm"
Toggle.BackgroundColor3 = Color3.fromRGB(35, 90, 160)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 16
local ToggleCorner = Instance.new("UICorner", Toggle)
ToggleCorner.CornerRadius = UDim.new(0, 6)

local Dropdown = Instance.new("TextBox", Frame)
Dropdown.PlaceholderText = "Nhập tên quái cần farm"
Dropdown.Size = UDim2.new(0, 380, 0, 35)
Dropdown.Position = UDim2.new(0, 20, 0, 110)
Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
Dropdown.Font = Enum.Font.Gotham
Dropdown.TextSize = 15
local DropdownCorner = Instance.new("UICorner", Dropdown)
DropdownCorner.CornerRadius = UDim.new(0, 6)

local Info = Instance.new("TextLabel", Frame)
Info.Text = "Nhập đúng tên Enemy để farm chính xác"
Info.Size = UDim2.new(1, -20, 0, 30)
Info.Position = UDim2.new(0, 10, 1, -35)
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.fromRGB(180, 180, 180)
Info.Font = Enum.Font.Gotham
Info.TextSize = 13
Info.TextXAlignment = Enum.TextXAlignment.Left

-- Functions
local function GetCharacter()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart")
end

local function TweenTo(pos)
    local _, hrp = GetCharacter()
    local tween = TweenService:Create(hrp, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

local function EquipTool()
    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        LocalPlayer.Character.Humanoid:EquipTool(tool)
        return tool
    end
end

local function FindNearestEnemy(enemyName)
    local _, hrp = GetCharacter()
    local nearest, dist = nil, math.huge
    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
        if mob.Name == enemyName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
            local d = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude
            if d < dist then
                nearest = mob
                dist = d
            end
        end
    end
    return nearest
end

local function AttackEnemy(mob)
    local _, hrp = GetCharacter()
    while mob and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
        pcall(function()
            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            local tool = EquipTool()
            if tool then tool:Activate() end
        end)
        task.wait()
    end
end

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Main Loop
local isFarming = false
Toggle.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    Toggle.Text = isFarming and "Tắt Auto Farm" or "Bật Auto Farm"
    Toggle.BackgroundColor3 = isFarming and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(35, 90, 160)
end)

task.spawn(function()
    while task.wait(0.5) do
        if isFarming then
            local mobName = Dropdown.Text
            if mobName ~= "" then
                local mob = FindNearestEnemy(mobName)
                if mob then
                    TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
                    AttackEnemy(mob)
                end
            end
        end
    end
end)

Frame.Visible = true
