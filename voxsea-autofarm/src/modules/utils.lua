-- utils.lua
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Utils = {}

----------------------------------------------------------------
-- 1. Lấy mob phù hợp theo level
----------------------------------------------------------------
function Utils:GetTargetMob()
    local level = self:GetPlayerLevel()
    local bestMob = nil
    local bestDist = math.huge

    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
            if mob.Humanoid.Health > 0 then
                local mobName = mob.Name
                -- Check nếu có level trong tên
                local mobLevel = tonumber(string.match(mobName, "%d+"))
                
                if mobLevel then
                    -- Nếu mob có level thì so gần level player
                    if math.abs(mobLevel - level) <= 5 then
                        local dist = (mob.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < bestDist then
                            bestMob = mob
                            bestDist = dist
                        end
                    end
                else
                    -- Nếu mob không có level thì vẫn lấy (ưu tiên gần)
                    local dist = (mob.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < bestDist then
                        bestMob = mob
                        bestDist = dist
                    end
                end
            end
        end
    end

    return bestMob
end

----------------------------------------------------------------
-- 2. Lấy level player
----------------------------------------------------------------
function Utils:GetPlayerLevel()
    -- Chỉnh lại tùy game (VD: tên gui chứa level)
    local stats = Player:FindFirstChild("Data")
    if stats and stats:FindFirstChild("Level") then
        return stats.Level.Value
    end
    return 1
end

----------------------------------------------------------------
-- 3. Tween tới vị trí
----------------------------------------------------------------
function Utils:MoveTo(position, speed)
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local dist = (position - root.Position).Magnitude
    local time = dist / (speed or 60)

    local tween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position)})
    tween:Play()
    return tween
end

----------------------------------------------------------------
-- 4. Bay lên đầu mob
----------------------------------------------------------------
function Utils:FlyAboveMob(mob, height, speed)
    if mob and mob:FindFirstChild("HumanoidRootPart") then
        local pos = mob.HumanoidRootPart.Position + Vector3.new(0, height or 8, 0)
        self:MoveTo(pos, speed or 60)
    end
end

return Utils
