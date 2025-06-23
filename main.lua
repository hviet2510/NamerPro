local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "Admin - Map của Vieth1394",
    LoadingTitle = "Loading...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Admin_Vieth1394"
    }
})

local MainTab = Window:CreateTab("Admin Panel", 4483362458)

MainTab:CreateButton({
    Name = "Teleport đến Vị trí A",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0) -- Thay tọa độ vị trí bạn muốn
    end
})

MainTab:CreateSlider({
    Name = "Tốc độ chạy",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

MainTab:CreateButton({
    Name = "Godmode (Bất tử)",
    Callback = function()
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = math.huge end
    end
})

MainTab:CreateButton({
    Name = "Kick người khác (nếu có)",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                player:Kick("Bạn đã bị admin map kick")
            end
        end
    end
})
