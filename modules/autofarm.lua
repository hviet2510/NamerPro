local AutoFarm = {}
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local Character = function() return Player.Character or Player.CharacterAdded:Wait() end
local AttackDelay = 1
local MoveSpeed = 100
local AttackDistance = 6
local FarmMode = "Bình Thường"
local IsFarming = false
local CurrentTween
local QuestNPC = nil

local function moveTo(targetPos)
    if CurrentTween then
        CurrentTween:Cancel()
    end
    local root = Character():WaitForChild("HumanoidRootPart")
    local tweenInfo = TweenInfo.new((root.Position - targetPos).Magnitude / MoveSpeed, Enum.EasingStyle.Linear)
    CurrentTween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos)})
    CurrentTween:Play()
    CurrentTween.Completed:Wait()
end

local function findTarget(enemyList)
    for _, name in pairs(enemyList) do
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob.Name == name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                return mob
            end
        end
    end
    return nil
end

local function findQuestNPC()
    if not QuestNPC then return nil end
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc.Name == QuestNPC and npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            return npc
        end
    end
    return nil
end

local function takeQuest()
    local npc = findQuestNPC()
    if npc then
        moveTo(npc.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        fireclickdetector(npc:FindFirstChildOfClass("ClickDetector"))
        task.wait(1)
    else
        warn("[NamerPro] ❌ Không tìm thấy NPC nhận quest!")
    end
end

function AutoFarm.SetFarmMode(mode)
    FarmMode = mode
    if mode == "Bình Thường" then
        AttackDelay = 0.7
        MoveSpeed = 100
    elseif mode == "Nhanh" then
        AttackDelay = 0.4
        MoveSpeed = 150
    elseif mode == "An Toàn" then
        AttackDelay = 1
        MoveSpeed = 70
    end
end

function AutoFarm.SetAttackDistance(distance)
    AttackDistance = distance
end

function AutoFarm.SetQuestNPC(name)
    QuestNPC = name
    print("[NamerPro] Đã đặt NPC nhận quest: " .. tostring(name))
end

function AutoFarm.Start(enemyList)
    if IsFarming then return end
    IsFarming = true
    spawn(function()
        while IsFarming do
            takeQuest()
            local target = findTarget(enemyList)
            if target then
                local pos = target.HumanoidRootPart.Position + Vector3.new(0, 0, AttackDistance)
                moveTo(pos + Vector3.new(0, 5, 0))
                pcall(function()
                    repeat
                        if not target or not target:FindFirstChild("Humanoid") or target.Humanoid.Health <= 0 then break end
                        local tool = Character():FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                        task.wait(AttackDelay)
                    until target.Humanoid.Health <= 0 or not IsFarming
                end)
            else
                task.wait(0.5)
            end
        end
    end)
end

function AutoFarm.Toggle(state)
    IsFarming = state
    if not state and CurrentTween then
        CurrentTween:Cancel()
    end
end

function AutoFarm.SetDelay(delay)
    AttackDelay = delay
end

return AutoFarm
