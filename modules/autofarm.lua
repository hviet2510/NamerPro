local AutoFarm = {
    Active = false,
    Range = 10,
    Mode = "Bình Thường",
    ToolName = nil,
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

local enemyList = require(script.Parent.enemylist)

function AutoFarm.SetRange(r) AutoFarm.Range = r end
function AutoFarm.SetMode(m) AutoFarm.Mode = m end
function AutoFarm.SetTool(name) AutoFarm.ToolName = name end

function AutoFarm.EquipTool()
    local tool = lp.Backpack:FindFirstChild(AutoFarm.ToolName) or char:FindFirstChild(AutoFarm.ToolName)
    if not tool then
        tool = lp.Backpack:FindFirstChildOfClass("Tool") or char:FindFirstChildOfClass("Tool")
    end
    if tool then tool.Parent = char end
end

function AutoFarm.TweenTo(pos)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - pos).Magnitude
    local speed = AutoFarm.Mode == "Nhanh" and 150 or AutoFarm.Mode == "An Toàn" and 80 or 100
    local t = TweenService:Create(hrp, TweenInfo.new(dist/speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    t:Play() t.Completed:Wait()
end

function AutoFarm.GetEnemy()
    local lv = lp.leaderstats and lp.leaderstats:FindFirstChild("Level") and lp.leaderstats.Level.Value
    if not lv then return nil end
    for _, e in ipairs(enemyList) do
        if lv >= e.MinLevel and lv <= e.MaxLevel then
            for _, mob in ipairs(workspace.Enemies:GetChildren()) do
                if mob.Name == e.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob, e.Name
                end
            end
        end
    end
end

function AutoFarm.AutoQuest(mobName)
    for _, npc in ipairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc.Name:lower():find("quest") and npc:FindFirstChild("ClickDetector") then
            AutoFarm.TweenTo(npc:GetPivot().Position + Vector3.new(0, 3, 0))
            fireclickdetector(npc.ClickDetector)
            wait(0.3)
            -- Nếu có GUI để chọn quest thì tự xử lý tại đây
            return
        end
    end
end

function AutoFarm.Toggle(state)
    AutoFarm.Active = state
    if state then
        task.spawn(function()
            while AutoFarm.Active do
                char = lp.Character or lp.CharacterAdded:Wait()
                local mob, mobName = AutoFarm.GetEnemy()
                if mob and mob:FindFirstChild("HumanoidRootPart") then
                    AutoFarm.AutoQuest(mobName)
                    AutoFarm.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
                    AutoFarm.EquipTool()
                    while AutoFarm.Active and mob and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
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
