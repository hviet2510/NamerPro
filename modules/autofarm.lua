local AutoFarm = {}
AutoFarm.Active = false
AutoFarm.Range = 15
AutoFarm.Mode = "Bình Thường"
AutoFarm.Tool = nil
AutoFarm.TweenSpeed = 1

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ⚡ Tự động trang bị tool
function AutoFarm.EquipTool()
    if AutoFarm.Tool then
        local backpack = LocalPlayer.Backpack
        local tool = backpack:FindFirstChild(AutoFarm.Tool)
        if tool then
            tool.Parent = Character
        end
    end
end

-- ⚡ Di chuyển mượt
function AutoFarm.TweenTo(pos)
    local hrp = Character:WaitForChild("HumanoidRootPart")
    local tween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - pos).Magnitude / (AutoFarm.TweenSpeed * 50), Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

-- ⚡ Lấy quái theo level
function AutoFarm.GetEnemyByLevel(enemyList, level)
    for _, enemy in pairs(enemyList) do
        if level >= enemy.MinLevel and level <= enemy.MaxLevel then
            return enemy.Name
        end
    end
    return nil
end

-- ⚡ Tấn công quái
function AutoFarm.Attack(target)
    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        AutoFarm.EquipTool()
        local tool = Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Handle") then
            -- Giả lập click (Delta support)
            tool:Activate()
        end
    end
end

-- ⚡ Bắt đầu farm
function AutoFarm.Start(enemyList)
    spawn(function()
        while AutoFarm.Active do
            local level = LocalPlayer.Data.Level.Value
            local enemyName = AutoFarm.GetEnemyByLevel(enemyList, level)
            if enemyName then
                local enemies = workspace.Enemies:GetChildren()
                local target = nil
                for _, mob in pairs(enemies) do
                    if mob.Name == enemyName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        target = mob
                        break
                    end
                end
                if target then
                    AutoFarm.TweenTo(target.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
                    while target and target.Parent and target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0 and AutoFarm.Active do
                        AutoFarm.Attack(target)
                        task.wait(0.2)
                    end
                else
                    warn("[AutoFarm] Không tìm thấy quái phù hợp, chờ spawn...")
                end
            else
                warn("[AutoFarm] Không có quái cho level hiện tại!")
            end
            task.wait(0.5)
        end
    end)
end

function AutoFarm.Toggle(state, enemyList)
    AutoFarm.Active = state
    if state then
        AutoFarm.Start(enemyList)
    end
end

function AutoFarm.SetRange(range)
    AutoFarm.Range = range
end

function AutoFarm.SetMode(mode)
    AutoFarm.Mode = mode
    if mode == "Nhanh" then
        AutoFarm.TweenSpeed = 2
    elseif mode == "An Toàn" then
        AutoFarm.TweenSpeed = 0.8
    else
        AutoFarm.TweenSpeed = 1
    end
end

function AutoFarm.SetTool(toolName)
    AutoFarm.Tool = toolName
end

return AutoFarm
