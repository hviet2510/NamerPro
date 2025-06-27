-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")

-- Toggle Auto Farm
farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)

-- Dropdown chỉnh khoảng cách tấn công
farmTab.newDropdown("Attack Range", "Chọn khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    AutoFarm.SetRange(tonumber(selected))
end)

-- Dropdown chọn mode farm
farmTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
end)
