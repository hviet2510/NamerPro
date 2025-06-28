print("[Loader] 🔄 Đang tải main.lua...")

local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/main.lua")
end)

if success and response and response ~= "" then
    print("[Loader] ✅ Đã tải main.lua thành công.")
    local run, err = pcall(function()
        loadstring(response)()
    end)
    if not run then
        warn("[Loader] ❌ Lỗi khi chạy main.lua: " .. tostring(err))
    end
else
    warn("[Loader] ❌ Không tải được main.lua: " .. tostring(response))
end
