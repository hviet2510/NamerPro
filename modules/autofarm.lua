local AutoFarm = {}
local isFarming = false
local attackRange = 10
local farmMode = "Bình Thường"
local selectedTool = nil

function AutoFarm.SetRange(range)
    attackRange = range
end

function AutoFarm.SetMode(mode)
    farmMode = mode
end

function AutoFarm.SetTool(toolName)
    selectedTool = toolName
end

function AutoFarm.Toggle(state, enemyList)
    isFarming = state
    if isFarming then
        AutoFarm.Start(enemyList)
    end
end

function AutoFarm.EquipTool()
    local player = game.Players.LocalPlayer
    if selectedTool and player.Backpack:FindFirstChild(selectedTool) then
        player.Character.Humanoid:EquipTool(player.Backpack:FindFirstChild(selectedTool))
    end
end

function AutoFarm.Start(enemyList)
    task.spawn(function()
        while isFarming do
            local target = AutoFarm.GetEnemyByLevel(enemyList)
            if target then
                AutoFarm.EquipTool()
                AutoFarm.MoveToTarget(target)
                AutoFarm.AttackTarget(target)
            else
                warn("[AutoFarm] Không tìm thấy quái phù hợp!")
            end
            task.wait(0.5) -- delay giữa mỗi vòng farm
        end
    end)
end

function AutoFarm.GetEnemyByLevel(enemyList)
    local playerLevel = game.Players.LocalPlayer.Data.Level.Value
    for _, enemy in ipairs(enemyList) do
        if playerLevel >= enemy.MinLevel and playerLevel <= enemy.MaxLevel then
            local mob = workspace:FindFirstChild(enemy.Name)
            if mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                return mob
            end
        end
    end
    return nil
end

function AutoFarm.MoveToTarget(target)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and target:FindFirstChild("HumanoidRootPart") then
        local distance = (hrp.Position - target.HumanoidRootPart.Position).Magnitude
        if distance > attackRange then
            local tweenService = game:GetService("TweenService")
            local tween = tweenService:Create(hrp, TweenInfo.new(distance / 50, Enum.EasingStyle.Linear), {CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, -attackRange)})
            tween:Play()
            tween.Completed:Wait()
        end
    end
end

function AutoFarm.AttackTarget(target)
    while isFarming and target and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0 do
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        else
            warn("[AutoFarm] Chưa trang bị tool!")
        end
        task.wait(0.3)
    end
end

return AutoFarm
