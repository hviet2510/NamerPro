local AutoFarm = { Active = false, Range = 10, Mode = "Bình Thường", ToolName = nil }
local TweenService = game:GetService("TweenService")
local lp = game.Players.LocalPlayer

function AutoFarm.SetRange(r) AutoFarm.Range = r end
function AutoFarm.SetMode(m) AutoFarm.Mode = m end

function AutoFarm.TweenTo(pos)
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - pos).Magnitude
        local spd = AutoFarm.Mode == "Nhanh" and 150 or (AutoFarm.Mode == "An Toàn" and 80 or 100)
        local t = TweenService:Create(hrp, TweenInfo.new(dist/spd, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        t:Play() t.Completed:Wait()
    end
end

function AutoFarm.EquipTool()
    local char = lp.Character
    local bp = lp.Backpack
    local tool = char and char:FindFirstChildOfClass("Tool") or bp and bp:FindFirstChildOfClass("Tool")
    if tool then tool.Parent = char end
end

function AutoFarm.GetTarget(list)
    local lv = lp.leaderstats and lp.leaderstats:FindFirstChild("Level") and lp.leaderstats.Level.Value
    for _, e in pairs(list) do
        if lv and lv >= e.MinLevel and lv <= e.MaxLevel then
            for _, m in pairs(workspace.Enemies:GetChildren()) do
                if m.Name == e.Name and m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0 then
                    return m
                end
            end
        end
    end
end

function AutoFarm.Toggle(state, list)
    AutoFarm.Active = state
    if state then
        task.spawn(function()
            while AutoFarm.Active do
                local mob = AutoFarm.GetTarget(list)
                if mob then
                    AutoFarm.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0,0,AutoFarm.Range))
                    AutoFarm.EquipTool()
                    while mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and AutoFarm.Active do
                        local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
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
