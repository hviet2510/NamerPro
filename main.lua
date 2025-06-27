-- Tải DrRay UI
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Tải AutoFarm & EnemyList
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo Window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab Farm Level
local farmTab = window:newTab("Farm Level", "ImageIdFarm")

-- Toggle: Auto Farm
farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm Level", false, function(state)
    if AutoFarm and AutoFarm.Toggle then
        AutoFarm.Toggle(state, EnemyList)
        print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)

-- Input: Chỉnh tốc độ attack (delay)
farmTab.newInput("Attack Delay", "Nhập delay (giây)", function(text)
    local delay = tonumber(text)
    if delay and AutoFarm and AutoFarm.SetDelay then
        AutoFarm.SetDelay(delay)
        print("[NamerPro] Đặt delay tấn công: " .. delay .. " giây")
    else
        warn("[NamerPro] ❌ Giá trị delay không hợp lệ hoặc AutoFarm chưa sẵn sàng!")
    end
end)

-- Dropdown: Chọn Farm Mode
farmTab.newDropdown("Farm Mode", "Chọn chế độ farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    if AutoFarm and AutoFarm.SetMode then
        AutoFarm.SetMode(mode)
        print("[NamerPro] Đã chọn chế độ: " .. mode)
    else
        warn("[NamerPro] ❌ AutoFarm chưa sẵn sàng hoặc thiếu hàm SetMode!")
    end
end)
