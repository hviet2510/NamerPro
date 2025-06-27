local AutoFarm = {}
local running = false

function AutoFarm.Start(EnemyList)
    running = true
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer
    local HRP = player.Character:WaitForChild("HumanoidRootPart")
    local Combat = ReplicatedStorage.Remotes.Combat

    local function GetEnemy()
        for i = #EnemyList, 1, -1 do
            if player.Data.Level.Value >= EnemyList[i].Level then
                return EnemyList[i]
            end
        end
    end

    local function WaitForMob(name)
        while running do
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
            task.wait(0.2)
        end
    end

    while running do
        local enemy = GetEnemy()
        if enemy then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", enemy.Quest, 1)
            HRP.CFrame = enemy.CFrame + Vector3.new(0, 25, 0)

            local mob = WaitForMob(enemy.Mob)
            if mob then
                mob.HumanoidRootPart.Anchored = true
                mob.HumanoidRootPart.CFrame = HRP.CFrame * CFrame.new(0, -4, -5)

                while mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and running do
                    Combat:FireServer(mob)
                    task.wait(0.1)
                end

                mob.HumanoidRootPart.Anchored = false
            end
        end
        task.wait(0.2)
    end
end

function AutoFarm.Toggle(state)
    running = state
    if state then
        print("[AutoFarm] BẬT")
    else
        print("[AutoFarm] TẮT")
    end
end

return AutoFarm
