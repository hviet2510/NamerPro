-- =======================================================================
-- == Script Macro Auto Farm - Phiên bản Siêu Click (DEBUGGED v2)        ==
-- =======================================================================

-- =======================================================================
-- == PHẦN 1: CẤU HÌNH (CONFIGURATION)                                   ==
-- =======================================================================

local CONFIG = {
    DIG_BUTTON_TEXT = "Dig",
    PAN_BUTTON_TEXT = "Pan",
    WAIT_TIME_AFTER_ACTION = 5,
    WAIT_TIME_AFTER_TELEPORT = 1
}

-- =======================================================================
-- == PHẦN 2: GIAO DIỆN NGƯỜI DÙNG (GUI)                                 ==
-- =======================================================================

-- (Phần này không thay đổi, giữ nguyên code tạo giao diện)
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local sandPosition = nil
local waterPosition = nil
local isFarming = false
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
-- == -> Đã nâng cấp hàm nhấn nút với nhiều phương pháp.                 ==
-- =======================================================================

-- [NÂNG CẤP] Hàm "Siêu Click"
function tryClicking(buttonObject)
    -- Thử phương pháp 1: Chạm (Tốt nhất cho di động)
    if firetouch then
        print("Attempting click with: firetouch")
        firetouch(buttonObject)
        return
    end

    -- Thử phương pháp 2: Click (Tên hàm phổ biến khác)
    if fireclick then
        print("Attempting click with: fireclick")
        fireclick(buttonObject)
        return
    end

    -- Thử phương pháp 3: Tín hiệu MouseButton1Click (Cách cũ)
    if firesignal then
        print("Attempting click with: firesignal")
        firesignal(buttonObject.MouseButton1Click)
        return
    end

    print("Error: No supported click function (firetouch, fireclick, firesignal) was found.")
    statusLabel.Text = "Error: Executor not supported!"
    isFarming = false -- Dừng farm nếu không có hàm click
end

-- Hàm dịch chuyển nhân vật
function teleport(position)
    if position and humanoidRootPart then
        humanoidRootPart.CFrame = position
    end
end

-- Hàm tìm nút, giờ sẽ sử dụng hàm "Siêu Click"
function findAndClickButtonByText(buttonText)
    for _, obj in ipairs(playerGui:GetDescendants()) do
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and (obj:FindFirstChildOfClass("TextLabel") or obj:IsA("TextButton")) then
            local textToShow = obj:IsA("TextButton") and obj.Text or obj:FindFirstChildOfClass("TextLabel").Text
            if textToShow:lower():match(buttonText:lower()) then
                statusLabel.Text = "Status: Clicking '"..textToShow.."'..."
                -- Gọi hàm siêu click mới
                tryClicking(obj)
                return true
            end
        end
    end
    statusLabel.Text = "Error: Can't find button '"..buttonText.."'!"
    return false
end

-- =======================================================================
-- == PHẦN 4: VÒNG LẶP CHÍNH (MAIN LOOP)                                 ==
-- =======================================================================
-- (Phần này không thay đổi)
function startFarming()
    while isFarming do
        if not sandPosition or not waterPosition then
            statusLabel.Text = "Error: Please save both positions!"; isFarming = false
            toggleButton.Text = "Bắt đầu Farm"; toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
            break
        end
        statusLabel.Text = "Status: Moving to sand position..."
        teleport(sandPosition)
        wait(CONFIG.WAIT_TIME_AFTER_TELEPORT)
        findAndClickButtonByText(CONFIG.DIG_BUTTON_TEXT)
        wait(CONFIG.WAIT_TIME_AFTER_ACTION)
        statusLabel.Text = "Status: Moving to water position..."
        teleport(waterPosition)
        wait(CONFIG.WAIT_TIME_AFTER_TELEPORT)
        findAndClickButtonByText(CONFIG.PAN_BUTTON_TEXT)
        wait(CONFIG.WAIT_TIME_AFTER_ACTION)
        statusLabel.Text = "Status: Round complete!"
        wait(1)
    end
end

-- =======================================================================
-- == PHẦN 5: KHỞI TẠO & KẾT NỐI SỰ KIỆN (INITIALIZATION)                ==
-- =======================================================================
-- (Phần này không thay đổi)
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
statusLabel.Text = "Status: Ready. Please save positions."
