-- Module: enemy_selector.lua
-- Chọn quái phù hợp nhất theo level người chơi
-- Tối ưu cho mobile (ít vòng lặp, cache kết quả)

local EnemySelector = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- ====== CONFIG MAPPING LEVEL → QUÁI ======
-- Có thể chỉnh trong config.lua rồi require vào
local EnemyList = {
    {Level = 1, Name = "Bandit"},
    {Level = 10, Name = "Monkey"},
    {Level = 20, Name = "Gorilla"},
    {Level = 30, Name = "Pirate"},
    {Level = 50, Name = "Brute"},
    {Level = 80, Name = "Desert Bandit"},
    {Level = 100, Name = "Desert Officer"},
}

-- Cache quái đang target để tránh quét lại nhiều lần
local cachedTarget = nil
local lastCheck = 0
local CHECK_INTERVAL = 1 -- giây

-- ====== HÀM TÌM QUÁI PHÙ HỢP ======
function EnemySelector:GetTarget()
    local now = tick()
    if cachedTarget and cachedTarget.Parent and (now - lastCheck) < CHECK_INTERVAL then
        return cachedTarget
    end

    lastCheck = now

    -- Lấy level người chơi
    local playerLevel = 1
    local stats = LocalPlayer:FindFirstChild("Data")
    if stats and stats:FindFirstChild("Level") then
        playerLevel = stats.Level.Value
    end

    -- Xác định quái phù hợp nhất theo level
    local targetName = nil
    for i = #EnemyList, 1, -1 do
        if playerLevel >= EnemyList[i].Level then
            targetName = EnemyList[i].Name
            break
        end
    end

    if not targetName then return nil end

    -- Tìm quái gần nhất trong Workspace
    local closest, closestDist = nil, math.huge
    for _, mob in ipairs(Workspace.Enemies:GetChildren()) do
        if mob.Name == targetName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local dist = (mob.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = mob
            end
        end
    end

    cachedTarget = closest
    return cachedTarget
end

return EnemySelector
