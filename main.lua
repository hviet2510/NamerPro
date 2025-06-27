local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Kiểm tra DrRay hỗ trợ tạo tab kiểu nào
local farmTab
if window.newTab then
    farmTab = window:newTab("Farm Level", "ImageIdFarm")
elseif DrRayLibrary.newTab then
    farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdFarm")
else
    error("[NamerPro] ❌ Không tìm thấy hàm tạo tab trong DrRay!")
end

farmTab.newButton("Start Farm", "Bắt đầu Auto Farm", function()
    AutoFarm.Start(EnemyList)
end)

farmTab.newToggle("Auto Farm Toggle", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)

farmTab.newInput("Attack Delay", "Nhập delay (giây)", function(text)
    local num = tonumber(text)
    if num then
        AutoFarm.SetDelay(num)
    else
        warn("[NamerPro] Giá trị delay không hợp lệ!")
    end
end)
