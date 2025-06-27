-- Load DrRay UI lib và các modules
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local Tabs = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua"))()
local Buttons = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = Tabs.Create(window, "Farm Level", "ImageIdFarm")

Buttons.Create(farmTab, "Start Farm", function()
    if AutoFarm and AutoFarm.Start then
        AutoFarm.Start(EnemyList)
    else
        warn("[NamerPro] AutoFarm module chưa sẵn sàng!")
    end
end)

Buttons.CreateToggle(farmTab, "Auto Farm Toggle", false, function(state)
    if AutoFarm and AutoFarm.Toggle then
        AutoFarm.Toggle(state)
    else
        warn("[NamerPro] AutoFarm module chưa sẵn sàng!")
    end
end)

-- Tạo tab Config
local configTab = Tabs.Create(window, "Config", "ImageIdConfig")

Buttons.CreateDropdown(configTab, "Farm Mode", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    print("[NamerPro] Đã chọn mode: " .. selected)
end)

-- Tạo tab Stats
local statsTab = Tabs.Create(window, "Stats", "ImageIdStats")

Buttons.CreateToggle(statsTab, "Auto Melee", false, function(state)
    print("[NamerPro] Auto Melee: " .. (state and "BẬT" or "TẮT"))
end)
