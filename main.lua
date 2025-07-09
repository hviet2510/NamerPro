-- 🧠 Load UI Library (DrRay)
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- ✅ Load EnemyList TRƯỚC (vì AutoFarm cần nó)
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- ✅ Load AutoFarm SAU (đã fix không dùng global enemyList)
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()

-- 🪟 Tạo cửa sổ chính
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- 📁 Tab: Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")

farmTab.newLabel("Farm quái tự động theo level")

farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)

-- ⚙️ Tab: Config
local configTab = DrRayLibrary.newTab("Config", "ImageIdHere")

configTab.newDropdown("Attack Range", "Khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    local dist = tonumber(selected)
    if dist then
        AutoFarm.SetRange(dist)
    end
end)

configTab.newDropdown("Farm Mode", "Chế độ farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
end)

-- 🎯 Chọn Tool
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
    end
end)
