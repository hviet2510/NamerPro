local AutoFarm = {
    Active = false,
    Range = 10,
    Mode = "Bình Thường",
    Target = nil
}

function AutoFarm.SetRange(range)
    AutoFarm.Range = range
    print("[NamerPro] Khoảng cách tấn công: "..range)
end

function AutoFarm.SetMode(mode)
    AutoFarm.Mode = mode
    print("[NamerPro] Đã chọn mode: "..mode)
end

function AutoFarm.Toggle(state, EnemyList)
    AutoFarm.Active = state
    if state then
        print("[NamerPro] AutoFarm BẬT")
        AutoFarm.Start(EnemyList)
    else
        print("[NamerPro] AutoFarm TẮT")
    end
end

function AutoFarm.Start(EnemyList)
    spawn(function()
        while AutoFarm.Active do
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then
                task.wait(1)
                continue
            end

            if not AutoFarm.Target or AutoFarm.Target:FindFirstChild("Humanoid").Health <= 0 then
                AutoFarm.Target = EnemyList.GetClosestEnemy(char.HumanoidRootPart.Position)
            end

            if AutoFarm.Target and AutoFarm.Target:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(
                    AutoFarm.Target.HumanoidRootPart.Position + Vector3.new(0, 2, AutoFarm.Range)
                )
                game:GetService("VirtualUser"):Button1Down(Vector2.new(), workspace.CurrentCamera.CFrame)
            end

            task.wait(AutoFarm.Mode == "Nhanh" and 0.1 or AutoFarm.Mode == "An Toàn" and 1 or 0.3)
        end
    end)
end

return AutoFarm
