local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/main.lua")
end)

if success then
    loadstring(response)()
else
    warn("Không thể tải main.lua từ GitHub!")
end
