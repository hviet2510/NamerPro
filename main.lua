local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local TabsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/module/tabs.lua"))()
local ButtonsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/module/buttons.lua"))()

local window = DrRayLibrary:Load("NamerPro UI", "Default")

local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")
ButtonsModule.Create(farmTab, "Start Farm", function()
    print("[NamerPro] Bắt đầu auto farm")
end)
ButtonsModule.CreateToggle(farmTab, "Auto Farm Toggle", false, function(state)
    print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
end)

local configTab = TabsModule.Create(window, "Config", "ImageIdConfig")
ButtonsModule.CreateDropdown(configTab, "Farm Mode", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    print("[NamerPro] Đã chọn mode: " .. selected)
end)

local statsTab = TabsModule.Create(window, "Stats", "ImageIdStats")
ButtonsModule.CreateToggle(statsTab, "Auto Melee", false, function(state)
    print("[NamerPro] Auto Melee: " .. (state and "BẬT" or "TẮT"))
end)
