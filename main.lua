-- NamerPro | Speed Hub X UI | FULL FIXED

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/infy-sys/linoria-lib/main/library.lua"))()
local Window = Library:CreateWindow({ Title = "Speed Hub X | NamerPro", Center = true, AutoShow = true })

local Tabs = {
    Main = Window:AddTab("🏠 Main"),
    Farm = Window:AddTab("⚔️ Auto Farm"),
    Player = Window:AddTab("👤 Player"),
    Misc = Window:AddTab("⚙️ Misc"),
}

-- Variables
getgenv().AutoFarm = false

-- Auto Farm Function
task.spawn(function()
    while task.wait() do
        if getgenv().AutoFarm then
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(11) -- Swimming state để đứng yên
                end
                -- Example basic farm (replace with real Blox Fruits farm logic)
                if workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                        end
                    end
                end
            end)
        end
    end
end)

-- UI Sections
local FarmSection = Tabs.Farm:AddLeftGroupbox("Auto Farm")
FarmSection:AddToggle("AutoFarm", {
    Text = "Auto Farm Level (DEMO)",
    Default = false,
    Callback = function(state)
        getgenv().AutoFarm = state
    end
})

local PlayerSection = Tabs.Player:AddLeftGroupbox("Fly Settings")
PlayerSection:AddButton("Load Fly UI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/fly.lua"))()
end)

local MiscSection = Tabs.Misc:AddLeftGroupbox("Other")
MiscSection:AddButton("Rejoin Server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

Library:OnUnload(function()
    getgenv().AutoFarm = false
    print("NamerPro | Speed Hub X UI closed")
end)
