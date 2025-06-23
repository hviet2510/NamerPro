-- ⚙️ Blox Fruits Auto Farm Sea 1 FULL - Đã fix giật + Bring Mob + Đánh Xa + Fast Attack Safe
local Players, ReplicatedStorage, TweenService = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
local player, UIS = Players.LocalPlayer, game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()

local PlayerGui = player:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "BloxAutoFarmUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "⚙️ Auto Farm Blox Fruits Sea 1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- Toggle System
local function CreateToggle(text, posY, callback)
	local btn = Instance.new("TextButton", MainFrame)
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local state = false
	btn.Text = text .. ": OFF"

	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

local AutoFarm, AutoStats = false, false
CreateToggle("Auto Farm", 50, function(v) AutoFarm = v end)
CreateToggle("Auto Stats (Melee)", 90, function(v) AutoStats = v end)

-- Toggle Button
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(1, -50, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Text = "📂"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ✅ Enemy List gọn Sea 1 (Lv 1-700)
local EnemyList = {
	{Level = 1, Name = "Bandit", Quest = "BanditQuest1", Mob = "Bandit", Pos = Vector3.new(1058,16,1548)},
	{Level = 10, Name = "Monkey", Quest = "JungleQuest", Mob = "Monkey", Pos = Vector3.new(-1599,37,153)},
	{Level = 15, Name = "Gorilla", Quest = "JungleQuest", Mob = "Gorilla", Pos = Vector3.new(-1238,6,-486)},
	{Level = 20, Name = "Pirate", Quest = "BuggyQuest1", Mob = "Pirate", Pos = Vector3.new(-1116,14,3938)},
	{Level = 30, Name = "Brute", Quest = "BuggyQuest1", Mob = "Brute", Pos = Vector3.new(-1140,14,4305)},
	{Level = 40, Name = "Desert Bandit", Quest = "DesertQuest", Mob = "Desert Bandit", Pos = Vector3.new(932,7,4486)},
	{Level = 60, Name = "Snow Bandit", Quest = "SnowQuest", Mob = "Snow Bandit", Pos = Vector3.new(1289,150,-1215)},
	{Level = 75, Name = "Snowman", Quest = "SnowQuest", Mob = "Snowman", Pos = Vector3.new(1362,170,-1455)},
	{Level = 90, Name = "Chief Petty Officer", Quest = "MarineQuest2", Mob = "Chief Petty Officer", Pos = Vector3.new(-4855,20,4308)},
	{Level = 100, Name = "Sky Bandit", Quest = "SkyQuest", Mob = "Sky Bandit", Pos = Vector3.new(-4951,295,-2893)},
	{Level = 125, Name = "Dark Master", Quest = "SkyQuest", Mob = "Dark Master", Pos = Vector3.new(-5251,389,-2272)},
	{Level = 150, Name = "Prisoner", Quest = "PrisonerQuest", Mob = "Prisoner", Pos = Vector3.new(5049,75,474)},
	{Level = 175, Name = "Dangerous Prisoner", Quest = "PrisonerQuest", Mob = "Dangerous Prisoner", Pos = Vector3.new(5096,75,776)},
	{Level = 190, Name = "Toga Warrior", Quest = "ColosseumQuest", Mob = "Toga Warrior", Pos = Vector3.new(-1753,7,-2743)},
	{Level = 225, Name = "Galley Pirate", Quest = "FountainQuest", Mob = "Galley Pirate", Pos = Vector3.new(5589,45,4006)},
	{Level = 275, Name = "Galley Captain", Quest = "FountainQuest", Mob = "Galley Captain", Pos = Vector3.new(5589,45,4006)}
}

-- ⚙️ Auto Farm Functions
local function GetQuestData()
	for i = #EnemyList, 1, -1 do
		local d = EnemyList[i]
		if player.Data.Level.Value >= d.Level then return d end
	end
end

local function BringMob()
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
			mob.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -3, -5)
			mob.HumanoidRootPart.Anchored = true
		end
	end
end

local function AttackMob()
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
			pcall(function()
				ReplicatedStorage.Remotes.Combat:FireServer(mob)
			end)
		end
	end
end

-- ✅ Auto Stats Up
task.spawn(function()
	while task.wait(1) do
		if AutoStats then
			pcall(function()
				ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
			end)
		end
	end
end)

-- ✅ Auto Farm
task.spawn(function()
	while task.wait(0.1) do
		if AutoFarm then
			local data = GetQuestData()
			if data then
				pcall(function()
					ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", data.Quest, 1)
					character.HumanoidRootPart.CFrame = CFrame.new(data.Pos + Vector3.new(0, 30, 0))
				end)

				BringMob()

				for _ = 1, 5 do
					AttackMob()
					task.wait(0.05)
				end
			end
		end
	end
end)

print("✅ FULL AUTO FARM | FIX GIẬT | BRING MOB | FAST ATTACK | UI GỌN")
