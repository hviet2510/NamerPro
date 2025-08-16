-- =======================================================================
-- == Đối tác lập trình: Script Macro Auto Farm (Final Version)         ==
-- == Chú thích: Tiếng Việt                                             ==
-- == Logic & Trạng thái: Tiếng Anh                                      ==
-- == Cấu hình cho game: Prospecting                                     ==
-- =======================================================================

-- Phần 1: Tạo Giao Diện Điều Khiển
-- -----------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Tạo khung chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200); mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45); mainFrame.BorderColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Draggable = true; mainFrame.Active = true; mainFrame.Parent = screenGui

-- Tạo tiêu đề
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30); titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.Text = "Auto Farm Macro"; titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold; titleLabel.TextSize = 18; titleLabel.Parent = mainFrame

-- Nút lưu vị trí cát (Giao diện của chúng ta vẫn là tiếng Việt cho bạn dễ dùng)
local saveSandButton = Instance.new("TextButton")
saveSandButton.Size = UDim2.new(0, 280, 0, 30); saveSandButton.Position = UDim2.new(0.5, -140, 0, 40)
saveSandButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70); saveSandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveSandButton.Text = "Lưu Vị Trí Cát"; saveSandButton.Font = Enum.Font.SourceSans; saveSandButton.TextSize = 16
saveSandButton.Parent = mainFrame

-- Nút lưu vị trí nước
local saveWaterButton = Instance.new("TextButton")
saveWaterButton.Size = UDim2.new(0, 280, 0, 30); saveWaterButton.Position = UDim2.new(0.5, -140, 0, 80)
saveWaterButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70); saveWaterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveWaterButton.Text = "Lưu Vị Trí Nước"; saveWaterButton.Font = Enum.Font.SourceSans; saveWaterButton.TextSize = 16
saveWaterButton.Parent = mainFrame

-- Nút bắt đầu/dừng
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 280, 0, 40); toggleButton.Position = UDim2.new(0.5, -140, 0, 120)
toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85); toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Bắt đầu Farm"; toggleButton.Font = Enum.Font.SourceSansBold; toggleButton.TextSize = 20
toggleButton.Parent = mainFrame

-- Nhãn hiển thị trạng thái (sẽ dùng tiếng Anh)
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20); statusLabel.Position = UDim2.new(0, 0, 1, -20)
statusLabel.BackgroundColor3 = Color3.fromRGB(55, 55, 55); statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Status: Idle"; statusLabel.Font = Enum.Font.SourceSans; statusLabel.TextSize = 14
statusLabel.Parent = mainFrame

-- Phần 2: Logic của Script Macro
-- -----------------------------------------------------------------
-- Lấy các thông tin cần thiết từ game
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local playerGui = player:WaitForChild("PlayerGui")

-- Các biến để lưu trữ trạng thái
local sandPosition = nil
local waterPosition = nil
local isFarming = false

-- Hàm tìm và nhấn nút dựa trên văn bản
function findAndClickButtonByText(buttonText)
    -- Quét qua tất cả các đối tượng trên màn hình
    for _, obj in ipairs(playerGui:GetDescendants()) do
        -- Kiểm tra xem có phải là nút bấm không
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj:FindFirstChildOfClass("TextLabel") or obj:IsA("TextButton") then
            local textToShow = obj:IsA("TextButton") and obj.Text or obj:FindFirstChildOfClass("TextLabel").Text
            -- So sánh văn bản trên nút (không phân biệt chữ hoa/thường)
            if textToShow:lower():match(buttonText:lower()) then
                print("Found button: " .. textToShow)
                statusLabel.Text = "Status: Clicking '"..textToShow.."'..."
                -- Giả lập hành động click chuột
                firesignal(obj, "MouseButton1Click")
                return true -- Trả về true nếu thành công
            end
        end
    end
    print("Could not find button with text: " .. buttonText)
    statusLabel.Text = "Error: Can't find button '"..buttonText.."'!"
    return false -- Trả về false nếu thất bại
end

-- Hàm dịch chuyển nhân vật
function teleport(position)
    if position and humanoidRootPart then
        humanoidRootPart.CFrame = position
        wait(0.5)
    end
end

-- Hàm vòng lặp farm chính
function startFarming()
    -- [ĐÃ CẬP NHẬT] Tên các nút theo hình ảnh bạn cung cấp
    local fillButtonText = "Dig"
    local shakeButtonText = "Pan"
    
    while isFarming do
        -- Kiểm tra xem người dùng đã lưu vị trí chưa
        if not sandPosition or not waterPosition then
            statusLabel.Text = "Error: Please save both positions!"; isFarming = false
            toggleButton.Text = "Bắt đầu Farm"; toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
            break
        end

        statusLabel.Text = "Status: Moving to sand position..."
        teleport(sandPosition)
        wait(1)
        
        -- Tìm và nhấn nút múc cát
        findAndClickButtonByText(fillButtonText)
        wait(5) -- Đợi cho hành động hoàn tất

        statusLabel.Text = "Status: Moving to water position..."
        teleport(waterPosition)
        wait(1)
        
        -- Tìm và nhấn nút lắc chảo
        findAndClickButtonByText(shakeButtonText)
        wait(5) -- Đợi cho hành động hoàn tất
        
        statusLabel.Text = "Status: Round complete!"
        wait(1)
    end
end

-- Phần 3: Kết Nối Các Sự Kiện Với Nút Bấm
-- -----------------------------------------------------------------
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
