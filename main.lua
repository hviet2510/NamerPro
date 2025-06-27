-- Tải DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Tải các module
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdFarm")

-- Thêm button bắt đầu farm
farmTab.newButton("Start Farm", "Bắt đầu Auto Farm", function()
    if AutoFarm and AutoFarm.Start then
        AutoFarm.Start(EnemyList)
        print("[NamerPro] ✅ Bắt đầu Auto Farm!")
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)

-- Thêm toggle bật/tắt auto farm
farmTab.newToggle("Auto Farm Toggle", "Bật/Tắt Auto Farm", false, function(state)
    if AutoFarm and AutoFarm.Toggle then
        AutoFarm.Toggle(state, EnemyList)
        print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)

-- Thêm input cho delay
farmTab.newInput("Attack Delay", "Nhập delay (giây)", function(text)
    local num = tonumber(text)
    if num then
        if AutoFarm and AutoFarm.SetDelay then
            AutoFarm.SetDelay(num)
            print("[NamerPro] Delay Attack đặt thành: "..num.." giây")
        else
            warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
        end
    else
        warn("[NamerPro] ❌ Giá trị delay không hợp lệ!")
    end
end)

-- (Tuỳ chọn) Thêm tab Config nếu cần
-- local configTab = DrRayLibrary.newTab("Config", "ImageIdConfig")
-- configTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
--     print("[NamerPro] Đã chọn mode: "..selected)
-- end)
