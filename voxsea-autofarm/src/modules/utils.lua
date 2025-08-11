-- File: utils.lua
-- Nhiệm vụ: Lấy dữ liệu quái từ enemy_selector và kiểm tra trạng thái

local EnemySelector = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").enemy_selector)

local Utils = {}

-- 📦 Lấy thông tin quái hiện tại
function Utils.GetCurrentEnemy()
    local enemy = EnemySelector.GetBestEnemy()
    if enemy and enemy:FindFirstChild("HumanoidRootPart") then
        return {
            Instance = enemy,
            Position = enemy.HumanoidRootPart.Position,
            Level = EnemySelector.GetEnemyLevel(enemy)
        }
    end
    return nil
end

-- ❤️ Kiểm tra quái còn sống
function Utils.IsEnemyAlive(enemyData)
    if not enemyData or not enemyData.Instance then return false end
    local humanoid = enemyData.Instance:FindFirstChild("Humanoid")
    return enemyData.Instance.Parent ~= nil and humanoid and humanoid.Health > 0
end

return Utils
