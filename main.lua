-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load modules
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()
local AutoStats = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autostats.lua"))()

-- UI
local window = DrRayLibrary:Load("NamerPro UI", "Default")
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")
local configTab = DrRayLibrary.newTab("Config", "ImageIdHere")
local statsTab = DrRayLibrary.newTab("Auto Stats", "ImageIdHere")

-- Auto Farm toggle
farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)

-- Auto Stats toggle
statsTab.newToggle("Auto Stats", "Bật/Tắt Auto Stats", false, function(state)
    AutoStats.Toggle(state)
end)

-- Attack Range
configTab.newDropdown("Attack Range", "Chọn khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    AutoFarm.SetRange(tonumber(selected))
end)

-- Farm Mode
configTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
end)

-- Tool chọn
local tools = {}
for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") then
        table.insert(tools, tool.Name)
    end
end
if #tools == 0 then
    table.insert(tools, "Không có tool")
end

configTab.newDropdown("Chọn Tool", "Tool dùng để farm", tools, function(selected)
    AutoFarm.SetTool(selected)
end)
