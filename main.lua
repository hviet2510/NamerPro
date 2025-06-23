local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "CustomUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Custom UI - Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(0, 120, 1, -35)
TabsFrame.Position = UDim2.new(0, 0, 0, 35)
TabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", TabsFrame).CornerRadius = UDim.new(0, 8)

local TabLayout = Instance.new("UIListLayout", TabsFrame)
TabLayout.Padding = UDim.new(0, 5)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local PagesFrame = Instance.new("Frame", MainFrame)
PagesFrame.Size = UDim2.new(1, -130, 1, -40)
PagesFrame.Position = UDim2.new(0, 130, 0, 40)
PagesFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", PagesFrame).CornerRadius = UDim.new(0, 8)

local Tabs = {}
local function CreateTab(name)
	local TabButton = Instance.new("TextButton", TabsFrame)
	TabButton.Size = UDim2.new(1, -10, 0, 30)
	TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	TabButton.Text = name
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.Font = Enum.Font.Gotham
	TabButton.TextSize = 14
	Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

	local Page = Instance.new("Frame", PagesFrame)
	Page.Size = UDim2.new(1, -10, 1, -10)
	Page.Position = UDim2.new(0, 5, 0, 5)
	Page.BackgroundTransparency = 1
	Page.Visible = false
	local Layout = Instance.new("UIListLayout", Page)
	Layout.Padding = UDim.new(0, 8)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

	TabButton.MouseButton1Click:Connect(function()
		for _, v in pairs(PagesFrame:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		Page.Visible = true
	end)

	Tabs[name] = Page
	return Page
end

local function CreateToggle(page, text, callback)
	local Button = Instance.new("TextButton", page)
	Button.Size = UDim2.new(0, 200, 0, 30)
	Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Button.Text = "[ OFF ] "..text
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.Gotham
	Button.TextSize = 14
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
	local state = false
	Button.MouseButton1Click:Connect(function()
		state = not state
		Button.Text = (state and "[ ON ] " or "[ OFF ] ")..text
		callback(state)
	end)
end

-- Tabs Setup
local FarmTab = CreateTab("Farm Level")
local SettingTab = CreateTab("Setting")
local ConfigTab = CreateTab("Config")
FarmTab.Visible = true

-- AUTO FARM SYSTEM
local Mobs = {
	{1,9,"BanditQuest1","Bandit",CFrame.new(1060,16,1547)},
	{10,14,"BanditQuest2","Monkey",CFrame.new(-1610,35,145)},
	{15,29,"BanditQuest2","Gorilla",CFrame.new(-1320,35,-500)},
	{30,39,"BuggyQuest1","Pirate",CFrame.new(-1115,14,3890)},
	{40,59,"BuggyQuest1","Brute",CFrame.new(-1140,14,4325)},
	{60,74,"BuggyQuest2","Desert Bandit",CFrame.new(896,7,4381)},
	{75,89,"BuggyQuest2","Desert Officer",CFrame.new(1572,10,4373)},
	{90,99,"SnowQuest","Snow Bandit",CFrame.new(1389,87,-1297)},
	{100,119,"SnowQuest","Snowman",CFrame.new(1229,87,-1442)},
	{120,149,"MarineQuest","Chief Petty Officer",CFrame.new(-4739,20,4245)},
	{150,174,"SkyQuest","Sky Bandit",CFrame.new(-4842,717,718)},
	{175,189,"SkyQuest","Dark Master",CFrame.new(-5104,877,-262)},
	{190,209,"PrisonerQuest","Prisoner",CFrame.new(5267,2,866)},
	{210,249,"PrisonerQuest","Dangerous Prisoner",CFrame.new(5017,2,1073)},
	{250,274,"ColosseumQuest","Toga Warrior",CFrame.new(-1820,45,-2748)},
	{275,299,"ColosseumQuest","Gladiator",CFrame.new(-1292,55,-3597)},
	{300,324,"MagmaQuest","Military Soldier",CFrame.new(-5310,80,8513)},
	{325,374,"MagmaQuest","Military Spy",CFrame.new(-5424,78,8469)},
	{375,399,"FishmanQuest","Fishman Warrior",CFrame.new(61122,19,1569)},
	{400,449,"FishmanQuest","Fishman Commando",CFrame.new(61891,19,1474)},
	{450,474,"SkyExp1Quest","God's Guard",CFrame.new(-4681,845,-1912)},
	{475,524,"SkyExp1Quest","Shanda",CFrame.new(-4811,803,-2346)},
	{525,549,"SkyExp2Quest","Royal Squad",CFrame.new(-7895,5636,-1412)},
	{550,624,"SkyExp2Quest","Royal Soldier",CFrame.new(-7870,5636,-1746)},
	{625,649,"FountainQuest","Galley Pirate",CFrame.new(5581,45,3990)},
	{650,700,"FountainQuest","Galley Captain",CFrame.new(5780,45,4442)},
}

local function GetMob()
	local lvl = plr.Data.Level.Value
	for _,m in ipairs(Mobs) do
		if lvl >= m[1] and lvl <= m[2] then return unpack(m) end
	end
end

local function EquipMelee()
	for _,v in ipairs(plr.Backpack:GetChildren()) do
		if v:IsA("Tool") then plr.Character.Humanoid:EquipTool(v) return end
	end
end

local function Stat()
	local unspent = plr.Data.Stats.Melee.Points.Value
	if unspent > 0 then CommF:InvokeServer("AddPoint","Melee",unspent) end
end

local function Attack(mob)
	repeat task.wait()
		if not mob or not mob:FindFirstChild("HumanoidRootPart") then break end
		hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
		EquipMelee()
		for _,tool in ipairs(plr.Backpack:GetChildren()) do
			if tool:IsA("Tool") then
				plr.Character.Humanoid:EquipTool(tool)
				tool:Activate()
			end
		end
	until not mob or mob.Humanoid.Health <= 0
end

local autofarm = false
CreateToggle(FarmTab,"Auto Farm Level",function(bool)
	autofarm = bool
	if bool then
		task.spawn(function()
			while autofarm and task.wait() do
				pcall(function()
					local min,max,quest,mobname,pos = GetMob()
					if not quest then return end
					CommF:InvokeServer("StartQuest",quest,1)
					hrp.CFrame = pos + Vector3.new(0,20,0)
					EquipMelee()
					for _,mob in ipairs(workspace.Enemies:GetChildren()) do
						if mob.Name == mobname and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
							Attack(mob)
						end
					end
					Stat()
				end)
			end
		end)
	end
end)
