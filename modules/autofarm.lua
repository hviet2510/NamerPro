local AutoFarm = {
    Active = false,
    Range = 10,
    Mode = "Bình Thường",
    ToolName = nil
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

-- Thiết lập nhân vật an toàn
local function getCharacter()
    return lp.Character or lp.CharacterAdded:Wait()
end

function AutoFarm.SetRange(range)
    AutoFarm.Range = tonumber(range) or 10
end

function AutoFarm.SetMode(mode)
    AutoFarm.Mode = mode or "Bình Thường"
end

function AutoFarm.SetTool(toolName)
    AutoFarm.ToolName = toolName
end

function AutoFarm.EquipTool()
    local char = getCharacter()
    local tool = AutoFarm.ToolName and (char:FindFirstChild(AutoFarm.ToolName) or lp.Backpack:FindFirstChild(AutoFarm.ToolName))
        or lp.Backpack:FindFirstChildOfClass("Tool")

    if tool then
        tool.Parent = char
    end
end

function AutoFarm.TweenTo(pos)
    local hrp = getCharacter():FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local dist = (hrp.Position - pos).Magnitude
    local speed = (AutoFarm.Mode == "Nhanh" and 150) or (AutoFarm.Mode == "An Toàn" and 80) or 100
    local time = dist / speed

    local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

-- Tìm enemy phù hợp với level
function AutoFarm.GetEnemy(enemyList)
    if not enemyList then return nil end
    local stats = lp:FindFirstChild("leaderstats")
    local level = stats and stats:FindFirstChild("Level") and stats.Level.Value
    if not level then
        warn("[AutoFarm] Không tìm thấy Level hoặc leaderstats!")
        return nil
    end

    for _, enemy in ipairs(enemyList) do
        if level >= enemy.MinLevel and level <= enemy.MaxLevel then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == enemy.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
        end
    end
    return nil
end

-- Tự động nhận nhiệm vụ
function AutoFarm.AutoQuest(mobName)
    local npc = workspace:FindFirstChild("QuestNPC")
    if npc and npc:FindFirstChild("ClickDetector") and not lp.PlayerGui:FindFirstChild("QuestFrame") then
        AutoFarm.TweenTo(npc.Position + Vector3.new(0, 3, 0))
        fireclickdetector(npc.ClickDetector)
        task.wait(0.5)
        print("[AutoFarm] Đã nhận nhiệm vụ cho: " .. mobName)
    end
end

-- Bật/tắt Auto Farm
function AutoFarm.Toggle(state, enemyList)
    AutoFarm.Active = state
    if not state then return end

    task.spawn(function()
        while AutoFarm.Active do
            local mob = AutoFarm.GetEnemy(enemyList)
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                AutoFarm.AutoQuest(mob.Name)
                AutoFarm.TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
                AutoFarm.EquipTool()

                while AutoFarm.Active and mob.Parent and mob.Humanoid.Health > 0 do
                    local tool = getCharacter():FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                    task.wait(0.2)
                end
            else
                task.wait(0.5)
            end
        end
    end)
end

return AutoFarm
