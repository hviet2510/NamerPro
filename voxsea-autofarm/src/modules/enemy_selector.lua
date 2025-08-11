-- File: enemy_selector.lua
-- Nhiệm vụ: Chọn quái phù hợp nhất để farm dựa trên level người chơi

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local EnemySelector = {}
local Player = Players.LocalPlayer

-- ⚙️ Cấu hình
local ENEMY_FOLDER_NAMES = {"Enemies", "Mobs", "NPCs"} -- Thư mục chứa quái
local LEVEL_TOLERANCE = 3 -- Chênh lệch level tối đa giữa player và quái

-- 🔍 Lấy level từ tên quái (VD: "Bandit [Lv. 5]")
function EnemySelector.GetEnemyLevel(enemy)
    if not enemy or not enemy.Name then return nil end
    local level = string.match(enemy.Name, "%[Lv%.%s*(%d+)%]")
    return tonumber(level)
end

-- 📍 Lấy level của người chơi
local function GetPlayerLevel()
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats and leaderstats:FindFirstChild("Level") then
        return leaderstats.Level.Value
    end
    return 1
end

-- 🗂 Lấy toàn bộ quái trong workspace
local function GetAllEnemies()
    local enemies = {}
    for _, folderName in ipairs(ENEMY_FOLDER_NAMES) do
        local folder = Workspace:FindFirstChild(folderName)
        if folder then
            for _, enemy in ipairs(folder:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                    table.insert(enemies, enemy)
                end
            end
        end
    end
    return enemies
end

-- 🧠 Chọn quái tốt nhất
function EnemySelector.GetBestEnemy()
    local playerLevel = GetPlayerLevel()
    local enemies = GetAllEnemies()

    local bestEnemy = nil
    local closestDistance = math.huge
    local playerPos = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.HumanoidRootPart.Position

    for _, enemy in ipairs(enemies) do
        local level = EnemySelector.GetEnemyLevel(enemy)

        -- Chỉ chọn quái có level hợp lý hoặc không có level nhưng tên phù hợp
        if level and math.abs(level - playerLevel) <= LEVEL_TOLERANCE then
            local dist = (enemy.HumanoidRootPart.Position - playerPos).Magnitude
            if dist < closestDistance then
                closestDistance = dist
                bestEnemy = enemy
            end
        end
    end

    return bestEnemy
end

return EnemySelector
