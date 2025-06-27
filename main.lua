local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

AutoFarm.SetEnemyList(EnemyList)

local window = DrRayLibrary:Load("NamerPro UI", "Default")
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdFarm")

farmTab.newToggle("Auto Farm Level", "Bật/Tắt auto farm level", false, function(state)
    AutoFarm.Toggle(state)
end)

farmTab.newDropdown("Chọn Delay", "Chọn delay (giây)", {"0.5", "1", "1.5", "2"}, function(selected)
    AutoFarm.SetDelay(tonumber(selected))
end)

farmTab.newDropdown("Chọn Range", "Khoảng cách tấn công", {"10", "15", "20", "25"}, function(selected)
    AutoFarm.SetRange(tonumber(selected))
end)

farmTab.newDropdown("Chọn Quái", "Hoặc chọn quái thủ công", (function()
    local names = {}
    for _, v in ipairs(EnemyList) do
        table.insert(names, v.Name)
    end
    return names
end)(), function(selected)
    AutoFarm.SetTarget(selected)
end)
