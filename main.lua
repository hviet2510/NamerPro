-- Load UI lib
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load modules
local TabsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua"))()
local ButtonsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua"))()

-- Kiểm tra
if not DrRayLibrary then return warn("[Main] ❌ DrRay-ui lỗi") end
if not TabsModule or not ButtonsModule then return warn("[Main] ❌ Module Tabs/Buttons lỗi") end

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab qua window
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")

-- Tạo button
ButtonsModule.Create(farmTab, "Start Farm", function()
    print("[NamerPro] 🚀 Bắt đầu Auto Farm")
end)
