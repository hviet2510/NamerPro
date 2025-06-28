-- Load DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")

farmTab.newLabel("Farm quái tự động theo level")

-- Toggle Auto Farm
farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
    print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
end)

-- Dropdown Attack Range
farmTab.newDropdown("Attack Range", "Chọn khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    local range = tonumber(selected)
    if range then
        AutoFarm.SetRange(range)
        print("[NamerPro] Đặt khoảng cách tấn công: " .. range)
    else
        warn("[NamerPro] Khoảng cách không hợp lệ!")
    end
end)

-- Dropdown Farm Mode
farmTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
    print("[NamerPro] Chọn farm mode: " .. mode)
end)

-- Dropdown Tool
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
        print("[NamerPro] Đã chọn tool: " .. selected)
    else
        warn("[NamerPro] Không có tool để trang bị!")
    end
end)
