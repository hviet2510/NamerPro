-- NamerPro - Full Hub Auto Farm Blox Fruits 3rd Sea - UI Redz Style
-- Repo: https://github.com/hviet2510/NamerPro

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- UI Library (Redz-like, simple custom)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "NamerPro_UI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "NamerPro Hub - Blox Fruits"
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

local Tabs = {}
local SelectedTab = nil

local function CreateTab(name)
    local Button = Instance.new("TextButton", MainFrame)
    Button.Size = UDim2.new(0, 120, 0, 35)
    Button.Position = UDim2.new(0, 10 + (#Tabs * 130), 0, 60)
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamMedium
    Button.TextScaled = true
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    local Content = Instance.new("Frame", MainFrame)
    Content.Size = UDim2.new(1, -20, 1, -110)
    Content.Position = UDim2.new(0, 10, 0, 100)
    Content.BackgroundTransparency = 1
    Content.Visible = false

    Tabs[#Tabs+1] = {Button = Button, Content = Content}

    Button.MouseButton1Click:Connect(function()
        for _, tab in ipairs(Tabs) do
            tab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            tab.Content.Visible = false
        end
        Button.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
        Content.Visible = true
        SelectedTab = {Button = Button, Content = Content}
    end)

    if not SelectedTab then
        Button.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
        Content.Visible = true
        SelectedTab = {Button = Button, Content = Content}
    end

    return Content
end

-- Tabs
local AutoFarmTab = CreateTab("Auto Farm")
local TeleportTab = CreateTab("Teleport")
local MiscTab = CreateTab("Misc")
local SettingsTab = CreateTab("Settings")

-- Enemy List
local EnemyList = {
    "Pirate Recruit", "Elite Pirate", "God's Guard", "Shanda",
    "Royal Squad", "Royal Soldier", "Jungle Pirate", "Musketeer Pirate",
    "Forest Pirate", "Mythological Pirate", "Captain Elephant", "Beautiful Pirate",
    "Doe King", "Cursed Captain", "Living Zombie", "Posessed Mummy",
    "Peanut Scout", "Peanut President", "Ice Cream Chef", "Ice Cream Commander",
    "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker", "Cocoa Warrior",
    "Cocoa Master", "Candy Rebel", "Candy Pirate", "Sweet Thief", "Sweet Commander"
}

local function EquipMelee()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and not tool:FindFirstChild("GunScripts_Local") then
            LocalPlayer.Character.Humanoid:EquipTool(tool)
            break
        end
    end
end

local function TweenTo(pos)
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if HRP then
        local tween = TweenService:Create(HRP, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

local function FindNearestEnemy()
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end

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

-- Auto Farm Button
local AutoFarmBtn = Instance.new("TextButton", AutoFarmTab)
AutoFarmBtn.Size = UDim2.new(0, 200, 0, 40)
AutoFarmBtn.Position = UDim2.new(0, 10, 0, 10)
AutoFarmBtn.Text = "Bật Auto Farm"
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.Font = Enum.Font.GothamBold
AutoFarmBtn.TextScaled = true
Instance.new("UICorner", AutoFarmBtn).CornerRadius = UDim.new(0, 8)

local isFarming = false
AutoFarmBtn.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    AutoFarmBtn.Text = isFarming and "Tắt Auto Farm" or "Bật Auto Farm"
    AutoFarmBtn.BackgroundColor3 = isFarming and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(40, 100, 180)
end)

-- Farming Logic
spawn(function()
    while task.wait(0.3) do
        if isFarming and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local mob = FindNearestEnemy()
            if mob then
                TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
                EquipMelee()
                while mob and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and isFarming do
                    pcall(function()
                        LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end)
                    task.wait()
                end
            end
        end
    end
end)

-- Teleport Example
local TPIsland = Instance.new("TextButton", TeleportTab)
TPIsland.Size = UDim2.new(0, 200, 0, 40)
TPIsland.Position = UDim2.new(0, 10, 0, 10)
TPIsland.Text = "Teleport đến đảo 1"
TPIsland.BackgroundColor3 = Color3.fromRGB(40, 120, 180)
TPIsland.TextColor3 = Color3.fromRGB(255, 255, 255)
TPIsland.Font = Enum.Font.GothamBold
TPIsland.TextScaled = true
Instance.new("UICorner", TPIsland).CornerRadius = UDim.new(0, 8)

TPIsland.MouseButton1Click:Connect(function()
    TweenTo(Vector3.new(50, 30, 200))
end)

-- Credits Tab
local CreditsTab = CreateTab("Credits")
local CreditsText = Instance.new("TextLabel", CreditsTab)
CreditsText.Size = UDim2.new(1, -20, 1, -20)
CreditsText.Position = UDim2.new(0, 10, 0, 10)
CreditsText.BackgroundTransparency = 1
CreditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsText.Font = Enum.Font.GothamMedium
CreditsText.TextScaled = true
CreditsText.TextWrapped = true
CreditsText.Text = "Made by hviet2510\nGitHub: github.com/hviet2510\nNamerPro Hub"

-- Ready
MainFrame.Visible = true
