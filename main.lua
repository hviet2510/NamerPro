-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()
local AutoStats = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autostats.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")
farmTab.newLabel("Farm quái tự động theo level")

farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
    print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
end)

-- Tab Config
local configTab = DrRayLibrary.newTab("Config", "ImageIdHere")
configTab.newLabel("Cấu hình Auto Farm")

configTab.newDropdown("Attack Range", "Chọn khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    local distance = tonumber(selected)
    if distance then
        AutoFarm.SetRange(distance)
        print("[NamerPro] Đặt khoảng cách tấn công: " .. distance)
    else
        warn("[NamerPro] Khoảng cách không hợp lệ!")
    end
end)

configTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
    print("[NamerPro] Chọn farm mode: " .. mode)
end)

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
    if selected ~= "Không có tool" then
        AutoFarm.SetTool(selected)
        print("[NamerPro] Đã chọn tool: " .. selected)
    end
end)

-- Tab Auto Stats
local statsTab = DrRayLibrary.newTab("Auto Stats", "ImageIdStats")
statsTab.newLabel("Tự động nâng điểm")

statsTab.newToggle("Auto Stats", "Bật/Tắt Auto Stats", false, function(state)
    AutoStats.Toggle(state)
    print("[NamerPro] Auto Stats: " .. (state and "BẬT" or "TẮT"))
end)

statsTab.newDropdown("Chỉ số", "Chọn chỉ số nâng", {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"}, function(stat)
    AutoStats.SetStat(stat)
    print("[NamerPro] Đã chọn nâng: " .. stat)
end)
