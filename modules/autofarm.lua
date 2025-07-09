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

function AutoFarm.SetRange(r) AutoFarm.Range = r end
function AutoFarm.SetMode(m) AutoFarm.Mode = m end
function AutoFarm.SetTool(t) AutoFarm.ToolName = t end

function AutoFarm.EquipTool()
    local tool = lp.Backpack:FindFirstChild(AutoFarm.ToolName or "") or lp.Backpack:FindFirstChildOfClass("Tool")
    if tool then tool.Parent = char end
end

function AutoFarm.TweenTo(pos)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - pos).Magnitude
    local speed = AutoFarm.Mode == "Nhanh" and 150 or AutoFarm.Mode == "An Toàn" and 80 or 100
    TweenService:Create(hrp, TweenInfo.new(dist / speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
end

function AutoFarm.GetEnemy(enemyList)
    local level = lp:FindFirstChild("leaderstats") and lp.leaderstats:FindFirstChild("Level")
    if not level then return nil end
    for _, e in pairs(enemyList) do
        if level.Value >= e.MinLevel and level.Value <= e.MaxLevel then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == e.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
        end
    end
end

function AutoFarm.Toggle(state, enemyList)
    AutoFarm.Active = state
    if state then
        task.spawn(function()
            while AutoFarm.Active do
                local mob = AutoFarm.GetEnemy(enemyList)
                if mob and mob:FindFirstChild("HumanoidRootPart") then
                    AutoFarm.EquipTool()
                    AutoFarm.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
                    while AutoFarm.Active and mob.Humanoid.Health > 0 do
                        local tool = char:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
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
