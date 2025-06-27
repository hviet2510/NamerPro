-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")

-- Label hướng dẫn
farmTab.newLabel("Farm quái tự động theo level")

-- Toggle Auto Farm
farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    if state then
        AutoFarm.Toggle(true, EnemyList)
        print("[NamerPro] Auto Farm: BẬT")
    else
        AutoFarm.Toggle(false, EnemyList)
        print("[NamerPro] Auto Farm: TẮT")
    end
end)

-- Dropdown chỉnh khoảng cách tấn công
farmTab.newDropdown("Attack Range", "Chọn khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    local distance = tonumber(selected)
    if distance then
        AutoFarm.SetRange(distance)
        print("[NamerPro] Đặt khoảng cách tấn công: "..distance)
    else
        warn("[NamerPro] Khoảng cách không hợp lệ!")
    end
end)

-- Dropdown chọn mode farm
farmTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
    print("[NamerPro] Chọn farm mode: "..mode)
end)

-- Dropdown chọn tool
local tools = {}
for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") then
        table.insert(tools, tool.Name)
    end
end
if #tools == 0 then
    table.insert(tools, "Không có tool")
end

farmTab.newDropdown("Chọn Tool", "Tool dùng để farm", tools, function(selected)
    if selected ~= "Không có tool" then
        AutoFarm.SetTool(selected)
        print("[NamerPro] Đã chọn tool: "..selected)
    end
end)
