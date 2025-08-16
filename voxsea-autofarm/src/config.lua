-- =======================================================
-- == Script Console Di động cho điện thoại             ==
-- =======================================================
-- Chạy script này để tạo một cửa sổ hiển thị output
-- trên màn hình, thay thế cho Developer Console (F9).
-- =======================================================

-- Nếu đã có console rồi thì không tạo nữa
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("MobileConsoleGui") then return end

-- Tạo GUI
local ConsoleGui = Instance.new("ScreenGui")
ConsoleGui.Name = "MobileConsoleGui"
ConsoleGui.Parent = game.Players.LocalPlayer.PlayerGui
ConsoleGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.6, 0, 0.4, 0) -- 60% chiều rộng, 40% chiều cao
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ConsoleGui

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 25)
Header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Text = "Mobile Console"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Parent = Header

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Size = UDim2.new(0, 50, 0, 20)
ClearButton.Position = UDim2.new(1, -55, 0.5, -10)
ClearButton.Text = "Clear"
ClearButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.Parent = Header

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(1, 0, 1, -25)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 25)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)

-- Hàm để thêm một dòng log vào console
local function addLog(message, color)
    local logLabel = Instance.new("TextLabel")
    logLabel.Text = tostring(message)
    logLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    logLabel.Font = Enum.Font.Code
    logLabel.TextSize = 14
    logLabel.TextXAlignment = Enum.TextXAlignment.Left
    logLabel.TextWrapped = true
    logLabel.Size = UDim2.new(1, -10, 0, 0)
    logLabel.AutomaticSize = Enum.AutomaticSize.Y
    logLabel.Parent = ScrollingFrame
    
    -- Tự động cuộn xuống dưới
    ScrollingFrame.CanvasPosition = Vector2.new(0, UIListLayout.AbsoluteContentSize.Y)
end

-- Sự kiện khi bấm nút Clear
ClearButton.MouseButton1Click:Connect(function()
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end)

-- Ghi đè hàm print gốc để hiển thị trên console GUI
local oldPrint = print
_G.print = function(...)
    local args = {...}
    local output = ""
    for i, v in pairs(args) do
        output = output .. tostring(v) .. "\t"
    end
    addLog(output)
    return oldPrint(...) -- Vẫn in ra console gốc nếu có
end

addLog("Console di động đã sẵn sàng!", Color3.fromRGB(0, 255, 0))
