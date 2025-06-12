local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local Speed = 8
local Height = 15
local AttackDistance = 20

local function TweenTo(position)
    local info = TweenInfo.new(Speed, Enum.EasingStyle.Linear)
    local goal = {CFrame = CFrame.new(position + Vector3.new(0, Height, 0))}
    local tween = TweenService:Create(HumanoidRootPart, info, goal)
    tween:Play()
    tween.Completed:Wait()
end

local function EquipMelee()
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and not string.find(tool.Name, "Gun") then
            tool.Parent = LocalPlayer.Character
            return tool
        end
    end
end

local LevelQuests = {
    [1] = {Level = 1, Quest = "BanditQuest1", Enemy = "Bandit", Pos = Vector3.new(1060, 16, 1547)},
    [2] = {Level = 15, Quest = "BanditQuest2", Enemy = "Monkey", Pos = Vector3.new(-1602, 36, 145)},
    [3] = {Level = 30, Quest = "JungleQuest", Enemy = "Gorilla", Pos = Vector3.new(-1334, 39, -499)},
    [4] = {Level = 60, Quest = "BuggyQuest1", Enemy = "Pirate", Pos = Vector3.new(-1164, 14, 3848)},
    [5] = {Level = 75, Quest = "BuggyQuest2", Enemy = "Brute", Pos = Vector3.new(-1210, 14, 4343)},
    [6] = {Level = 120, Quest = "DesertQuest", Enemy = "Desert Bandit", Pos = Vector3.new(933, 7, 4484)},
    [7] = {Level = 150, Quest = "DesertQuest2", Enemy = "Desert Officer", Pos = Vector3.new(1572, 10, 4373)},
    [8] = {Level = 190, Quest = "SnowQuest", Enemy = "Snow Bandit", Pos = Vector3.new(1389, 87, -1297)},
    [9] = {Level = 220, Quest = "SnowQuest2", Enemy = "Snowman", Pos = Vector3.new(1395, 87, -1050)},
    [10] = {Level = 250, Quest = "MarineQuest", Enemy = "Trainee", Pos = Vector3.new(-2490, 72, -3210)},
    [11] = {Level = 300, Quest = "MarineQuest2", Enemy = "Fisherman", Pos = Vector3.new(-2723, 71, -3206)},
    [12] = {Level = 375, Quest = "SkyQuest", Enemy = "Sky Bandit", Pos = Vector3.new(-4968, 278, -2874)},
    [13] = {Level = 450, Quest = "SkyQuest2", Enemy = "Dark Master", Pos = Vector3.new(-5250, 389, -2297)},
    [14] = {Level = 525, Quest = "ColosseumQuest", Enemy = "Toga Warrior", Pos = Vector3.new(-1576, 7, -2982)},
    [15] = {Level = 625, Quest = "ColosseumQuest2", Enemy = "Gladiator", Pos = Vector3.new(-1265, 7, -3398)},
    [16] = {Level = 700, Quest = "MagmaQuest", Enemy = "Military Soldier", Pos = Vector3.new(-5315, 13, 8464)}
}

local function GetQuestForLevel(lv)
    local quest = nil
    for _, data in ipairs(LevelQuests) do
        if lv >= data.Level then
            quest = data
        else
            break
        end
    end
    return quest
end

local function StartQuest(questName)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questName, 1)
end

local function FindEnemy(enemyName)
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy.Name == enemyName and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            return enemy
        end
    end
end

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "SpeedXFarm"

local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 140, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 10)
Toggle.Text = "AutoFarm: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(35, 90, 160)
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextScaled = true

local isFarming = false

Toggle.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    Toggle.Text = isFarming and "AutoFarm: ON" or "AutoFarm: OFF"
    Toggle.BackgroundColor3 = isFarming and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(35, 90, 160)
end)

task.spawn(function()
    while task.wait(1) do
        if isFarming then
            local lv = LocalPlayer.Data.Level.Value
            local questData = GetQuestForLevel(lv)
            if questData then
                StartQuest(questData.Quest)
                local enemy = FindEnemy(questData.Enemy)
                if enemy then
                    TweenTo(enemy.HumanoidRootPart.Position)
                    EquipMelee()
                    while enemy and enemy.Parent and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and isFarming do
                        HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, Height, -AttackDistance)
                        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            pcall(function()
                                tool:Activate()
                            end)
                        end
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end)
