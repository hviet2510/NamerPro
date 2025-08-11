-- enemy_selector.lua
-- Chọn mob phù hợp trong workspace theo level người chơi

local EnemySelector = {}

-- Hàm lấy level người chơi
local function GetPlayerLevel()
    local player = game.Players.LocalPlayer
    -- Ví dụ: level lưu ở Stats.Level.Value
    local stats = player:FindFirstChild("Stats")
    if stats and stats:FindFirstChild("Level") then
        return stats.Level.Value
    end
    return 1
end

-- Hàm chọn mob gần nhất & phù hợp
function EnemySelector:GetTargetMob()
    local playerLevel = GetPlayerLevel()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local bestMob = nil
    local shortestDistance = math.huge

    for _, mob in pairs(workspace:GetDescendants()) do
        if mob:FindFirstChild("Humanoid") 
           and mob:FindFirstChild("HumanoidRootPart") 
           and mob.Humanoid.Health > 0 then

            -- Lọc level mob theo tên (VD: "Bandit [Lv. 5]")
            local mobLevel = tonumber(string.match(mob.Name, "%[Lv%. (%d+)%]")) or 1

            -- Chỉ chọn mob có level gần level người chơi ±5
            if math.abs(mobLevel - playerLevel) <= 5 then
                local dist = (mob.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    bestMob = mob
                end
            end
        end
    end

    return bestMob
end

return EnemySelector
