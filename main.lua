-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load modules
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- UI Setup
local window = DrRayLibrary:Load("NamerPro Premium", "Default")

-- 🗡️ Tab: Farm
local farmTab = DrRayLibrary.newTab("Farm Level", "rbxassetid://12345678")
farmTab.newLabel("Farm tự động theo level")

farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state)
end)

-- 🛠️ Tab: Cấu Hình
local configTab = DrRayLibrary.newTab("Cấu Hình", "rbxassetid://87654321")

configTab.newDropdown("Khoảng cách tấn công", "Chọn range", {"5", "10", "15", "20", "30"}, function(range)
    AutoFarm.SetRange(tonumber(range))
end)

configTab.newDropdown("Chế độ Farm", "Chọn mode", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
end)

-- 🔪 Chọn Tool
local toolNames = {}
for _, tool in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") then
        table.insert(toolNames, tool.Name)
    end
end
if #toolNames == 0 then table.insert(toolNames, "Không có tool") end

configTab.newDropdown("Chọn Tool", "Tool để farm", toolNames, function(selected)
    if selected ~= "Không có tool" then
        AutoFarm.SetTool(selected)
    end
end)
