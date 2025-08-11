-- File: modules/enemy_selector.lua
-- Chọn mob thông minh theo level trong Vox Sea

local EnemySelector = {}

-- Cấu hình
local LEVEL_TOLERANCE = 5 -- ±5 level
local SCAN_INTERVAL = 3   -- quét mới sau mỗi 3 giây

-- Biến cache
local mobCache = {}
local lastScan = 0

-- Lấy level của mob
local function getMobLevel(mob)
    if mob:FindFirstChild("Level") and tonumber(mob.Level.Value) then
        return tonumber(mob.Level.Value)
    end
    return nil
end

-- Kiểm tra mob hợp lệ
local function isValidMob(mob, playerLevel)
    local mobLevel = getMobLevel(mob)
    if not mobLevel then return false end
    if math.abs(mobLevel - playerLevel) > LEVEL_TOLERANCE then return false end

    -- Loại boss / NPC không farm
    if mob:FindFirstChild("BossTag") or mob:FindFirstChild("NPC") then return false end

    -- Phải có Humanoid còn sống
    if not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 then return false end

    -- Phải có PrimaryPart
    if not mob.PrimaryPart then return false end

    return true
end

-- Tính điểm ưu tiên (thấp hơn = tốt hơn)
local function getPriorityScore(mob, playerPos, playerLevel)
    local mobLevel = getMobLevel(mob)
    local distance = (mob.PrimaryPart.Position - playerPos).Magnitude
    local healthFactor = mob.Humanoid.Health
    return distance + math.abs(playerLevel - mobLevel) * 3 + (healthFactor / 100)
end

-- Lấy mob tốt nhất
function EnemySelector.GetBestMob(player)
    if tick() - lastScan > SCAN_INTERVAL then
        mobCache = {}
        local enemiesFolder = workspace:FindFirstChild("Enemies")
        if enemiesFolder then
            for _, mob in pairs(enemiesFolder:GetChildren()) do
                if isValidMob(mob, player.Level.Value) then
                    table.insert(mobCache, mob)
                end
            end
        end
        lastScan = tick()
    end

    local bestMob, bestScore
    for _, mob in pairs(mobCache) do
        local score = getPriorityScore(mob, player.Character.HumanoidRootPart.Position, player.Level.Value)
        if not bestScore or score < bestScore then
            bestScore = score
            bestMob = mob
        end
    end

    return bestMob
end

return EnemySelector
