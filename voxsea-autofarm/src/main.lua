--// Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local localPlayer = Players.LocalPlayer

--// Notify function
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 3;
    })
end

--// Hàm tạo kiếm vĩnh viễn (dao Rambo)
local function createSword()
    if localPlayer.Backpack:FindFirstChild("CoolSword") or (localPlayer.Character and localPlayer.Character:FindFirstChild("CoolSword")) then
        return
    end

    local sword = Instance.new("Tool")
    sword.RequiresHandle = true
    sword.Name = "CoolSword"
    sword.Parent = localPlayer.Backpack

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 4, 1)
    handle.CanCollide = false
    handle.Parent = sword

    local mesh = Instance.new("SpecialMesh", handle)
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://121946387" -- Rambo Knife mesh
    mesh.TextureId = "rbxassetid://121946383" -- Rambo Knife texture
    mesh.Scale = Vector3.new(1.5, 1.5, 1.5)

    -- Damage lên NPC
    handle.Touched:Connect(function(otherPart)
        local npc = otherPart.Parent
        if npc and npc:FindFirstChild("Humanoid") and npc.Name == "EnemyNPC" then
            npc.Humanoid:TakeDamage(20)
            Notify("Đã đánh trúng!", "NPC còn "..math.floor(npc.Humanoid.Health).." máu", 2)
        end
    end)
end

-- Tạo kiếm khi chạy script
createSword()
-- Tạo lại khi respawn
localPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    createSword()
end)

--// UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FarmUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 120)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true
Frame.Visible = true

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)

local spawnBtn = Instance.new("TextButton", Frame)
spawnBtn.Text = "🐲 Spawn Mobs"
spawnBtn.Size = UDim2.new(1, -10, 0, 40)
spawnBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local farmBtn = Instance.new("TextButton", Frame)
farmBtn.Text = "⚔️ Toggle Auto Farm"
farmBtn.Size = UDim2.new(1, -10, 0, 40)
farmBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
farmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Nút nhỏ toggle UI (mobile)
local toggleBtn = Instance.new("TextButton", ScreenGui)
toggleBtn.Text = "📂"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.9, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

toggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

--// NPC Spawner (Zombie Roblox cổ điển)
local spawnPositions = {}
local function createNPC(pos)
    local npc = Instance.new("Model", workspace)
    npc.Name = "EnemyNPC"

    local hum = Instance.new("Humanoid")
    hum.Health = 100
    hum.MaxHealth = 100
    hum.Parent = npc

    -- Torso
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Position = pos
    torso.Anchored = false
    torso.Parent = npc
    npc.PrimaryPart = torso

    -- Head
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1, 1)
    head.Position = torso.Position + Vector3.new(0, 2, 0)
    head.Anchored = false
    head.Parent = npc

    -- Face zombie
    local face = Instance.new("Decal", head)
    face.Texture = "rbxassetid://7074130" -- mặt zombie

    -- Shirt + Pants (áo nâu + quần xanh zombie)
    local shirt = Instance.new("Shirt", npc)
    shirt.ShirtTemplate = "rbxassetid://7074141"

    local pants = Instance.new("Pants", npc)
    pants.PantsTemplate = "rbxassetid://7074121"

    -- AI đơn giản
    task.spawn(function()
        while npc.Parent and hum.Health > 0 do
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                hum:MoveTo(localPlayer.Character.HumanoidRootPart.Position)
            end
            task.wait(1)
        end
    end)

    -- Respawn khi chết
    hum.Died:Connect(function()
        task.wait(3)
        createNPC(pos)
    end)

    return npc
end

spawnBtn.MouseButton1Click:Connect(function()
    if not localPlayer.Character then return end
    local basePos = localPlayer.Character.Head.Position
    local offsets = {
        Vector3.new(10,0,0),
        Vector3.new(-10,0,0),
        Vector3.new(0,0,10),
        Vector3.new(0,0,-10),
        Vector3.new(15,0,15),
    }
    spawnPositions = {}
    for _,offset in ipairs(offsets) do
        table.insert(spawnPositions, basePos + offset)
        createNPC(basePos + offset)
    end
    Notify("Spawn NPC", "Đã tạo Zombie quanh bạn!", 3)
end)

--// Auto Farm
local farming = false

local function getClosestNPC()
    local closest, dist = nil, math.huge
    for _,npc in pairs(workspace:GetChildren()) do
        if npc:IsA("Model") and npc.Name == "EnemyNPC" and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            local npcRoot = npc.PrimaryPart
            if npcRoot and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local mag = (npcRoot.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                if mag < dist then
                    closest = npc
                    dist = mag
                end
            end
        end
    end
    return closest
end

farmBtn.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        Notify("Auto Farm", "⚔️ Đang bật Auto Farm", 3)
        createSword()
        task.spawn(function()
            while farming and task.wait(1) do
                local char = localPlayer.Character
                if not char or not char:FindFirstChild("Humanoid") then continue end
                local hum = char.Humanoid
                local npc = getClosestNPC()
                if npc and npc.PrimaryPart then
                    hum:MoveTo(npc.PrimaryPart.Position)
                    local dist = (npc.PrimaryPart.Position - char.HumanoidRootPart.Position).Magnitude
                    if dist < 5 then
                        local sword = char:FindFirstChild("CoolSword")
                        if sword then sword:Activate() end
                    end
                end
            end
        end)
    else
        Notify("Auto Farm", "⛔ Đã tắt Auto Farm", 3)
    end
end)
