local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "coolstuff",
    LoadingTitle = "Loading UI...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "coolstuff-autocard"
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local SettingsSection = MainTab:CreateSection("Settings")

local AutoSelect = MainTab:CreateToggle({
    Name = "Auto Select Card",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Select:", Value)
        -- Thêm code auto ở đây
    end
})

local CardTab = Window:CreateTab("Card Priorities", 4483362458)
local CardSection = CardTab:CreateSection("Set Priority")

local priorities = {}
local cardList = {"Ambush", "Avarice I", "Avarice II", "Chaos Eater"}

for _, card in ipairs(cardList) do
    CardTab:CreateInput({
        Name = card,
        PlaceholderText = "Priority Number",
        RemoveTextAfterFocusLost = false,
        Callback = function(text)
            priorities[card] = tonumber(text) or 0
            print(card .. " priority set to " .. priorities[card])
        end
    })
end
