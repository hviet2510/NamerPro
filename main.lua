-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load modules
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab Farm Level
local farmTab = window:newTab("Farm Level", "ImageIdFarm")

-- Toggle Auto Farm
farmTab.newToggle("Auto Farm Level", "Bật/Tắt Auto Farm Level", false, function(state)
    if AutoFarm and AutoFarm.Toggle then
        AutoFarm.Toggle(state, EnemyList)
        print("[NamerPro] Auto Farm Level: " .. (state and "BẬT" or "TẮT"))
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)
