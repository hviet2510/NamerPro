-- =======================================================================
-- == Script Macro Recorder - Phiên bản Cao cấp v2.1 (FIXED RECORDING)   ==
-- =======================================================================

-- =======================================================================
-- == PHẦN 1: KHỞI TẠO VÀ CÁC BIẾN TRẠNG THÁI                            ==
-- =======================================================================

local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- "Cuốn sổ" để ghi lại các hành động
local recordedActions = {}
local isRecording = false
local isPlaying = false
local lastActionTime = 0
local inputConnection = nil

-- Biến lưu vị trí teleport
local savedSandPos = nil
local savedWaterPos = nil

-- =======================================================================
-- == PHẦN 2: GIAO DIỆN NGƯỜI DÙNG (GUI) NÂNG CẤP                         ==
-- =======================================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui; screenGui.ResetOnSpawn = false
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 230); mainFrame.Position = UDim2.new(0.5, -110, 0.5, -115)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45); mainFrame.BorderColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Draggable = true; mainFrame.Active = true; mainFrame.Parent = screenGui
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30); titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.Text = "Premium Macro Recorder"; titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold; titleLabel.TextSize = 18; titleLabel.Parent = mainFrame
local recordSandPosButton = Instance.new("TextButton")
recordSandPosButton.Size = UDim2.new(0.45, 0, 0, 40); recordSandPosButton.Position = UDim2.new(0.03, 0, 0, 40)
recordSandPosButton.BackgroundColor3 = Color3.fromRGB(230, 126, 34); recordSandPosButton.TextColor3 = Color3.fromRGB(255, 255, 255)
recordSandPosButton.Text = "Ghi Vị Trí Cát"; recordSandPosButton.Font = Enum.Font.SourceSans; recordSandPosButton.TextSize = 14
recordSandPosButton.Parent = mainFrame
local recordWaterPosButton = Instance.new("TextButton")
recordWaterPosButton.Size = UDim2.new(0.45, 0, 0, 40); recordWaterPosButton.Position = UDim2.new(0.52, 0, 0, 40)
recordWaterPosButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219); recordWaterPosButton.TextColor3 = Color3.fromRGB(255, 255, 255)
recordWaterPosButton.Text = "Ghi Vị Trí Nước"; recordWaterPosButton.Font = Enum.Font.SourceSans; recordWaterPosButton.TextSize = 14
recordWaterPosButton.Parent = mainFrame
local startRecordButton = Instance.new("TextButton")
startRecordButton.Size = UDim2.new(0.45, 0, 0, 40); startRecordButton.Position = UDim2.new(0.03, 0, 0, 90)
startRecordButton.BackgroundColor3 = Color3.fromRGB(70, 130, 200); startRecordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startRecordButton.Text = "Bắt đầu Ghi"; startRecordButton.Font = Enum.Font.SourceSans; startRecordButton.TextSize = 14
startRecordButton.Parent = mainFrame
local stopRecordButton = Instance.new("TextButton")
stopRecordButton.Size = UDim2.new(0.45, 0, 0, 40); stopRecordButton.Position = UDim2.new(0.52, 0, 0, 90)
stopRecordButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70); stopRecordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopRecordButton.Text = "Dừng Ghi"; stopRecordButton.Font = Enum.Font.SourceSans; stopRecordButton.TextSize = 14
stopRecordButton.Parent = mainFrame
local startPlaybackButton = Instance.new("TextButton")
startPlaybackButton.Size = UDim2.new(0.45, 0, 0, 40); startPlaybackButton.Position = UDim2.new(0.03, 0, 0, 140)
startPlaybackButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85); startPlaybackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startPlaybackButton.Text = "Bắt đầu Lặp"; startPlaybackButton.Font = Enum.Font.SourceSans; startPlaybackButton.TextSize = 14
startPlaybackButton.Parent = mainFrame
local stopPlaybackButton = Instance.new("TextButton")
stopPlaybackButton.Size = UDim2.new(0.45, 0, 0, 40); stopPlaybackButton.Position = UDim2.new(0.52, 0, 0, 140)
stopPlaybackButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70); stopPlaybackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopPlaybackButton.Text = "Dừng Lặp"; stopPlaybackButton.Font = Enum.Font.SourceSans; stopPlaybackButton.TextSize = 14
stopPlaybackButton.Parent = mainFrame
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30); statusLabel.Position = UDim2.new(0, 0, 1, -30)
statusLabel.BackgroundColor3 = Color3.fromRGB(55, 55, 55); statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Status: Idle"; statusLabel.Font = Enum.Font.SourceSans; statusLabel.TextSize = 16
statusLabel.Parent = mainFrame

-- =======================================================================
-- == PHẦN 3: CÁC HÀM LÕI (CORE FUNCTIONS)                              ==
-- =======================================================================

function tryClicking(buttonObject) if firetouch then firetouch(buttonObject); return end; if fireclick then fireclick(buttonObject); return end; if firesignal then firesignal(buttonObject.MouseButton1Click); return end; print("Error: No supported click function found.") end
function findObjectByPath(path) local current = game; for _, name in ipairs(path:split(".")) do current = current:FindFirstChild(name); if not current then return nil end end; return current end

function startPlayback()
    isPlaying = true; statusLabel.Text = "Status: Playing back..."
    while isPlaying do
        for _, action in ipairs(recordedActions) do
            if not isPlaying then break end
            if action.type == "wait" then statusLabel.Text = "Status: Waiting for "..string.format("%.1f", action.duration).."s"; wait(action.duration)
            elseif action.type == "click" then local targetButton = findObjectByPath(action.target); if targetButton then statusLabel.Text = "Status: Clicking "..targetButton.Name; tryClicking(targetButton) else statusLabel.Text = "Error: Can't find "..action.target; wait(1) end
            elseif action.type == "teleport_sand" then if savedSandPos then statusLabel.Text = "Status: Teleporting to Sand"; humanoidRootPart.CFrame = savedSandPos else statusLabel.Text = "Error: Sand pos not saved!" end
            elseif action.type == "teleport_water" then if savedWaterPos then statusLabel.Text = "Status: Teleporting to Water"; humanoidRootPart.CFrame = savedWaterPos else statusLabel.Text = "Error: Water pos not saved!" end
            end
        end
        statusLabel.Text = "Status: Sequence looped."; wait(1)
    end
end

function recordAction(action)
    if not isRecording then return end
    local currentTime = tick(); local waitDuration = currentTime - lastActionTime; lastActionTime = currentTime
    table.insert(recordedActions, {type="wait", duration=waitDuration}); table.insert(recordedActions, action)
    statusLabel.Text = "Recorded action: "..action.type
end

function startRecording()
    if isRecording then return end
    isRecording = true; recordedActions = {}; statusLabel.Text = "Status: Recording..."; lastActionTime = tick()
    inputConnection = UserInputService.InputBegan:Connect(function(input, gpe)
        -- [ĐÃ SỬA LỖI] Bỏ điều kiện 'and not gpe' để ghi lại tất cả các cú click lên GUI
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            -- Thay vì dùng 'input.Position', chúng ta sẽ dùng hàm mới để tìm đối tượng GUI một cách đáng tin cậy hơn
            local objects = playerGui:GetGuiObjectsAtPosition(input.Position.X, input.Position.Y)
            if #objects > 0 then
                local guiObject = objects[1]
                if guiObject and (guiObject:IsA("TextButton") or guiObject:IsA("ImageButton")) then 
                    recordAction({type="click", target=guiObject:GetFullName()}) 
                end
            end
        end
    end)
end

function stopRecording()
    if not isRecording then return end
    isRecording = false; statusLabel.Text = "Status: Recording stopped. "..(#recordedActions/2).." actions saved."
    if inputConnection then inputConnection:Disconnect(); inputConnection = nil end
end

-- =======================================================================
-- == PHẦN 4: KẾT NỐI SỰ KIỆN (EVENT CONNECTIONS)                        ==
-- =======================================================================

startRecordButton.MouseButton1Click:Connect(startRecording)
stopRecordButton.MouseButton1Click:Connect(stopRecording)
startPlaybackButton.MouseButton1Click:Connect(function() if #recordedActions == 0 then statusLabel.Text = "Status: Nothing to play!"; return end; if not isPlaying then startPlayback() end end)
stopPlaybackButton.MouseButton1Click:Connect(function() if isPlaying then isPlaying = false; statusLabel.Text = "Status: Playback stopped." end end)
recordSandPosButton.MouseButton1Click:Connect(function() savedSandPos = humanoidRootPart.CFrame; statusLabel.Text = "Sand position saved."; recordAction({type="teleport_sand"}) end)
recordWaterPosButton.MouseButton1Click:Connect(function() savedWaterPos = humanoidRootPart.CFrame; statusLabel.Text = "Water position saved."; recordAction({type="teleport_water"}) end)

