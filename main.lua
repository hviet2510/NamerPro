local function safeLoad(name, url)
    print("[Main] 🔄 Đang tải module: "..name)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if ok and result then
        print("[Main] ✅ Đã tải: "..name)
        return result
    else
        warn("[Main] ❌ LỖI tải module: "..name.." -> "..tostring(result))
        return nil
    end
end

local DrRayLibrary = safeLoad("DrRay-ui", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua")
local TabsModule = safeLoad("Tabs", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua")
local ButtonsModule = safeLoad("Buttons", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua")
local AutoFarm = safeLoad("AutoFarm", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua")
local EnemyList = safeLoad("EnemyList", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua")

if not DrRayLibrary or not TabsModule or not ButtonsModule then
    return warn("[Main] ❌ Không thể tiếp tục: UI module lỗi!")
end

local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tab Farm Level
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")

ButtonsModule.Create(farmTab, "Start Farm", function()
    if AutoFarm and AutoFarm.Start then
        AutoFarm.Start(EnemyList)
        print("[NamerPro] Bắt đầu Auto Farm!")
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)

ButtonsModule.CreateToggle(farmTab, "Auto Farm Toggle", false, function(state)
    if AutoFarm and AutoFarm.Toggle then
        AutoFarm.Toggle(state, EnemyList)
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)

ButtonsModule.CreateInput(farmTab, "Set Delay", "Nhập delay (s)", function(text)
    if AutoFarm and AutoFarm.SetDelay then
        AutoFarm.SetDelay(text)
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)
