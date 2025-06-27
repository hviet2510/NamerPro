-- Load DrRay library
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Load modules
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

-- Create window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tab: Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdFarm")

farmTab.newLabel("Farm Level Functions")

farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    if state then
        local target = EnemyList.GetByLevel(game.Players.LocalPlayer.Level.Value)
        if target then
            print("[NamerPro] Auto Farm target: " .. target.Name)
            AutoFarm.Start(target)
        else
            warn("[NamerPro] Không tìm thấy quái phù hợp level!")
        end
    else
        AutoFarm.Stop()
        print("[NamerPro] Auto Farm: TẮT")
    end
end)

farmTab.newInput("Attack Delay", "Nhập delay tấn công (giây)", function(text)
    local delay = tonumber(text)
    if delay then
        AutoFarm.SetDelay(delay)
        print("[NamerPro] Delay attack set to: " .. delay)
    else
        warn("[NamerPro] Giá trị delay không hợp lệ!")
    end
end)

farmTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    AutoFarm.SetMode(selected)
    print("[NamerPro] Đã chọn farm mode: " .. selected)
end)

-- Tab: Settings
local settingsTab = DrRayLibrary.newTab("Settings", "ImageIdSettings")

settingsTab.newInput("Tween Speed", "Nhập tốc độ Tween", function(text)
    local speed = tonumber(text)
    if speed then
        AutoFarm.SetTweenSpeed(speed)
        print("[NamerPro] Tween speed set to: " .. speed)
    else
        warn("[NamerPro] Giá trị tween speed không hợp lệ!")
    end
end)

settingsTab.newInput("Attack Range", "Nhập khoảng cách tấn công", function(text)
    local range = tonumber(text)
    if range then
        AutoFarm.SetRange(range)
        print("[NamerPro] Attack range set to: " .. range)
    else
        warn("[NamerPro] Giá trị range không hợp lệ!")
    end
end)

settingsTab.newToggle("Auto Quest", "Bật/Tắt tự nhận quest", false, function(state)
    AutoFarm.SetAutoQuest(state)
    print("[NamerPro] Auto Quest: " .. (state and "BẬT" or "TẮT"))
end)
