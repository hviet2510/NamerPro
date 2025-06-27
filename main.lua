-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load modules
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab Farm Level
local farmTab = window:newTab("Farm Level", "ImageIdFarm")

-- Toggle: Auto Farm
farmTab.newToggle("Auto Farm", "Bật/Tắt auto farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)

-- Input: Delay tấn công
farmTab.newInput("Delay (giây)", "Nhập delay tấn công (VD: 1)", function(text)
    local n = tonumber(text)
    if n then
        AutoFarm.SetDelay(n)
        print("[NamerPro] Delay set: " .. n)
    else
        warn("[NamerPro] Delay không hợp lệ!")
    end
end)

-- Input: Khoảng cách tấn công
farmTab.newInput("Khoảng cách", "Khoảng cách tấn công (VD: 50)", function(text)
    local n = tonumber(text)
    if n then
        AutoFarm.SetDistance(n)
        print("[NamerPro] Khoảng cách set: " .. n)
    else
        warn("[NamerPro] Khoảng cách không hợp lệ!")
    end
end)

-- Dropdown: Farm Mode
farmTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    AutoFarm.SetMode(selected)
    print("[NamerPro] Mode farm: " .. selected)
end)
