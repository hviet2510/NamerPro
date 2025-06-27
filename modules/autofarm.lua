local AutoFarm = {}
local farming = false
local farmRange = 10
local toolName = nil
local currentMob = nil
local TweenService = game:GetService("TweenService")

function AutoFarm.SetRange(range)
    farmRange = range
    print("[NamerPro] Khoảng cách tấn công:", farmRange)
end

function AutoFarm.SetTool(name)
    toolName = name
    print("[NamerPro] Đặt tool:", toolName)
end

function AutoFarm.Stop()
    farming = false
    currentMob = nil
    print("[NamerPro] Đã dừng Auto Farm")
end

local function tweenTo(targetPos, speed)
    if not targetPos or typeof(targetPos) ~= "Vector3" then return end
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local distance = (char.HumanoidRootPart.Position - targetPos).Magnitude
    local tweenTime = distance / speed
    local tween = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {Position = targetPos})
    tween:Play()
    tween.Completed:Wait()
end

local function equipTool(char)
    if toolName and char and not char:FindFirstChild(toolName) then
        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
        if tool then
            tool.Parent = char
            task.wait(0.05)
            print("[NamerPro] Auto equip tool:", toolName)
        else
            warn("[NamerPro] Không tìm thấy tool:", toolName)
        end
    end
end

function AutoFarm.Toggle(state, enemyList)
    if state then
        if farming then return end
        farming = true
        print("[NamerPro] Auto Farm: BẬT")
        task.spawn(function()
            while farming do
                local player = game.Players.LocalPlayer
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then task.wait(0.1) continue end

                local level = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Level") and player.leaderstats.Level.Value
                if type(level) ~= "number" then task.wait(0.1) continue end

                local enemyInfo = enemyList.GetEnemyByLevel(level)
                if not enemyInfo then task.wait(0.1) continue end

                local mobFound = nil
                for _, mob in pairs(workspace:GetChildren()) do
                    if mob.Name == enemyInfo.Name and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        mobFound = mob
                        break
                    end
                end

                if mobFound and mobFound ~= currentMob then
                    currentMob = mobFound
                    local targetPos = mobFound.HumanoidRootPart.Position + Vector3.new(0, farmRange, 0)
                    tweenTo(targetPos, 100)
                    equipTool(char)

                    while farming and currentMob and currentMob.Parent and currentMob:FindFirstChild("Humanoid") and currentMob.Humanoid.Health > 0 do
                        local tool = char:FindFirstChild(toolName)
                        if tool and tool:IsA("Tool") then
                            tool:Activate()
                        end
                        task.wait(0.1)
                    end

                    currentMob = nil
                else
                    task.wait(0.1)
                end
            end
        end)
    else
        AutoFarm.Stop()
    end
end

return AutoFarm
