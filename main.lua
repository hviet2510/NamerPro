-- Load library + modules
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdFarm")

-- Tạo label
farmTab.newLabel("Auto Farm Level với Tool")

-- Tạo toggle bật/tắt Auto Farm
farmTab.newToggle("Auto Farm", "Bật hoặc tắt auto farm", false, function(state)
    AutoFarm.Toggle(state)
    if state then
        AutoFarm.Start(EnemyList)
        print("[NamerPro] Đã bật auto farm!")
    else
        print("[NamerPro] Đã tắt auto farm!")
    end
end)

-- Tạo input delay
farmTab.newInput("Attack Delay", "Nhập delay (giây)", function(text)
    local num = tonumber(text)
    if num then
        AutoFarm.SetDelay(num)
        print("[NamerPro] Delay đặt thành: "..num)
    else
        warn("[NamerPro] Delay không hợp lệ!")
    end
end)

-- Tạo dropdown chọn tool
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
    end
end)
