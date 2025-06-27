local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local AutoFarm = {}
AutoFarm.Enabled = false
AutoFarm.Delay = 1
AutoFarm.ToolName = nil

function AutoFarm.TweenTo(pos)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local distance = (hrp.Position - pos).Magnitude
    local tweenTime = distance / 100
    local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {Position = pos})
    tween:Play()
    tween.Completed:Wait()
end

function AutoFarm.GetTool()
    local backpack = player:WaitForChild("Backpack")
    local char = player.Character
    if AutoFarm.ToolName then
        -- Ưu tiên tool đã chọn
        local tool = backpack:FindFirstChild(AutoFarm.ToolName) or (char and char:FindFirstChild(AutoFarm.ToolName))
        if tool then
            if tool.Parent == backpack then
                tool.Parent = char
            end
            return tool
        end
    end
    -- Nếu không có tool chọn, lấy tool bất kỳ
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = char
            return tool
        end
    end
    return nil
end

function AutoFarm.Start(enemyList)
    AutoFarm.Enabled = true
    task.spawn(function()
        while AutoFarm.Enabled do
            local level = player.Data.Level.Value
            local enemyInfo = enemyList.GetEnemyByLevel(level)
            if enemyInfo then
                AutoFarm.TweenTo(enemyInfo.Position + Vector3.new(0, 5, 0))
                local target
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name == enemyInfo.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        target = mob
                        break
                    end
                end

                if target then
                    local tool = AutoFarm.GetTool()
                    if not tool then warn("[NamerPro] Không tìm thấy tool!") break end

                    repeat
                        if tool:FindFirstChild("RemoteEvent") then
                            tool.RemoteEvent:FireServer()
                        else
                            tool:Activate()
                        end
                        task.wait(AutoFarm.Delay)
                    until not target.Parent or target.Humanoid.Health <= 0 or not AutoFarm.Enabled
                end
            end
            task.wait(0.5)
        end
    end)
end

function AutoFarm.Toggle(state)
    AutoFarm.Enabled = state
end

function AutoFarm.SetDelay(sec)
    AutoFarm.Delay = sec
end

function AutoFarm.SetTool(name)
    AutoFarm.ToolName = name
    print("[NamerPro] Đã chọn tool: "..tostring(name))
end

return AutoFarm
