-- movement.lua
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Movement = {}

----------------------------------------------------------------
-- 1. Tween đến CFrame hoặc Vector3
----------------------------------------------------------------
function Movement:TweenTo(targetPos, speed)
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart

    local pos = typeof(targetPos) == "CFrame" and targetPos.Position or targetPos
    local dist = (pos - root.Position).Magnitude
    local time = dist / (speed or 60)

    local tween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    return tween
end

----------------------------------------------------------------
-- 2. Bay lên đầu mob
----------------------------------------------------------------
function Movement:FlyAbove(target, height, speed)
    if target and target:FindFirstChild("HumanoidRootPart") then
        local pos = target.HumanoidRootPart.Position + Vector3.new(0, height or 8, 0)
        self:TweenTo(pos, speed or 60)
    end
end

----------------------------------------------------------------
-- 3. Giữ khoảng cách với mob
----------------------------------------------------------------
function Movement:KeepDistance(target, dist, speed)
    if target and target:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local mobPos = target.HumanoidRootPart.Position
        local dir = (root.Position - mobPos).Unit
        local newPos = mobPos + dir * (dist or 10)

        self:TweenTo(newPos + Vector3.new(0, 2, 0), speed or 50)
    end
end

----------------------------------------------------------------
-- 4. Teleport thẳng (Instant)
----------------------------------------------------------------
function Movement:Teleport(pos)
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = typeof(pos) == "CFrame" and pos or CFrame.new(pos)
    end
end

----------------------------------------------------------------
-- 5. Kiểm tra nếu chết thì respawn
----------------------------------------------------------------
function Movement:CheckRespawn()
    local char = Player.Character
    if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
        Player.CharacterAdded:Wait()
        task.wait(1) -- chờ load xong
    end
end

return Movement
