-- Load UI và module
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tab Farm Level
local farmTab = window:newTab("Farm Level", "ImageIdFarm")

farmTab.newToggle("Auto Farm Toggle", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
    print("[NamerPro] Auto Farm: " .. (state and "BẬT" or "TẮT"))
end)

farmTab.newInput("Khoảng cách tấn công", "Nhập khoảng cách (vd: 10)", function(text)
    local num = tonumber(text)
    if num then
        AutoFarm.SetAttackDistance(num)
        print("[NamerPro] Khoảng cách tấn công: " .. num)
    else
        warn("[NamerPro] Giá trị khoảng cách không hợp lệ!")
    end
end)

farmTab.newInput("Delay đòn đánh", "Nhập delay giữa đòn (giây)", function(text)
    local num = tonumber(text)
    if num then
        AutoFarm.SetDelay(num)
        print("[NamerPro] Đặt delay đòn: " .. num)
    else
        warn("[NamerPro] Giá trị delay không hợp lệ!")
    end
end)

farmTab.newDropdown("Farm Mode", "Chọn chế độ farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(mode)
    AutoFarm.SetMode(mode)
    print("[NamerPro] Chế độ farm: " .. mode)
end)

-- Tab Settings
local settingsTab = window:newTab("Settings", "ImageIdSettings")

settingsTab.newInput("Tốc độ Tween", "Nhập tốc độ tween di chuyển", function(text)
    local num = tonumber(text)
    if num then
        AutoFarm.SetTweenSpeed(num)
        print("[NamerPro] Tốc độ tween: " .. num)
    else
        warn("[NamerPro] Giá trị tween không hợp lệ!")
    end
end)

settingsTab.newInput("Tên NPC nhận Quest", "Nhập tên NPC", function(text)
    AutoFarm.SetQuestNPC(text)
    print("[NamerPro] NPC Quest: " .. text)
end)
