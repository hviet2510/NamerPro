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

-- Tải các module
local DrRayLibrary = safeLoad("DrRay-ui", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua")
local TabsModule = safeLoad("Tabs", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/tabs.lua")
local ButtonsModule = safeLoad("Buttons", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/buttons.lua")
local AutoFarm = safeLoad("AutoFarm", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua")
local EnemyList = safeLoad("EnemyList", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua")

-- Kiểm tra bắt buộc
if not DrRayLibrary then return warn("❌ Không thể tiếp tục: UI library lỗi!") end
if not TabsModule then return warn("❌ Không thể tiếp tục: Tabs module lỗi!") end
if not ButtonsModule then return warn("❌ Không thể tiếp tục: Buttons module lỗi!") end

-- Tạo window
local window = DrRayLibrary:Load("NamerPro UI", "Default")

-- Tạo tab Farm Level
local farmTab = TabsModule.Create(window, "Farm Level", "ImageIdFarm")

-- Button: Start Farm
ButtonsModule.Create(farmTab, "Start Farm", function()
    if AutoFarm and AutoFarm.Start then
        AutoFarm.Start(EnemyList)
        print("[NamerPro] 🚀 Bắt đầu Auto Farm!")
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)

-- Toggle: Auto Farm
ButtonsModule.CreateToggle(farmTab, "Auto Farm Toggle", false, function(state)
    if AutoFarm and AutoFarm.Toggle then
        AutoFarm.Toggle(state)
        print("[NamerPro] Auto Farm: ".. (state and "BẬT" or "TẮT"))
    else
        warn("[NamerPro] ❌ AutoFarm module chưa sẵn sàng!")
    end
end)
