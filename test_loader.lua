-- test_loader.lua
-- Giả lập Roblox loadstring(game:HttpGet(...)) trong môi trường thường

-- ===== CONFIG =====
local GITHUB_USER = "hviet2510"
local GITHUB_REPO = "NamerPro"
local MODULES_PATH = "voxsea-autofarm/src" -- Thư mục chứa modules
local BRANCH = "main"

-- ===== FUNCTION: Lấy danh sách file từ GitHub API =====
local function fetchFilesFromGitHub(path)
    local apiUrl = string.format(
        "https://api.github.com/repos/%s/%s/contents/%s?ref=%s",
        GITHUB_USER, GITHUB_REPO, path, BRANCH
    )

    local handle = io.popen("curl -s \"" .. apiUrl .. "\"")
    local result = handle:read("*a")
    handle:close()

    local json = require("dkjson") -- Cần cài thư viện dkjson (chạy: luarocks install dkjson)
    local data, pos, err = json.decode(result, 1, nil)
    if err then
        error("Lỗi decode JSON: " .. err)
    end

    return data
end

-- ===== FUNCTION: Tải nội dung file từ raw.githubusercontent =====
local function fetchRawFile(path)
    local rawUrl = string.format(
        "https://raw.githubusercontent.com/%s/%s/%s/%s",
        GITHUB_USER, GITHUB_REPO, BRANCH, path
    )
    local handle = io.popen("curl -s \"" .. rawUrl .. "\"")
    local content = handle:read("*a")
    handle:close()
    return content
end

-- ===== MAIN: Auto scan & load =====
print("🔍 Đang quét thư mục modules từ GitHub...")
local files = fetchFilesFromGitHub(MODULES_PATH)

for _, file in ipairs(files) do
    if file.type == "file" and file.name:match("%.lua$") then
        print("📄 Đang load module:", file.name)
        local code = fetchRawFile(file.path)
        print("   ↳ Dung lượng:", #code, "bytes")
    end
end

print("✅ Hoàn tất quét & load modules.")
