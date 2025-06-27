local AutoFarm = {}

local running = false

function AutoFarm.Start(enemyList)
    running = true
    warn("[AutoFarm] Đang bắt đầu auto farm...")

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer
    local Combat = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat")

    while running and task.wait(0.2) do
        local level = player:FindFirstChild("Data") and player.Data.Level.Value or 1
        local target = nil

        for i = #enemyList, 1, -1 do
            if level >= enemyList[i].Level then
                target = enemyList[i]
                break
            end
        end

        if target then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", target.Quest, 1)
            end)

            local mobs = workspace.Enemies:GetChildren()
            for _, mob in pairs(mobs) do
                if mob.Name == target.Mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    Combat:FireServer(mob)
                end
            end
        end
    end
end

function AutoFarm.Toggle(state, enemyList)
    if state then
        AutoFarm.Start(enemyList)
    else
        running = false
        warn("[AutoFarm] Đã dừng auto farm.")
    end
end

return AutoFarm
