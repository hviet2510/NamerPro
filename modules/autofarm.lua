local AutoFarm = {
    Active = false,
    Range = 10,
    Mode = "Bình Thường",
    ToolName = nil
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

function AutoFarm.SetRange(range)
    AutoFarm.Range = range
end

function AutoFarm.SetMode(mode)
    AutoFarm.Mode = mode
end

function AutoFarm.SetTool(toolName)
    AutoFarm.ToolName = toolName
end

function AutoFarm.EquipTool()
    local bp = lp.Backpack
    if AutoFarm.ToolName then
        local tool = char:FindFirstChild(AutoFarm.ToolName) or bp:FindFirstChild(AutoFarm.ToolName)
        if tool then
            tool.Parent = char
        end
    else
        local tool = bp:FindFirstChildOfClass("Tool")
        if tool then
            tool.Parent = char
        end
    end
end

function AutoFarm.TweenTo(pos)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - pos).Magnitude
        local speed = 100
        if AutoFarm.Mode == "Nhanh" then speed = 150 end
        if AutoFarm.Mode == "An Toàn" then speed = 80 end
        local time = dist / speed
        local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

function AutoFarm.GetEnemy(enemyList)
    local lv = lp.leaderstats and lp.leaderstats.Level and lp.leaderstats.Level.Value
    if not lv then return nil end
    for _, e in pairs(enemyList) do
        if lv >= e.MinLevel and lv <= e.MaxLevel then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == e.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
        end
    end
    return nil
end

function AutoFarm.AutoQuest(mobName)
    local npc = workspace:FindFirstChild("QuestNPC")
    if npc and (not lp.PlayerGui:FindFirstChild("QuestFrame")) then
        AutoFarm.TweenTo(npc.Position + Vector3.new(0, 3, 0))
        fireclickdetector(npc.ClickDetector)
        task.wait(0.5)
        -- Giả lập chọn quest (tùy game)
    end
end

function AutoFarm.Toggle(state, enemyList)
    AutoFarm.Active = state
    if state then
        task.spawn(function()
            while AutoFarm.Active do
                local mob = AutoFarm.GetEnemy(enemyList)
                if mob and mob:FindFirstChild("HumanoidRootPart") then
                    AutoFarm.AutoQuest(mob.Name)
                    AutoFarm.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
                    AutoFarm.EquipTool()
                    while AutoFarm.Active and mob.Parent and mob.Humanoid.Health > 0 do
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                        task.wait(0.2)
                    end
                else
                    task.wait(0.5)
                end
            end
        end)
    end
end

return AutoFarm
