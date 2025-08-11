-- ==================== MAIN LOADER (GitHub) ====================

-- Cấu hình repo GitHub
local Repo = "https://raw.githubusercontent.com/<username>/<repo>/main/"

-- Hàm tải module từ GitHub
local function LoadModule(path)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(Repo .. path))()
    end)
    if not success then
        warn("Lỗi tải module:", path, result)
        return nil
    end
    return result
end

-- ==================== TẢI UI ORION ====================
local OrionLib = LoadModule("ui/Orion.lua")

-- ==================== TẢI CÁC MODULE CHÍNH ====================
local EnemySelector = LoadModule("modules/enemy_selector.lua")
local Utils         = LoadModule("modules/utils.lua")
local Movement      = LoadModule("modules/movement.lua")
local QuestHandler  = LoadModule("modules/quest_handler.lua")
local Combat        = LoadModule("modules/combat.lua")

-- ==================== TRẠNG THÁI ====================
local AutofarmEnabled = false

-- ==================== CÀI UI ====================
local Window = OrionLib:MakeWindow({Name = "VoxSea Autofarm", HidePremium = false, SaveConfig = true, ConfigFolder = "VoxSeaAF"})

local TabFarm = Window:MakeTab({Name = "Autofarm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

TabFarm:AddToggle({
    Name = "Bật/Tắt Autofarm",
    Default = false,
    Callback = function(state)
        AutofarmEnabled = state
        if state then
            Utils.Notify("Bắt đầu Autofarm", "green")
            task.spawn(function()
                while AutofarmEnabled and task.wait() do
                    local target = EnemySelector.GetBestEnemy(game.Players.LocalPlayer)
                    if not target then
                        Utils.Notify("Không tìm thấy quái phù hợp", "yellow")
                        continue
                    end

                    QuestHandler.EnsureQuest(target)
                    Movement.ToEnemy(target)
                    Combat.Attack(target)
                end
            end)
        else
            Utils.Notify("Tắt Autofarm", "red")
        end
    end
})

OrionLib:Init()
