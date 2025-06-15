-- Fly UI with Toggle & Speed
local UIS = game:GetService("UserInputService")
local flyToggle = false
local speed = 50
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.05,0,0.2,0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local FlyToggleButton = Instance.new("TextButton", Frame)
FlyToggleButton.Size = UDim2.new(1, 0, 0.4, 0)
FlyToggleButton.Position = UDim2.new(0,0,0,0)
FlyToggleButton.Text = "Toggle Fly [OFF]"

local SpeedSlider = Instance.new("TextBox", Frame)
SpeedSlider.Size = UDim2.new(1, 0, 0.3, 0)
SpeedSlider.Position = UDim2.new(0,0,0.45,0)
SpeedSlider.Text = "Speed: " .. tostring(speed)

local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Size = UDim2.new(1, 0, 0.25, 0)
CloseButton.Position = UDim2.new(0,0,0.75,0)
CloseButton.Text = "Close"

-- Fly function
local bv, bg
function toggleFly()
    flyToggle = not flyToggle
    FlyToggleButton.Text = "Toggle Fly [" .. (flyToggle and "ON" or "OFF") .. "]"

    if flyToggle then
        bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.zero
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        
        bg = Instance.new("BodyGyro", hrp)
        bg.CFrame = hrp.CFrame
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bg.P = 9e4
        
        game:GetService("RunService").Heartbeat:Connect(function()
            if flyToggle then
                bv.Velocity = (hrp.CFrame.LookVector) * speed
                bg.CFrame = hrp.CFrame
            end
        end)
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end

-- Events
FlyToggleButton.MouseButton1Click:Connect(toggleFly)
SpeedSlider.FocusLost:Connect(function()
    local newSpeed = tonumber(SpeedSlider.Text:match("%d+"))
    if newSpeed then
        speed = newSpeed
        SpeedSlider.Text = "Speed: " .. tostring(speed)
    else
        SpeedSlider.Text = "Speed: " .. tostring(speed)
    end
end)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
