-- =======================================================================
-- == Script Macro Auto Farm - Phiên bản có cấu trúc rõ ràng            ==
-- =======================================================================

-- =======================================================================
-- == PHẦN 1: CẤU HÌNH (CONFIGURATION)                                   ==
-- == -> Bạn chỉ cần chỉnh sửa các thông số trong phần này khi cần.       ==
-- =======================================================================

local CONFIG = {
    -- Tên các nút trong game (phải chính xác tuyệt đối, không phân biệt hoa/thường)
    DIG_BUTTON_TEXT = "Dig",
    PAN_BUTTON_TEXT = "Pan",
    
    -- Thời gian chờ sau mỗi hành động (tính bằng giây)
    WAIT_TIME_AFTER_ACTION = 5,
    WAIT_TIME_AFTER_TELEPORT = 1
}

-- =======================================================================
-- == PHẦN 2: GIAO DIỆN NGƯỜI DÙNG (GUI)                                 ==
-- == -> Phần này tạo ra cửa sổ điều khiển. Không cần chỉnh sửa.         ==
-- =======================================================================

-- Các biến toàn cục cho script
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local sandPosition = nil
local waterPosition = nil
local isFarming = false

-- Code tạo giao diện
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui; screenGui.ResetOnSpawn = false
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200); mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45); mainFrame.BorderColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Draggable = true; mainFrame.Active = true; mainFrame.Parent = screenGui
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30); titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.Text = "Auto Farm Macro"; titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold; titleLabel.TextSize = 18; titleLabel.Parent = mainFrame
local saveSandButton = Instance.new("TextButton")
saveSandButton.Size = UDim2.new(0, 280, 0, 30); saveSandButton.Position = UDim2.new(0.5, -140, 0, 40)
saveSandButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70); saveSandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveSandButton.Text = "Lưu Vị Trí Cát"; saveSandButton.Font = Enum.Font.SourceSans; saveSandButton.TextSize = 16
saveSandButton.Parent = mainFrame
local saveWaterButton = Instance.new("TextButton")
saveWaterButton.Size = UDim2.new(0, 280, 0, 30); saveWaterButton.Position = UDim2.new(0.5, -140, 0, 80)
saveWaterButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70); saveWaterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveWaterButton.Text = "Lưu Vị Trí Nước"; saveWaterButton.Font = Enum.Font.SourceSans; saveWaterButton.TextSize = 16
saveWaterButton.Parent = mainFrame
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 280, 0, 40); toggleButton.Position = UDim2.new(0.5, -140, 0, 120)
toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85); toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Bắt đầu Farm"; toggleButton.Font = Enum.Font.SourceSansBold; toggleButton.TextSize = 20
toggleButton.Parent = mainFrame
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20); statusLabel.Position = UDim2.new(0, 0, 1, -20)
statusLabel.BackgroundColor3 = Color3.fromRGB(55, 55, 55); statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Status: Idle"; statusLabel.Font = Enum.Font.SourceSans; statusLabel.TextSize = 14
statusLabel.Parent = mainFrame

-- =======================================================================
-- == PHẦN 3: CÁC HÀM LÕI (CORE FUNCTIONS)                              ==
-- == -> Chứa các "công cụ" để script hoạt động.                         ==
-- == -> Nếu lỗi nhấn nút, chỉ cần sửa hàm findAndClickButtonByText.      ==
-- =======================================================================

-- Hàm dịch chuyển nhân vật
function teleport(position)
    if position and humanoidRootPart then
        humanoidRootPart.CFrame = position
    end
end

-- Hàm tìm và nhấn nút dựa trên văn bản
function findAndClickButtonByText(buttonText)
    for _, obj in ipairs(playerGui:GetDescendants()) do
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and (obj:FindFirstChildOfClass("TextLabel") or obj:IsA("TextButton")) then
            local textToShow = obj:IsA("TextButton") and obj.Text or obj:FindFirstChildOfClass("TextLabel").Text
            if textToShow:lower():match(buttonText:lower()) then
                statusLabel.Text = "Status: Clicking '"..textToShow.."'..."
                firesignal(obj.MouseButton1Click)
                return true
            end
        end
    end
    statusLabel.Text = "Error: Can't find button '"..buttonText.."'!"
    return false
end

-- =======================================================================
-- == PHẦN 4: VÒNG LẶP CHÍNH (MAIN LOOP)                                 ==
-- == -> Nơi quy trình farm được thực hiện.                              ==
-- == -> Nếu muốn thay đổi thứ tự, chỉ cần sửa trong vòng lặp while.     ==
-- =======================================================================

function startFarming()
    while isFarming do
        if not sandPosition or not waterPosition then
            statusLabel.Text = "Error: Please save both positions!"; isFarming = false
            toggleButton.Text = "Bắt đầu Farm"; toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
            break
        end

        -- Bước 1: Đến chỗ cát
        statusLabel.Text = "Status: Moving to sand position..."
        teleport(sandPosition)
        wait(CONFIG.WAIT_TIME_AFTER_TELEPORT)
        
        -- Bước 2: Nhấn nút đào
        findAndClickButtonByText(CONFIG.DIG_BUTTON_TEXT)
        wait(CONFIG.WAIT_TIME_AFTER_ACTION)

        -- Bước 3: Đến chỗ nước
        statusLabel.Text = "Status: Moving to water position..."
        teleport(waterPosition)
        wait(CONFIG.WAIT_TIME_AFTER_TELEPORT)
        
        -- Bước 4: Nhấn nút đãi
        findAndClickButtonByText(CONFIG.PAN_BUTTON_TEXT)
        wait(CONFIG.WAIT_TIME_AFTER_ACTION)
        
        statusLabel.Text = "Status: Round complete!"
        wait(1)
    end
end

-- =======================================================================
-- == PHẦN 5: KHỞI TẠO & KẾT NỐI SỰ KIỆN (INITIALIZATION)                ==
-- == -> Gắn các chức năng vào nút bấm. Không cần chỉnh sửa.             ==
-- =======================================================================

saveSandButton.MouseButton1Click:Connect(function()
    sandPosition = humanoidRootPart.CFrame; statusLabel.Text = "Sand position saved!"
end)

saveWaterButton.MouseButton1Click:Connect(function()
    waterPosition = humanoidRootPart.CFrame; statusLabel.Text = "Water position saved!"
end)

toggleButton.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    if isFarming then
        toggleButton.Text = "Dừng Farm"
        toggleButton.BackgroundColor3 = Color3.fromRGB(170, 85, 85)
        startFarming()
    else
        statusLabel.Text = "Status: Stopped by user."
        toggleButton.Text = "Bắt đầu Farm"
        toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
    end
end)

-- Thông báo script đã sẵn sàng
statusLabel.Text = "Status: Ready. Please save positions."
