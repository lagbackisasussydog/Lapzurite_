getgenv().Configuration = {
	["Tool"] = "Melee",
	["TweenSpeed"] = 250,
	["CurrentPlace"] = "",
	["CurrentTweeningProcess"] = nil,
	["Modules"] = {
		["AutoFarmLevel"] = false,
		["AutoFarmChests"] = false,
		["CompleteRaid"] = false,
		["AutoKatakuri"] = false,
		["AutoBone"] = false
	},
}

getgenv().ModuleSetting = {
	["AutoFarmLevel"] = {
		["State"] = {
			["QuestTaken"] = false
		}
	},
	["AutoFarmChests"] = {
		["Delay"] = .5,
		["Method"] = "Tween",
	},
	["Raid"] = {
		["RaidType"] = ""
	},
	["Travel"] = {
		["Destination"] = nil
	}
}

getgenv().ModuleManager = {
    Modules = {},
    Threads = {}
}

local Manager = getgenv().ModuleManager

function Manager:Register(name, startFunc, stopFunc)
    self.Modules[name] = {
        Start = startFunc,
        Stop = stopFunc,
        Enabled = false
    }
end

function Manager:Start(name)
    local mod = self.Modules[name]
    if not mod then return end
    if mod.Enabled then return end

    mod.Enabled = true

    if self.Threads[name] then
        task.cancel(self.Threads[name])
    end

    self.Threads[name] = task.spawn(function()
        mod.Start()
    end)
end

function Manager:Stop(name)
    local mod = self.Modules[name]
    if not mod then return end

    mod.Enabled = false

    if self.Threads[name] then
        task.cancel(self.Threads[name])
        self.Threads[name] = nil
    end

    if mod.Stop then
        mod.Stop()
    end
end

function Manager:RestartAll()
    for name, mod in pairs(self.Modules) do
        if mod.Enabled then
            self:Stop(name)
            task.wait()
            self:Start(name)
        end
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Plr = game.Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()

local HitRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
local AttackRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
local CommF_ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")

local function getChar()
	return Plr.Character or Plr.CharacterAdded:Wait()
end

local function Anchor(Char, State)
	if State and Char.PrimaryPart:FindFirstChild("f") == nil then
		local f = Instance.new("BodyVelocity")
		f.Name = "f"
		f.P = 15000
		f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		f.Velocity = Vector3.new(0,.01,0)
		f.Parent = Char.PrimaryPart
	else
		local bv = Char.PrimaryPart:FindFirstChild("f")
		if bv then
			bv:Destroy()
		end
	end
		
	for _,part in pairs(Char:GetChildren()) do
		if part:IsA("BasePart") then
			part.CanCollide = State
		end
	end
end

local function Tween(Inst, Info,Properties)
    local TweenSvc = game:GetService("TweenService")
    local Track = TweenSvc:Create(Inst, Info, Properties)
	getgenv().Configuration.CurrentTweeningProcess = Track
    Track:Play()
    Track.Completed:Wait()
end

local function Pause()
	local Track = getgenv().Configuration.CurrentTweeningProcess
	if Track and Track.PlaybackState == Enum.PlaybackState.Playing then
		Track:Pause()
		getgenv().Configuration.CurrentTweeningProcess = nil
	end
end

local function getTool()
	for _, v in pairs(Plr.Backpack:GetChildren()) do
		if v.ToolTip == getgenv().Configuration.Tool then
			return v
		end
	end
end

local function FireHitRemote(enemy, tool,character)
    local args = {
        enemy.Head,
        {},
		""
    }
    
    local success, err = pcall(function()
		if character then
			character:SetPrimaryPartCFrame(enemy.PrimaryPart.CFrame * CFrame.new(0,15,0))
			AttackRemote:FireServer("0")
			HitRemote:FireServer(unpack(args))
		end
    end)
    
    if not success then
        warn("Failed to fire HitRemote:", err)
    end
end

function AutoFarmChests()
	local FirstSeasChests = {
		CFrame.new(1147.56067, 19.7403679, 1260.95337),
		CFrame.new(958.973572, 16.3185673, 1339.90894),
		CFrame.new(-781.18103, 31.5049992, 1606.97498),
		CFrame.new(-1203.08105, 0.504998803, 1871.54602),
		CFrame.new(-387.940002, 0.504998803, 1648.08801),
		CFrame.new(-654.679993, 5.70499563, 1421.47595),
		CFrame.new(-1439.12097, 79.9300079, -2955.59692),
		CFrame.new(-1580.61804, 109.108002, -3333.73804),
		CFrame.new(-1832.09204, 79.1240082, -3054.45605),
		CFrame.new(958.301025390625, 14.088006973266602, 1339.7459716796875),
		CFrame.new(-2528.717041015625, 4.754006862640381, 1979.2020263671875),
		CFrame.new(-2878.488037109375, 22.342004776000977, 2303.76904296875),
		CFrame.new(-2956.06005859375, 38.86699676513672, 2025.4139404296875),
		CFrame.new(-3117.447021484375, 207.114013671875, 2048.069091796875),
		CFrame.new(831.8980102539062, 4.290994167327881, 4365.78515625),
		CFrame.new(908.260986328125, 13.142007827758789, 4567.93798828125),
		CFrame.new(1239.9959716796875, 13.590997695922852, 4525.865234375),
		CFrame.new(1456.1094970703125, -0.02189837396144867, 4384.60888671875),
		CFrame.new(-2834.1220703125, 5.415002346038818, 5484.5830078125),
		CFrame.new(1201.71179, 45.369545, -1253.7146),
		CFrame.new(-387.94000244140625, 0.5049988031387329, 1648.0880126953125),
		CFrame.new(-1609.35888671875, 9.904001235961914, 146.10513305664062),
		CFrame.new(-1177.26904296875, 9.704004287719727, 131.5749969482422),
		CFrame.new(-1128.869140625, 38.334007263183594, -526.4371337890625),
		CFrame.new(-1665.70703125, 20.704004287719727, 329.9750061035156),
		CFrame.new(1202.2469482421875, 43.178001403808594, -1252.6099853515625),
		CFrame.new(1409.10498046875, 53.178001403808594, -1272.404052734375),
	}
	
	local SecondSeasChests = {
		CFrame.new(-5238.79931640625, 111.73799133300781, -6258.2392578125),
		CFrame.new(-2387.873046875, 71.1729965209961, -2869.718994140625),
		CFrame.new(-2630.079345703125, 70.76406860351562, -3966.360107421875),
		CFrame.new(-2303.556884765625, 71.8030014038086, -4264.97607421875),
		CFrame.new(-1701.342041015625, 71.1729965209961, -3088.489990234375),
		CFrame.new(-1545.5491943359375, 174.45362854003906, -3651.255859375),
		CFrame.new(-1477.1859130859375, 40.88534164428711, -3897.052978515625),
		CFrame.new(-413.65069580078125, 13.964944839477539, 258.1788330078125),
		CFrame.new(-411.2218017578125, 70.9229507446289, 371.271484375),
		CFrame.new(-353.50390625, 70.9229507446289, 371.27154541015625),
		CFrame.new(-894.0555419921875, 184.81260681152344, 658.243896484375),
		CFrame.new(-134.7222900390625, 70.8125991821289, 355.7315368652344),
		CFrame.new(-511.9065856933594, 329.7139587402344, 588.4630126953125),
		CFrame.new(-1014.435302734375, 70.8125991821289, 850.7462768554688),
		CFrame.new(-1070.09130859375, 120.7647476196289, 857.2682495117188)
	}
	

	Anchor(Char, getgenv().Configuration.Modules.AutoFarmChests)
	while getgenv().Configuration.Modules.AutoFarmChests do
		Char = getChar()
		local root = Char.PrimaryPart
		if not root then task.wait() continue end
		
		local chestList
		if getgenv().Configuration.CurrentPlace == "First-Seas" then
			chestList = FirstSeasChests
		elseif getgenv().Configuration.CurrentPlace == "Second-Seas" then
			chestList = SecondSeasChests
		end
		
		if chestList then
			for _, chest in pairs(chestList) do
				if not getgenv().Configuration.Modules.AutoFarmChests then break end
				
				local speed = math.max(getgenv().Configuration.TweenSpeed, 1)
				local time = (chest.Position - root.Position).Magnitude / speed
				
				Tween(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = chest})
				task.wait(getgenv().ModuleSetting.AutoFarmChests.Delay)
			end
		end
		
		task.wait()
	end
end

local function CompleteRaid()
	local Enemies = workspace.Enemies
	MobList = {
		"Sorcerer",
		"Bone Breaker",
		"Shocker",
		"Bladesmith",
		"Flame User",
		"Flame Master"
	}

	local function Attack(Character, Enemy)
		if not Enemy or not Enemy:FindFirstChild("HumanoidRootPart") then return end

		local EnemyHumanoid = Enemy:FindFirstChild("Humanoid")
		local EnemyRootPart = Enemy:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChild("Humanoid")

		if not EnemyHumanoid or not Humanoid then return end

		local TargetCFrame = EnemyRootPart.CFrame * CFrame.new(0, 15, 0)
		local TweenDuration = Plr:DistanceFromCharacter(EnemyRootPart.Position) / getgenv().Configuration.TweenSpeed

		Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
		
		while Humanoid and EnemyHumanoid and EnemyHumanoid.Health > 0 do
			Humanoid:EquipTool(getTool())
			FireHitRemote(Enemy, getTool(),Character)
			task.wait(.1)
		end
	end
	
	local function IslandCheck()
		local Notifications = game:GetService("Players").LocalPlayer.PlayerGui.Notifications
		
		for _, v in pairs(Notifications:GetChildren()) do
			if v:IsA("TextLabel") and v.Name == "NotificationTemplate" then
				if string.find(v.Text, "Island #1 cleared!") then
					return 1
				elseif string.find(v.Text, "Island #2 cleared!") then
					return 2
				elseif string.find(v.Text, "Island #3 cleared!") then
					return 3
				elseif string.find(v.Text, "Island #4 cleared!") then
					return 4
				elseif string.find(v.Text, "Island #5 cleared!") then
					return 1
				end
			end
		end
	end
	
	Anchor(Char, getgenv().Configuration.Modules.CompleteRaid)
	local loop_thread = task.spawn(function()
		while Char.Humanoid.Health > 0 and getgenv().Configuration.Modules.CompleteRaid and (getgenv().Configuration.CurrentPlace == "Second-Seas" or getgenv().Configuration.CurrentPlace == "Third-Seas") do
			local rType = getgenv().ModuleSetting.Raid.RaidType
			local islandPosition
			local island = IslandCheck()

			if not Char or not Char.PrimaryPart then
				task.wait(10)
				continue
			end

			if rType == "Flame" then
				MobList = {
					"Sorcerer",
					"Bone Breaker",
					"Shocker",
					"Bladesmith",
					"Flame User",
					"Flame Master"
				}
				
				Tween(Char.PrimaryPart, TweenInfo.new((islandPosition[island].Position - Char.PrimaryPart.Position).Magnitude / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = islandPosition[1] * CFrame.new(0,15,0)})
			end

			for _, Inst in pairs(Enemies:GetChildren()) do
				local hum = Inst:FindFirstChild("Humanoid")

				local i = table.find(MobList, Inst.Name)
				if hum and hum.Health > 0 and i and Plr:DistanceFromCharacter(Inst.PrimaryPart.Position) < 150 then
					Attack(Char, Inst)
					task.wait(.1)
				end
			end
			task.wait()
		end
	end)
end

function AutoKatakuriFunc()
	local function Attack(Character, Enemy)
		if not Enemy or not Enemy:FindFirstChild("HumanoidRootPart") then return end

		local EnemyHumanoid = Enemy:FindFirstChild("Humanoid")
		local EnemyRootPart = Enemy:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChild("Humanoid")

		if not EnemyHumanoid or not Humanoid then return end

		local TargetCFrame = EnemyRootPart.CFrame * CFrame.new(0, 15, 0)
		local TweenDuration = Plr:DistanceFromCharacter(EnemyRootPart.Position) / getgenv().Configuration.TweenSpeed

		Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
		
		while Humanoid and EnemyHumanoid and EnemyHumanoid.Health > 0 do
			Humanoid:EquipTool(getTool())
			FireHitRemote(Enemy, getTool(),Character)
			task.wait(.1)
		end
	end
	
	local function MessageCheck()
		local Notifications = game:GetService("Players").LocalPlayer.PlayerGui.Notifications
		
		for _, v in pairs(Notifications:GetChildren()) do
			if v:IsA("TextLabel") and v.Name == "NotificationTemplate" then
				if string.find(v.Text, "A Dimension has spawned") then
					return {true, "Cake Prince"}
				elseif string.find(v.Text, "A Dimension worthy of a god has spawned") then
					return {true, "Dough King"}
				end
				return {false, ""}
			end
		end
	end

	local MobList = {
		"Cookie Crafter",
		"Cake Guard",
		"Baking Staff",
		"Head Baker"
	}
	
	local StartCF = CFrame.new(-2130.8335, 70.0277176, -12251.1934)
	
	local Enemies = workspace.Enemies
	local Char = getChar()

	Anchor(Char, getgenv().Configuration.Modules.AutoKatakuri)
	local loop_thread = task.spawn(function()
		Tween(Char.PrimaryPart, TweenInfo.new(Plr:DistanceFromCharacter(Vector3.new(-2130.8335, 70.0277176, -12251.1934)) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(-2130.8335, 70.0277176, -12251.1934)})
		task.wait(5)
		while Char and Char.Humanoid and Char.Humanoid.Health > 0 and getgenv().Configuration.Modules.AutoKatakuri and getgenv().Configuration.CurrentPlace == "Third-Seas" do
			for _, Inst in pairs(Enemies:GetChildren()) do
				local hum = Inst:FindFirstChild("Humanoid")
				local check = MessageCheck()
				local i = table.find(MobList, Inst.Name)
				
				--[[
				if check[1] == true then
					Tween(Char.PrimaryPart, TweenInfo.new(Plr:DistanceFromCharacter(portal.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new({portal.Position})})
					task.wait(5)
					Attack(Char, Enemies:FindFirstChild(check[2]))
					Character.Humanoid.Health = 0
				end
				]]--
				if hum and hum.Health > 0 and i and Plr:DistanceFromCharacter(Inst.PrimaryPart.Position) < 150 then
					Attack(Char, Inst)
					task.wait(.1)
				end
			end
			task.wait()
		end
	end)
end

function AutoBoneFunc()
	local StartPos = CFrame.new(9521.92676, 172.149506, 6144.80225)

	local function Anchor(Char)
		if getgenv().Configuration.Modules.AutoBone and Char.PrimaryPart:FindFirstChild("f") == nil then
			local f = Instance.new("BodyVelocity")
			f.Name = "f"
			f.P = 15000
			f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			f.Velocity = Vector3.new(0,.01,0)
			f.Parent = Char.PrimaryPart
		else
			local bv = Char.PrimaryPart:FindFirstChild("f")
			if bv then
				bv:Destroy()
			end
		end
		
		for _,part in pairs(Char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = getgenv().Configuration.Modules.AutoBone
			end
		end
	end

	local function Attack(Character, Enemy)
		if not Enemy or not Enemy:FindFirstChild("HumanoidRootPart") then return end

		local EnemyHumanoid = Enemy:FindFirstChild("Humanoid")
		local EnemyRootPart = Enemy:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChild("Humanoid")

		if not EnemyHumanoid or not Humanoid then return end

		local TargetCFrame = EnemyRootPart.CFrame * CFrame.new(0, 15, 0)
		local TweenDuration = Plr:DistanceFromCharacter(EnemyRootPart.Position) / getgenv().Configuration.TweenSpeed

		Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
		
		while Humanoid and EnemyHumanoid and EnemyHumanoid.Health > 0 do
			Humanoid:EquipTool(getTool())
			FireHitRemote(Enemy, getTool(),Character)
			task.wait(.1)
		end
	end

	local MobList = {
		"Reborn Skeleton",
		"Posessed Mummy",
		"Living Zombie",
		"Demonic Soul"
	}

	local loop_thread = task.spawn(function()
		Tween(Char.PrimaryPart, TweenInfo.new(Plr:DistanceFromCharacter(StartPos.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = StartPos})
		task.wait(5)
		while Char and Char.Humanoid and Char.Humanoid.Health > 0 and getgenv().Configuration.Modules.AutoBone and getgenv().Configuration.CurrentPlace == "Third-Seas" do
			for _, Inst in pairs(workspace.Enemies:GetChildren()) do
				local hum = Inst:FindFirstChild("Humanoid")
				local i = table.find(MobList, Inst.Name)
				
				if hum and hum.Health > 0 and i and Plr:DistanceFromCharacter(Inst.PrimaryPart.Position) < 150 then
					Attack(Char, Inst)
					task.wait(.1)
				end
			end
			task.wait()
		end
	end)
end

function startThread(thread, func)
	if getgenv().Threads[thread] then
		task.cancel(getgenv().Threads[thread])
		getgenv().Threads[thread] = nil
	end

	getgenv().Threads[thread] = task.spawn(func) 
end

function closeThread(thread)
	if getgenv().Threads[thread] then
		task.cancel(getgenv().Threads[thread])
		getgenv().Threads[thread] = nil
	end
end

function getIslandList()
	local list = {}
	for _, island in pairs(workspace.Map:GetChildren()) do
		if island:IsA("Model") then
			table.insert(list, island.Name)
		end
	end
	
	return list
end

task.spawn(function()
	if game.PlaceId == 7449423635 then
		getgenv().Configuration.CurrentPlace = "Third-Seas"
	elseif game.PlaceId == 4442272183 then
		getgenv().Configuration.CurrentPlace = "Second-Seas"
	elseif game.PlaceId == 2753915549 then
		getgenv().Configuration.CurrentPlace = "First-Seas"
	end
end)

task.spawn(function()
	CommF_:InvokeServer("SetTeam","Pirates")
end)

coroutine.wrap(function()
	local namecall
	namecall = hookmetamethod(game,"__namecall",function(self,...)
		local args = {...}
		local method = getnamecallmethod()
		if not checkcaller() and self == AttackRemote and method == "FireServer" then
			args[1] = "0"
			return namecall(self,unpack(args))
		end
		if not checkcaller() and self == HitRemote and method == "FireServer" then
			args[4] = ""
			return namecall(self,unpack(args))
		end
		return namecall(self,...)
	end)
end)()

task.spawn(function()
	Plr.CharacterAdded:Connect(function()
		task.wait(1)
		Manager:RestartAll()
	end)
end)

local Window = Fluent:CreateWindow({
    Title = "Lapzurite_",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Aqua",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    AutoFarm = Window:AddTab({ Title = "AutoFarm", Icon = "house"}),
	SubFarm = Window:AddTab({ Title = "MiscFarm", Icon = "house"}),
	Raid = Window:AddTab({ Title = "Raid", Icon = "beef"}),
	Travel = Window:AddTab({ Title = "Travel", Icon = "plane"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings"})
}

local Options = Fluent.Options
--[[
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("Lapzurite")
SaveManager:SetFolder("Lapzurite/configs")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

task.spawn(function()
	for optionName, option in pairs(Options) do
		option:OnChanged(function()
			if getgenv().Configuration.Modules[optionName] ~= nil then
				getgenv().Configuration.Modules[optionName] = option.Value
			end

			if getgenv().ModuleSetting.AutoFarmChests[optionName] ~= nil then
				getgenv().ModuleSetting.AutoFarmChests[optionName] = option.Value
			end
		end)
	end
end)

SaveManager:LoadAutoloadConfig()
--]]

Manager:Register(
    "AutoChest",
    AutoFarmChests,
    function()
        Pause()
	end
)

Manager:Register(
    "AutoKatakuri",
    AutoKatakuriFunc,
    function()
        Pause()
	end
)

Manager:Register(
    "AutoBone",
    AutoBoneFunc,
    function()
        Pause()
	end
)

Manager:Register(
    "CompleteRaid",
    CompleteRaid,
    function()
        Pause()
	end
)

do
	local AutoChest = Tabs.SubFarm:AddToggle("AutoChest", {Title = "Auto Chest", Default = false})

    AutoChest:OnChanged(function()
		if Options.AutoChest.Value then
			Manager:Start("AutoChest")
		else
			Manager:Stop("AutoChest")
		end
	end)

	local Delay = Tabs.SubFarm:AddSlider("Delay", {
        Title = "Delay between chests",
        Description = "Changes how long your character stays after collected a chest",
        Default = 1,
        Min = 0,
        Max = 15,
        Rounding = 1,
        Callback = function(Value)
			getgenv().ModuleSetting.AutoFarmChests.Delay = Value
        end
    })
	
	local AutoKatakuri = Tabs.SubFarm:AddToggle("AutoKatakuri", {Title = "Auto Katakuri", Default = false})

    AutoKatakuri:OnChanged(function()
		if Options.AutoKatakuri.Value then
			Manager:Start("AutoKatakuri")
		else
			Manager:Stop("AutoKatakuri")
		end
	end)

	local AutoBone = Tabs.SubFarm:AddToggle("AutoBone", {Title = "AutoFarm Bones", Default = false})

    AutoBone:OnChanged(function()
		if Options.AutoBone.Value then
			Manager:Start("AutoBone")
		else
			Manager:Stop("AutoBone")
		end
	end)
	
	local CompleteRaid1 = Tabs.Raid:AddToggle("CompleteRaid", {Title = "Complete raid", Default = false})

    CompleteRaid1:OnChanged(function()
		if Options.CompleteRaid.Value then
			Manager:Start("CompleteRaid")
		else
			Manager:Stop("CompleteRaid")
		end
	end)
	
	local RaidType = Tabs.Raid:AddDropdown("RaidType", {
		Title = "Fruit",
		Description = "",
		Values = {"Flame", "Ice", "Quake", "Dark", "Spider"},
		Multi = false,
		Default = 1,
	})

	RaidType:OnChanged(function(Value)
		getgenv().ModuleSetting.Raid.RaidType = Value
	end)
	
	local TweenSpeed = Tabs.Settings:AddSlider("TweenSpeed", {
        Title = "Tween Speed",
        Description = "Changes how fast your character is moving",
        Default = 250,
        Min = 0,
        Max = 300,
        Rounding = 1,
        Callback = function(Value)
            getgenv().Configuration.TweenSpeed = Value
        end
    })
	
	local Island = Tabs.Travel:AddDropdown("Island", {
		Title = "Destination",
		Description = "",
		Values = getIslandList(),
		Multi = false,
		Default = 1,
	})
	
	local StartTravel = Tabs.Travel:AddToggle("StartTravel", {Title = "Travel", Default = false})
	local val

	Island:OnChanged(function(Value)
		val = Value
	end)
	
    StartTravel:OnChanged(function()
		local function Travel()
			local function Anchor(Char)
				if Options.StartTravel.Value then
					local f = Instance.new("BodyVelocity")
					f.Name = "f"
					f.P = 15000
					f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
					f.Velocity = Vector3.new(0,.01,0)
					f.Parent = Char.PrimaryPart
				else
					local bv = Char.PrimaryPart:FindFirstChild("f")
					if bv then
						bv:Destroy()
					end
				end
				
				for _,part in pairs(Char:GetChildren()) do
					if part:IsA("BasePart") then
						part.CanCollide = Options.StartTravel.Value
					end
				end
			end
			
			local island = workspace.Map:FindFirstChild(val) or workspace:FindFirstChild(val)
			
			if Char and island then
				Anchor(Char)
				Tween(Char.PrimaryPart, TweenInfo.new((island:GetPivot().Position - Char.PrimaryPart.Position).Magnitude / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = island:GetPivot()})
			end
		end
		
		startThread("Travel", Travel)

		if not Options.StartTravel.Value then
			Pause()
			closeThread("Travel")
		end
    end)

 	local Tool = Tabs.Settings:AddDropdown("Tool", {
		Title = "Weapon type",
		Description = "",
		Values = {'Melee', 'Sword'},
		Multi = false,
		Default = 1,
	})
	
	Tool:OnChanged(function(Value)
		getgenv().Configuration.Tool = Value
	end)

	Tabs.Settings:AddButton({
        Title = "Fast Mode",
        Description = "Enable Fast mode",
        Callback = function()
			Fluent:Notify({
				Title = "Lapzurite",
				Content = "Success",
				SubContent = "",
				Duration = 5 
    		})

			local Terrain = workspace:FindFirstChildOfClass('Terrain')
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 0
			Lighting.FogEnd = 9e9
			settings().Rendering.QualityLevel = 1
			for i,v in pairs(game:GetDescendants()) do
				if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
					v.Material = "Plastic"
					v.Reflectance = 0
				elseif v:IsA("Decal") then
					v.Transparency = 1
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Lifetime = NumberRange.new(0)
				elseif v:IsA("Explosion") then
					v.BlastPressure = 1
					v.BlastRadius = 1
				end
			end
			for i,v in pairs(Lighting:GetDescendants()) do
				if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
					v.Enabled = false
				end
			end
			workspace.DescendantAdded:Connect(function(child)
				task.spawn(function()
					if child:IsA('ForceField') then
						RunService.Heartbeat:Wait()
						child:Destroy()
					elseif child:IsA('Sparkles') then
						RunService.Heartbeat:Wait()
						child:Destroy()
					elseif child:IsA('Smoke') or child:IsA('Fire') then
						RunService.Heartbeat:Wait()
						child:Destroy()
					end
				end)
			end)
        end
    })
end
