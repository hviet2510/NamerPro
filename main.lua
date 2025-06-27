local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local Tabs = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua"))()
local Buttons = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = Tabs.Create(window, "Farm Level", "ImageIdFarm")

-- Tạo button Start Farm
Buttons.Create(farmTab, "Start Farm", function()
    print("[NamerPro] Bắt đầu auto farm")
end)
