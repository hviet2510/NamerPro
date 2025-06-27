-- Load DrRay library từ repo NamerPro
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Import Tabs & Buttons module của bạn
local TabsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/Tabs.lua"))()
local ButtonsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/Buttons.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab Farm Level qua module Tabs
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")

-- Thêm nút và toggle qua module Buttons
ButtonsModule.Create(farmTab, "Start Farm", function()
    print("[NamerPro] Bắt đầu auto farm")
end)

ButtonsModule.CreateToggle(farmTab, "Auto Farm Toggle", false, function(state)
    print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
end)

-- Tạo Tab Config
local configTab = TabsModule.Create(window, "Config", "ImageIdConfig")

ButtonsModule.CreateDropdown(configTab, "Farm Mode", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    print("[NamerPro] Đã chọn mode: " .. selected)
end)

ButtonsModule.Create(configTab, "Reset Config", function()
    print("[NamerPro] Đã reset config")
end)

-- Tạo Tab Stats
local statsTab = TabsModule.Create(window, "Stats", "ImageIdStats")

ButtonsModule.CreateToggle(statsTab, "Auto Melee", false, function(state)
    print("[NamerPro] Auto Melee: " .. (state and "BẬT" or "TẮT"))
end)

ButtonsModule.Create(statsTab, "Nâng 10 Melee", function()
    print("[NamerPro] Nâng 10 điểm Melee")
end)
