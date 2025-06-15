local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/infy-sys/linoria-lib/main/library.lua"))()
local Window = Library:CreateWindow({ Title = "Speed Hub X | NamerPro", Center = true, AutoShow = true })

local Tabs = {
    Main = Window:AddTab("🏠 Main"),
    Farm = Window:AddTab("⚔️ Auto Farm"),
    Player = Window:AddTab("👤 Player"),
    Misc = Window:AddTab("⚙️ Misc"),
}

local FarmSection = Tabs.Farm:AddLeftGroupbox("Auto Farm")
FarmSection:AddToggle("AutoFarm", {
    Text = "Auto Farm Level",
    Default = false,
    Callback = function(state)
        getgenv().AutoFarm = state
    end
})

local PlayerSection = Tabs.Player:AddLeftGroupbox("Fly Settings")
PlayerSection:AddButton("Load Fly UI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/fly.lua"))()
end)

Library:OnUnload(function()
    print("Speed Hub X Closed")
end)
