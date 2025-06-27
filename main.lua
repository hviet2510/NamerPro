-- Load DrRay library từ repo NamerPro
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo Tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdFarm")

farmTab.newLabel("Farm Level Functions")
farmTab.newButton("Start Farm", "Bắt đầu auto farm", function()
    print("[NamerPro] Bắt đầu auto farm")
end)
farmTab.newToggle("Auto Farm Toggle", "Bật/Tắt auto farm", false, function(state)
    if state then
        print("[NamerPro] Auto Farm: BẬT")
    else
        print("[NamerPro] Auto Farm: TẮT")
    end
end)
farmTab.newInput("Attack Delay", "Nhập delay tấn công", function(text)
    print("[NamerPro] Delay Attack: "..text)
end)

-- Tạo Tab Config
local configTab = DrRayLibrary.newTab("Config", "ImageIdConfig")

configTab.newLabel("Cấu hình chung")
configTab.newDropdown("Farm Mode", "Chọn mode farm", {"Bình Thường", "Nhanh", "An Toàn"}, function(selected)
    print("[NamerPro] Đã chọn mode: "..selected)
end)
configTab.newButton("Reset Config", "Reset cấu hình về mặc định", function()
    print("[NamerPro] Đã reset config")
end)

-- Tạo Tab Stats
local statsTab = DrRayLibrary.newTab("Stats", "ImageIdStats")

statsTab.newLabel("Quản lý chỉ số")
statsTab.newToggle("Auto Melee", "Bật/Tắt auto nâng Melee", false, function(state)
    print("[NamerPro] Auto Melee: "..(state and "BẬT" or "TẮT"))
end)
statsTab.newButton("Nâng 10 Melee", "Click để nâng 10 điểm vào Melee", function()
    print("[NamerPro] Nâng 10 điểm Melee")
end)
