local AutoStats = {}
local running = false
local selectedStat = "Melee"

function AutoStats.SetStat(stat)
    selectedStat = stat
end

function AutoStats.Toggle(state)
    running = state
    if running then
        spawn(function()
            while running do
                AutoStats.Upgrade()
                wait(0.5)
            end
        end)
    end
end

function AutoStats.Upgrade()
    local plr = game.Players.LocalPlayer
    local stats = plr:FindFirstChild("leaderstats")
    if not stats then return end

    local points = plr:FindFirstChild("Points") or plr:FindFirstChild("AvailablePoints") or nil
    if points and points.Value > 0 then
        -- Gửi remote hoặc command nâng điểm ở đây nếu game yêu cầu
        -- Ví dụ giả lập:
        print("[NamerPro] Đang nâng "..selectedStat.." với "..points.Value.." điểm.")
        -- Bạn thay bằng code thực sự gửi request tới server nâng điểm.
    end
end

return AutoStats
