local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

-- Frame chính
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Tabs trái
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(0, 120, 1, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- Nội dung phải
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Position = UDim2.new(0, 120, 0, 0)
contentFrame.Size = UDim2.new(1, -120, 1, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- Tiêu đề Tabs
local tabTitle = Instance.new("TextLabel", tabFrame)
tabTitle.Size = UDim2.new(1, 0, 0, 50)
tabTitle.Text = "coolstuff"
tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tabTitle.BackgroundTransparency = 1
tabTitle.TextScaled = true
tabTitle.Font = Enum.Font.GothamBold

-- Tab Main
local tabButton = Instance.new("TextButton", tabFrame)
tabButton.Position = UDim2.new(0, 0, 0, 60)
tabButton.Size = UDim2.new(1, 0, 0, 40)
tabButton.Text = "Main"
tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Section Title
local sectionTitle = Instance.new("TextLabel", contentFrame)
sectionTitle.Position = UDim2.new(0, 10, 0, 10)
sectionTitle.Size = UDim2.new(1, -20, 0, 40)
sectionTitle.Text = "Settings"
sectionTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
sectionTitle.BackgroundTransparency = 1
sectionTitle.TextScaled = true
sectionTitle.Font = Enum.Font.GothamBold

-- Nút Toggle
local toggle = Instance.new("TextButton", contentFrame)
toggle.Position = UDim2.new(0, 10, 0, 60)
toggle.Size = UDim2.new(0, 200, 0, 30)
toggle.Text = "[ ] Auto Select Card"
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)

local isOn = false
toggle.MouseButton1Click:Connect(function()
    isOn = not isOn
    toggle.Text = isOn and "[✔] Auto Select Card" or "[ ] Auto Select Card"
end)
