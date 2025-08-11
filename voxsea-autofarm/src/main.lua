-- 📌 Cấu hình repo GitHub
local RepoBase = "https://raw.githubusercontent.com/hviet2510/NamerPro/main/voxsea-autofarm/src/"

-- 📌 Danh sách module cần load
local Modules = {
    "Orion.lua",         -- UI Library
    "utils.lua",         -- Xử lý dữ liệu
    "movement.lua",      -- Điều khiển di chuyển
    "enemy-selector.lua" -- Chọn quái theo level
}

-- 📌 Hàm tải module từ GitHub
local LoadedModules = {}
local function LoadModule(name)
    local url = RepoBase .. name
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        LoadedModules[name] = result
        print("[LOADED] " .. name)
    else
        warn("[FAILED] " .. name .. ": " .. tostring(result))
    end
end

-- 📌 Tải tất cả module
for _, m in ipairs(Modules) do
    LoadModule(m)
end

-- 📌 Khởi tạo UI Orion
local OrionLib = LoadedModules["Orion.lua"]
local Window = OrionLib:MakeWindow({
    Name = "VoxSea AutoFarm",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VoxSeaFarm"
})

-- 📌 Tab & chức năng
local TabFarm = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TabFarm:AddToggle({
    Name = "Bật/Tắt AutoFarm",
    Default = false,
    Callback = function(state)
        if state then
            LoadedModules["utils.lua"].StartFarm(LoadedModules, Window)
        else
            LoadedModules["utils.lua"].StopFarm()
        end
    end
})

OrionLib:Init()
