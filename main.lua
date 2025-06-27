-- Tải DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Tải các module
local TabsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua"))()
local ButtonsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua"))()

-- Kiểm tra module
if not DrRayLibrary then return warn("[Main] ❌ Không load được DrRay-ui") end
if not TabsModule or not TabsModule.Create then return warn("[Main] ❌ Tabs module lỗi") end
if not ButtonsModule or not ButtonsModule.Create then return warn("[Main] ❌ Buttons module lỗi") end

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")

-- Tạo Button
ButtonsModule.Create(farmTab, "Start Farm", function()
    print("[NamerPro] Bắt đầu Auto Farm!")
end)
