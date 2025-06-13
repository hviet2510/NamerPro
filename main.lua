-- NamerPro Hub - Full Version with UI Redz Style

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local function EquipMelee()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and not tool:FindFirstChild("GunScripts_Local") then
            LocalPlayer.Character.Humanoid:EquipTool(tool)
            break
        end
    end
end

local function TweenTo(pos)
    local HRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local tween = TweenService:Create(HRP, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

local EnemyList = {"Pirate Recruit", "Elite Pirate", "God's Guard", "Shanda"}

local function FindNearestEnemy()
    local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local nearest, dist = nil, math.huge
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if table.find(EnemyList, mob.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local d = (mob.HumanoidRootPart.Position - HRP.Position).Magnitude
            if d < dist then
                nearest = mob
                dist = d
            end
        end
    end
    return nearest
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "NamerProUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 420, 0, 300)
Frame.Position = UDim2.new(0.5, -210, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "NamerPro Hub - Auto Farm 3rd Sea"
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamSemibold
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0, 180, 0, 45)
Toggle.Position = UDim2.new(0, 20, 0, 60)
Toggle.Text = "Bật Auto Farm"
Toggle.BackgroundColor3 = Color3.fromRGB(35, 90, 160)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextScaled = true
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)

local isFarming = false

Toggle.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    Toggle.Text = isFarming and "Tắt Auto Farm" or "Bật Auto Farm"
    Toggle.BackgroundColor3 = isFarming and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(35, 90, 160)
end)

-- Farming Logic
spawn(function()
    while task.wait(0.5) do
        if isFarming and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local mob = FindNearestEnemy()
            if mob then
                TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
                EquipMelee()
                while mob and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and isFarming do
                    pcall(function()
                        LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                    end)
                    task.wait()
                end
            end
        end
    end
end)

Frame.Visible = true
