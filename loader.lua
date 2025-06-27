print("[Loader] 🔄 Đang tải main.lua...")

local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/main.lua")
end)

if success and response and response ~= "" then
    print("[Loader] ✅ Đã tải main.lua thành công. Đang thực thi...")
    local run, err = pcall(function()
        loadstring(response)()
    end)
    if run then
        print("[Loader] 🎉 Đã thực thi main.lua thành công!")
    else
        warn("[Loader] ❌ LỖI khi chạy main.lua: ", err)
    end
else
    warn("[Loader] ❌ LỖI tải main.lua từ GitHub: ", response)
end
