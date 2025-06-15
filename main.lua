local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/refs/heads/main/main.lua"))()
local Window = Library:CreateWindow({
    Title = "Synapses Hub X | NamerPro",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab("🏠 Main"),
    Farm = Window:AddTab("⚔️ Auto Farm"),
    Player = Window:AddTab("👤 Player"),
    Misc = Window:AddTab("⚙️ Misc"),
}

local MainSection = Tabs.Main:AddLeftGroupbox("Main Settings")
local FarmSection = Tabs.Farm:AddLeftGroupbox("Auto Farm")
local PlayerSection = Tabs.Player:AddLeftGroupbox("Player")
local MiscSection = Tabs.Misc:AddLeftGroupbox("Other")

-- Ví dụ thêm toggle:
FarmSection:AddToggle("AutoFarm", {
    Text = "Auto Farm Level",
    Default = false,
    Callback = function(state)
        getgenv().AutoFarm = state
    end
})

-- Thêm slider tốc độ bay
PlayerSection:AddSlider("FlySpeed", {
    Text = "Fly Speed",
    Default = 50,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        getgenv().FlySpeed = Value
    end
})

Library:OnUnload(function()
    print("Synapses hub X Closed")
end)
