local function log(step, msg)
    print("[Main][" .. step .. "] " .. msg)
end

local function safeRequire(name, url)
    log(name, "🔄 Đang tải module từ: " .. url)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if ok and result then
        log(name, "✅ Đã tải thành công")
        return result
    else
        warn("[Main][" .. name .. "] ❌ Lỗi khi tải: " .. tostring(result))
        return nil
    end
end

-- Bắt đầu từng bước
log("START", "Bắt đầu thực thi main.lua")

local UI = safeRequire("DrRay UI", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua")
if not UI then return warn("[Main] Không thể tiếp tục do UI lỗi") end

local AutoFarm = safeRequire("AutoFarm", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua")
local EnemyList = safeRequire("EnemyList", "https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua")

log("Window", "Tạo giao diện UI")
local window = UI:Load("NamerPro UI", "Default")

log("Tab", "Tạo tab Farm Level")
local farmTab = UI.newTab("Farm Level", "ImageId")

log("UI", "Thêm nút Auto Farm Toggle")
farmTab.newToggle("Auto Farm", "Tự động farm theo level", false, function(state)
    log("Toggle", "Trạng thái: " .. tostring(state))
    if AutoFarm and EnemyList then
        AutoFarm.Toggle(state, EnemyList)
    else
        warn("[Main][Toggle] ❌ Không tìm thấy module AutoFarm hoặc EnemyList")
    end
end)
