-- Fly Script with Mobile Toggle UI & Speed Slider
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local flying = false
local speed = 50 -- Tốc độ mặc định
local bodyGyro, bodyVelocity

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "FlyGui"

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0, 20, 0, 150)
ToggleButton.Size = UDim2.new(0, 120, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "Fly: OFF"
ToggleButton.TextSize = 18

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = ScreenGui
SpeedBox.Position = UDim2.new(0, 20, 0, 210)
SpeedBox.Size = UDim2.new(0, 120, 0, 40)
SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.PlaceholderText = "Speed: " .. tostring(speed)
SpeedBox.Text = ""
SpeedBox.TextSize = 16

function Fly()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = humanoidRootPart

    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            local moveDirection = Vector3.new()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                moveDirection = player.Character.Humanoid.MoveDirection
            end
            bodyVelocity.velocity = workspace.CurrentCamera.CFrame:VectorToWorldSpace(moveDirection) * speed
        end
    end)
end

ToggleButton.Mouse
