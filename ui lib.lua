local UILib = {}
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
    ScreenGui.Name = "NamerProUI"
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 420, 0, 280)
    Main.Position = UDim2.new(0.5, -210, 0.5, -140)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Name = "MainFrame"
    Main.ClipsDescendants = true
    Main.BackgroundTransparency = 0
    Main.Visible = true
    Main.Active = true
    Main.Draggable = true

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Text = "  🔥 " .. title
    Title.TextXAlignment = Enum.TextXAlignment.Left

    return Main
end

function UILib:CreateToggle(parent, text, callback)
    local Toggle = Instance.new("TextButton", parent)
    Toggle.Size = UDim2.new(1, -20, 0, 40)
    Toggle.Position = UDim2.new(0, 10, 0, 60)
    Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Toggle.BorderSizePixel = 0
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 16
    Toggle.Text = "🟢 " .. text
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.Name = "AutoFarmToggle"

    local enabled = false
    Toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        Toggle.Text = (enabled and "🟢 " or "⚫ ") .. text
        if callback then
            callback(enabled)
        end
    end)
end

return UILib
