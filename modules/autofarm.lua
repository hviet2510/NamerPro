local AutoFarm = {}
local enabled = false
local attackDelay = 0.7
local farmDistance = 50
local farmMode = "Bình Thường"

local TweenService = game:GetService("TweenService")

function AutoFarm.SetDelay(delay)
    attackDelay = delay
end

function AutoFarm.SetDistance(distance)
    farmDistance = distance
end

function AutoFarm.SetMode(mode)
    farmMode = mode
end

function AutoFarm.GetEnemyByLevel(enemyList, level)
    for _, enemy in pairs(enemyList) do
        if level >= enemy.MinLevel and level <= enemy.MaxLevel then
            return enemy
        end
    end
    return nil
end

local function moveToPosition(pos)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - pos).Magnitude / 100), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

function AutoFarm.Start(enemyList)
    enabled = true
    task.spawn(function()
        while enabled do
            local player = game.Players.LocalPlayer
            if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                warn("[AutoFarm] Không tìm thấy nhân vật!")
                task.wait(1)
                continue
            end
            local level = player.Data.Level.Value
            local enemy = AutoFarm.GetEnemyByLevel(enemyList, level)
            if enemy then
                -- Di chuyển nhận quest
                if enemy.QuestPos then
                    moveToPosition(enemy.QuestPos + Vector3.new(0, 5, 0))
                    print("[AutoFarm] Đã nhận quest: " .. enemy.QuestName)
                    task.wait(0.5)
                end

                -- Tìm quái
                local mobs = workspace.Enemies:GetChildren()
                local found = false
                for _, mob in pairs(mobs) do
                    if mob.Name == enemy.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        found = true
                        -- Di chuyển đến quái
                        local pos = mob.HumanoidRootPart.Position + (player.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Unit * farmDistance
                        moveToPosition(pos)
                        -- Tấn công
                        while mob.Humanoid.Health > 0 and enabled do
                            print("[AutoFarm] Đang đánh: " .. mob.Name)
                            -- Ở đây bạn có thể gọi skill Z/X/C nếu muốn
                            task.wait(attackDelay)
                        end
                        break
                    end
                end
                if not found then
                    print("[AutoFarm] Không tìm thấy quái gần, đợi spawn...")
                    task.wait(1)
                end
            else
                warn("[AutoFarm] Không tìm thấy enemy cho level: " .. level)
                task.wait(2)
            end
            task.wait(0.1)
        end
    end)
end

function AutoFarm.Toggle(state, enemyList)
    if state then
        AutoFarm.Start(enemyList)
        print("[AutoFarm] AutoFarm BẬT")
    else
        enabled = false
        print("[AutoFarm] AutoFarm TẮT")
    end
end

return AutoFarm
