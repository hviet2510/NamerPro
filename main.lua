local function safeLoad(name, url)
    print("[Main] 🔄 Tải: "..name)
    local ok, result = pcall(function() return loadstring(game:HttpGet(url))() end)
    if ok and result then
        print("[Main] ✅ Đã tải: "..name)
        return result
    else
        warn("[Main] ❌ Lỗi tải: "..name.."\n"..tostring(result))
        return nil
    end
end

local DrRayLibrary = safeLoad("DrRay-ui", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua")
local Tabs = safeLoad("Tabs", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua")
local Buttons = safeLoad("Buttons", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua")
local AutoFarm = safeLoad("AutoFarm", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua")
local EnemyList = safeLoad("EnemyList", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua")

if not DrRayLibrary then return warn("[Main] ❌ Không thể khởi tạo UI") end

local window = DrRayLibrary:Load("NamerPro UI", "Default")
local farmTab = Tabs.Create(window, "Farm Level", "ImageIdFarm")

Buttons.Create(farmTab, "Start Farm", function()
    AutoFarm.Start(EnemyList)
end)

Buttons.CreateToggle(farmTab, "Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)
