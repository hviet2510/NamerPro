-- Tải DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Tải các module
local TabsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua"))()
local ButtonsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")

-- Button: Start Farm
ButtonsModule.Create(farmTab, "Start Farm", function()
    if AutoFarm and AutoFarm.Start then
        AutoFarm.Start(EnemyList)
        print("[NamerPro] Bắt đầu Auto Farm!")
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
        end
