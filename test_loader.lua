-- test_loader.lua
-- Test auto-scan & load modules từ GitHub repo

local http = require("socket.http")
local json = require("dkjson")

-- ===================== CONFIG =====================
local owner = "hviet2510"
local repo = "NamerPro"
local path = "voxsea-autofarm/src"
local branch = "main"
-- ===================================================

-- Hàm tải dữ liệu từ URL
local function fetch(url)
    local body, code, headers, status = http.request {
            url = url,
                    method = "GET",
                            headers = {
                                        ["User-Agent"] = "Lua GitHub Loader Test"
                                                }
                                                    }
                                                        if not body then
                                                                return nil, "Không nhận được phản hồi từ server"
                                                                    end
                                                                        if code ~= 200 then
                                                                                return nil, "HTTP Code: " .. tostring(code)
                                                                                    end
                                                                                        return body
                                                                                        end

                                                                                        -- API URL GitHub để lấy danh sách file
                                                                                        local apiUrl = string.format(
                                                                                            "https://api.github.com/repos/%s/%s/contents/%s?ref=%s",
                                                                                                owner, repo, path, branch
                                                                                                )

                                                                                                print("🔍 Đang tải danh sách modules từ GitHub...")
                                                                                                local body, err = fetch(apiUrl)
                                                                                                if not body then
                                                                                                    print("❌ Lỗi:", err)
                                                                                                        return
                                                                                                        end

                                                                                                        -- Parse JSON trả về
                                                                                                        local data, pos, jsonErr = json.decode(body, 1, nil)
                                                                                                        if jsonErr then
                                                                                                            print("❌ Lỗi parse JSON:", jsonErr)
                                                                                                                return
                                                                                                                end

                                                                                                                -- Lọc danh sách file .lua
                                                                                                                local luaFiles = {}
                                                                                                                for _, file in ipairs(data) do
                                                                                                                    if file.name:match("%.lua$") and file.name ~= "main.lua" then
                                                                                                                            table.insert(luaFiles, file)
                                                                                                                                end
                                                                                                                                end

                                                                                                                                print("📦 Tìm thấy", #luaFiles, "module(s) để load")
                                                                                                                                print("----------------------------------")

                                                                                                                                -- Load từng file theo thứ tự
                                                                                                                                for i, file in ipairs(luaFiles) do
                                                                                                                                    print(string.format("[%d/%d] Đang load: %s", i, #luaFiles, file.name))
                                                                                                                                        local rawUrl = file.download_url
                                                                                                                                            local content, dlErr = fetch(rawUrl)
                                                                                                                                                if not content then
                                                                                                                                                        print("   ❌ Lỗi tải:", dlErr)
                                                                                                                                                            else
                                                                                                                                                                    print("   ✅ Đã tải thành công (" .. #content .. " bytes)")
                                                                                                                                                                            -- Test compile file (chỉ kiểm tra cú pháp, không chạy)
                                                                                                                                                                                    local fn, syntaxErr = load(content, file.name)
                                                                                                                                                                                            if not fn then
                                                                                                                                                                                                        print("   ❌ Lỗi cú pháp:", syntaxErr)
                                                                                                                                                                                                                else
                                                                                                                                                                                                                            print("   ⚡ Cú pháp OK")
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                        end

                                                                                                                                                                                                                                        print("----------------------------------")
                                                                                                                                                                                                                                        print("🎯 Hoàn tất test loader.")