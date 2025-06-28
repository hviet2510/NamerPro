local AutoFarm = {}
local farming = false
local toolName = nil
local attackRange = 15

local function tweenTo(cf)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local ts = game:GetService("TweenService")
        local tween = ts:Create(char.HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = cf})
        tween:Play()
        tween.Completed:Wait()
    end
end

function AutoFarm.Toggle(state, enemyList)
    farming = state
    if state then
        task.spawn(function()
            while farming and task.wait(0.5) do
                local level = game.Players.LocalPlayer.Data.Level.Value
                local target = enemyList.GetByLevel(level)
                if not target then continue end

                local enemy = nil
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == target.name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        enemy = v
                        break
                    end
                end

                if enemy then
                    tweenTo(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -attackRange))
                    local tool = toolName and (game.Players.LocalPlayer.Backpack:FindFirstChild(toolName) or game.Players.LocalPlayer.Character:FindFirstChild(toolName))
                    if tool then
                        tool.Parent = game.Players.LocalPlayer.Character
                        tool:Activate()
                    else
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState(3)
                    end
                else
                    tweenTo(target.cf)
                end
            end
        end)
    end
end

function AutoFarm.SetTool(name)
    toolName = name
end

function AutoFarm.SetRange(r)
    attackRange = r
end

return AutoFarm
