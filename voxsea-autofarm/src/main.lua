-- =========================
-- Loader auto-scan module từ GitHub API
-- Orion UI - Tối ưu cho Mobile
-- =========================

local HttpService = game:GetService("HttpService")
local PLAYER = game.Players.LocalPlayer

-- Config Repo
local GITHUB_USER = "hviet2510"
local GITHUB_REPO = "NamerPro"
local GITHUB_BRANCH = "main"
local SRC_PATH = "voxsea-autofarm/src"

-- Hàm gọi API GitHub
local function getFolderFiles(path)
    local apiUrl = string.format("https://api.github.com/repos/%s/%s/contents/%s", GITHUB_USER, GITHUB_REPO, path)
    local ok, res = pcall(function()
        return game:HttpGet(apiUrl)
    end)
    if not ok then
        warn("[Loader] Không thể gọi API GitHub:", res)
        return {}
    end
    local data = HttpService:JSONDecode(res)
    return data
end

-- Hàm load file .lua
local function loadLuaFromUrl(url, name)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok then
        warn("[Loader] Không thể tải module:", name, res)
        return
    end
    local fn, err = loadstring(res)
    if not fn then
        warn("[Loader] Lỗi biên dịch module:", name, err)
        return
    end
    local success, msg = pcall(fn)
    if not success then
        warn("[Loader] Lỗi chạy module:", name, msg)
    else
        print("[Loader] Đã load module:", name)
    end
end

-- Tải config.lua & themes.lua trước
local function loadCoreFiles()
    local coreFiles = { "config.lua", "themes.lua" }
    for _, file in ipairs(coreFiles) do
        local fileUrl = string.format(
            "https://raw.githubusercontent.com/%s/%s/%s/%s/%s",
            GITHUB_USER, GITHUB_REPO, GITHUB_BRANCH, SRC_PATH, file
        )
        loadLuaFromUrl(fileUrl, file)
    end
end

-- Tải toàn bộ modules
local function loadAllModules()
    local files = getFolderFiles(SRC_PATH .. "/modules")
    for _, file in ipairs(files) do
        if file.type == "file" and file.name:match("%.lua$") then
            loadLuaFromUrl(file.download_url, file.name)
        end
    end
end

-- =========================
-- Orion UI Init
-- =========================
local OrionLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/shlexware/Orion/main/source"
))()

local Window = OrionLib:MakeWindow({
    Name = "VoxSea Autofarm",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VoxSeaAuto",
    IntroEnabled = true,
    IntroText = "VoxSea Hub Loading...",
    CloseCallback = function()
        OrionLib:Destroy()
    end
})

-- Tab chính
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddParagraph("📦 Trạng thái", "Đang load modules từ GitHub...")

-- =========================
-- Chạy Loader
-- =========================
task.spawn(function()
    loadCoreFiles()
    loadAllModules()
    MainTab:UpdateParagraph(1, "📦 Trạng thái", "✅ Load xong tất cả modules!")
end)

OrionLib:Init()
