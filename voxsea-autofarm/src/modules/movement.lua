-- movement.lua
-- Module chuyên về di chuyển / tween / fly / respawn-safe

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Movement = {}
local activeTween = nil
local activeDiedConn = nil

-- PRIVATE: chờ character load đủ (HRP + Humanoid)
local function WaitForCharacter()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then humanoid = char:WaitForChild("Humanoid") end
    return char, hrp, humanoid
end

-- PRIVATE: stop active tween & disconnect died connection
local function StopActiveTween()
    if activeTween then
        pcall(function() activeTween:Cancel() end)
        activeTween = nil
    end
    if activeDiedConn then
        pcall(function() activeDiedConn:Disconnect() end)
        activeDiedConn = nil
    end
end

-- Tween tới một Vector3 hoặc CFrame (await = true sẽ wait tween Completed)
function Movement:TweenTo(targetPos, speed, await)
    local _, root, humanoid = WaitForCharacter()
    if not root or not humanoid or humanoid.Health <= 0 then return false end

    local pos = (typeof(targetPos) == "CFrame") and targetPos.Position or targetPos
    local dist = (pos - root.Position).Magnitude
    local t = math.max(0.08, dist / (speed or 60))

    StopActiveTween()
    local tween = TweenService:Create(root, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    activeTween = tween

    -- khi chết thì hủy tween để tránh lỗi ghost movement
    activeDiedConn = humanoid.Died:Connect(function()
        StopActiveTween()
    end)

    tween:Play()

    if await == nil or await == true then
        -- chờ hoàn thành trước khi trả về
        tween.Completed:Wait()
        StopActiveTween()
        return true
    else
        tween.Completed:Connect(function()
            StopActiveTween()
        end)
        return tween
    end
end

-- Bay lên đầu mob an toàn (await true sẽ chờ hoàn tất tween)
function Movement:FlyAbove(mob, height, speed, await)
    if not mob or not mob.PrimaryPart and not mob:FindFirstChild("HumanoidRootPart") then return false end
    local part = mob.PrimaryPart or mob:FindFirstChild("HumanoidRootPart")
    if not part then return false end
    local above = part.Position + Vector3.new(0, (height or 8), 0)
    return self:TweenTo(above, speed or 60, await)
end

-- Giữ khoảng cách so với mob (đi tới 1 vị trí phía sau/xa mob)
function Movement:KeepDistance(mob, distanceFromMob, speed, await)
    local _, root = WaitForCharacter()
    if not root or not mob or not (mob.PrimaryPart or mob:FindFirstChild("HumanoidRootPart")) then return false end
    local part = mob.PrimaryPart or mob:FindFirstChild("HumanoidRootPart")
    local dir = root.Position - part.Position
    if dir.Magnitude == 0 then dir = Vector3.new(0,0,1) end
    dir = dir.Unit
    local newPos = part.Position + dir * (distanceFromMob or 10) + Vector3.new(0, 2, 0)
    return self:TweenTo(newPos, speed or 60, await)
end

-- Teleport ngay lập tức (instant)
function Movement:Teleport(pos)
    local _, root = WaitForCharacter()
    if root then
        root.CFrame = (typeof(pos) == "CFrame") and pos or CFrame.new(pos)
    end
end

-- Nếu chết, chờ respawn và trả về char, hrp, humanoid mới
function Movement:WaitForRespawn()
    local char = Player.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        return char, char:FindFirstChild("HumanoidRootPart"), humanoid
    end
    -- chờ character mới
    local newChar = Player.CharacterAdded:Wait()
    local hrp = newChar:WaitForChild("HumanoidRootPart")
    local newHum = newChar:FindFirstChildOfClass("Humanoid") or newChar:WaitForChild("Humanoid")
    task.wait(0.8) -- chờ một chút resource load (tối ưu mobile)
    return newChar, hrp, newHum
end

return Movement
