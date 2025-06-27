-- Load DrRay Library
local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/hviet2510/main/DrRay.lua"))()

-- Tạo cửa sổ UI
local window = DrRayLibrary:Load("Noda Farm", "Default")

-- Tạo Tab Farm Level
local farmTab = DrRayLibrary.newTab("Farm Level", "rbxassetid://123456789")

farmTab.newLabel("Auto Farm Settings")
farmTab.newToggle("Auto Farm", "Bật/Tắt auto farm quái", false, function(state)
    if state then
        print("Auto Farm: BẬT")
        -- Gọi hàm auto farm của bạn ở đây
        -- AutoFarm(EnemyList)
    else
        print("Auto Farm: TẮT")
    end
end)

farmTab.newButton("Force Start Farm", "Bắt đầu farm ngay", function()
    print("Đã nhấn nút bắt đầu farm!")
    -- AutoFarm(EnemyList)
end)

-- Tạo Tab Config
local configTab = DrRayLibrary.newTab("Config", "rbxassetid://987654321")

configTab.newLabel("Auto Stats Settings")
configTab.newToggle("Auto Stats", "Bật/Tắt auto nâng chỉ số", false, function(state)
    if state then
        print("Auto Stats: BẬT")
        -- AutoStats()
    else
        print("Auto Stats: TẮT")
    end
end)

configTab.newInput("Set Attack Delay", "Nhập delay tấn công", function(text)
    local value = tonumber(text)
    if value then
        print("Set Attack Delay:", value)
        -- Config.AttackDelay = value
    else
        warn("Giá trị không hợp lệ!")
    end
end)

configTab.newDropdown("Chọn Ưu Tiên Vũ Khí", "Chọn loại ưu tiên", {"Melee", "Sword", "Gun"}, function(selected)
    print("Đã chọn:", selected)
    -- Config.PreferWeapon = selected
end)
