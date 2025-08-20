-- Dịch vụ
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- Webhook Discord
local WEBHOOK_URL = "https://discord.com/api/webhooks/1221364248785981571/ZNqaNh7eMz-OKalevl5kU5rki1p4qQbWYlGWbV77LM5SFJkMPi7N1CeWJAQpfyPCNPc1"

-- Lấy dữ liệu trận đấu
local function getMatchData()
    local DataFolder = player:WaitForChild("Data")
    local PlayerStats = DataFolder:WaitForChild("Stats")

    return {
        PlayerName = player.Name,
        MapName = PlayerStats:FindFirstChild("CurrentMap") and PlayerStats.CurrentMap.Value or "Unknown",
        MaxWave = PlayerStats:FindFirstChild("MaxWave") and PlayerStats.MaxWave.Value or 0,
        Result = PlayerStats:FindFirstChild("LastResult") and PlayerStats.LastResult.Value or "Thắng",
        Duration = PlayerStats:FindFirstChild("MatchTime") and PlayerStats.MatchTime.Value or 0, -- thời gian trận đấu
        Seed = PlayerStats:FindFirstChild("Seed") and PlayerStats.Seed.Value or 0 -- tiền tệ trong game
    }
end

-- Gửi Embed lên Discord
local function sendMatchEmbed(matchData)
    local color = (matchData.Result == "Thắng") and 65280 or 16711680

    local embed = {
        title = "🎮 Kết Quả Trận Đấu Garden Tower Defense",
        color = color,
        fields = {
            {name = "Người chơi", value = matchData.PlayerName, inline = true},
            {name = "Map", value = matchData.MapName, inline = true},
            {name = "Wave cao nhất", value = tostring(matchData.MaxWave), inline = true},
            {name = "Thời gian đi", value = tostring(matchData.Duration).."s", inline = true},
            {name = "Kết quả", value = matchData.Result, inline = true},
            {name = "Seed", value = tostring(matchData.Seed), inline = true},
        },
        footer = {text = "GTD Match Bot"},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local data = {
        username = "GTD Match Bot",
        embeds = {embed}
    }

    local success, err = pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("✅ Gửi kết quả Embed thành công!")
    else
        warn("❌ Gửi kết quả thất bại:", err)
    end
end

-- Lắng nghe kết thúc trận đấu
local MatchEndEvent = ReplicatedStorage:WaitForChild("MatchEndEvent")
MatchEndEvent.OnClientEvent:Connect(function()
    local matchData = getMatchData()
    sendMatchEmbed(matchData)
end)

-- ==========================
-- Tạo nút Test Webhook nhỏ
-- ==========================
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 30)
button.Position = UDim2.new(0.8, 0, 0.05, 0)
button.Text = "Test Webhook"
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.Parent = ScreenGui

button.MouseButton1Click:Connect(function()
    -- Gửi dữ liệu test
    local testData = {
        PlayerName = player.Name,
        MapName = "Test Map",
        MaxWave = 10,
        Duration = 180,
        Result = "Thắng",
        Seed = 500
    }
    sendMatchEmbed(testData)
end)
