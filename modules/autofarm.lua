local AutoFarm = {}

local running = false
local delay = 0.5 -- delay tấn công (s), bạn có thể cho chỉnh trong config

function AutoFarm.Start(enemyList)
    if running then
        warn("[AutoFarm] Đang chạy rồi!")
        return
    end

    running = true
    warn("[AutoFarm] Bắt đầu auto farm!")

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer
    local Combat = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat")

    task.spawn(function()
        while running do
            local level = (player:FindFirstChild("Data") and player.Data.Level.Value) or 1
            local target = nil

            -- Tìm mục tiêu theo level
            for i = #enemyList, 1, -1 do
                if level >= (enemyList[i].Level or 1) then
                    target = enemyList[i]
                    break
                end
            end

            if target then
                -- Bắt đầu quest
                pcall(function()
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", target.Quest, 1)
                end)

                -- Tìm và đánh quái
                local mobs = workspace:WaitForChild("Enemies"):GetChildren()
                for _, mob in ipairs(mobs) do
                    if mob.Name == target.Mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        Combat:FireServer(mob)
                        break -- chỉ đánh 1 lần mỗi vòng lặp
                    end
                end
            else
                warn("[AutoFarm] Không tìm thấy mục tiêu phù hợp với level: " .. level)
            end

            task.wait(delay)
        end
    end)
end

function AutoFarm.Toggle(state, enemyList)
    if state then
        AutoFarm.Start(enemyList)
    else
        running = false
        warn("[AutoFarm] Đã dừng auto farm.")
    end
end

function AutoFarm.SetDelay(sec)
    delay = tonumber(sec) or 1
    print("[AutoFarm] Đã set delay tấn công: " .. delay .. "s")
end

return AutoFarm
