local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local TabsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua"))()
local ButtonsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab Farm Level
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")
ButtonsModule.Create(farmTab, "Start Farm", function()
    AutoFarm.Start(EnemyList)
end)
ButtonsModule.CreateToggle(farmTab, "Auto Farm Toggle", false, function(state)
    AutoFarm.Toggle(state)
end)

-- Tạo Tab Config
local configTab = TabsModule.Create(window, "Config", "ImageIdConfig")
ButtonsModule.CreateDropdown(configTab, "Farm Mode", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    print("[NamerPro] Đã chọn mode: " .. selected)
end)

-- Tạo Tab Stats
local statsTab = TabsModule.Create(window, "Stats", "ImageIdStats")
ButtonsModule.CreateToggle(statsTab, "Auto Melee", false, function(state)
    print("[NamerPro] Auto Melee: " .. (state and "BẬT" or "TẮT"))
end)
