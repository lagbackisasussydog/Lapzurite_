getgenv().Configuration = {
	["Tool"] = "Melee",
	["TweenSpeed"] = 250,
	["CurrentPlace"] = "",
	["CurrentTweeningProcess"] = nil,
	["Modules"] = {
		["AutoFarmLevel"] = false,
		["AutoFarmChests"] = false,
		["CompleteRaid"] = false
	},
}

getgenv().ModuleSetting = {
	["AutoFarmChests"] = {
		["Delay"] = .5,
		["Method"] = "Tween",
	},
	["Raid"] = {
		["RaidType"] = ""
	}
}

local Plr = game.Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")

local HitRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
local AttackRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
local CommF_ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")

local function Tween(Inst, Info,Properties)
    local TweenSvc = game:GetService("TweenService")
    local Track = TweenSvc:Create(Inst, Info, Properties)
	getgenv().Configuration.CurrentTweeningProcess = Track
    Track:Play()
    Track.Completed:Wait()
end

local function Pause()
	local Track = getgenv().Configuration.CurrentTweeningProcess
	Track:Cancel()
	getgenv().Configuration.CurrentTweeningProcess = nil
end

local function getTool()
	for _, v in pairs(Plr.Backpack:GetChildren()) do
		if v.ToolTip == getgenv().Configuration.Tool then
			if Char:FindFirstChild(v.Name) then continue end
			return v
		end
	end
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

function AutoFarmLevel()
	local function Anchor(Char, Toggled)
		if Toggled then
			local f = Instance.new("BodyVelocity")
			f.Name = "f"
			f.P = 15000
			f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			f.Velocity = Vector3.new(0,.01,0)
			f.Parent = Char.PrimaryPart
		else
			Char.PrimaryPart:FindFirstChild("f"):Destroy()
		end
		
		for _,part in pairs(Char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = Toggled
			end
		end
	end

	function getQuest()
		
	end
end

function AutoFarmChest()
	local function Anchor(Char, Toggled)
		if getgenv().Configuration.Modules.AutoFarmChests then
			local f = Instance.new("BodyVelocity")
			f.Name = "f"
			f.P = 15000
			f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			f.Velocity = Vector3.new(0,.01,0)
			f.Parent = Char.PrimaryPart
		else
			Char.PrimaryPart:FindFirstChild("f"):Destroy()
		end
		
		for _,part in pairs(Char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = getgenv().Configuration.Modules.AutoFarmChests
			end
		end
	end
	
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
	
	
	Anchor(Char, false)
	while getgenv().Configuration.Modules.AutoFarmChests do
		if getgenv().Configuration.CurrentPlace == "First-Seas" then
			for _, chest in pairs(FirstSeasChests) do
				if not getgenv().Configuration.Modules.AutoFarmChests then break end
				Tween(Char.PrimaryPart, TweenInfo.new((chest.Position - Char.PrimaryPart.Position).Magnitude / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = chest})
				task.wait(getgenv().ModuleSetting.AutoFarmChests.Delay)
			end
		end
	end
end

local function CompleteRaid()
	local Enemies = workspace.Enemies
	local MobList = {
		"Bladesmith",
		"Sorcerer",
		"Bone Breaker",
		"Shocker",
		"Flame User",
		"Ice User",
		"Dark User"
	}
	
	local function Anchor(Char)
		if getgenv().Configuration.Modules.CompleteRaid then
			local f = Instance.new("BodyVelocity")
			f.Name = "f"
			f.P = 15000
			f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			f.Velocity = Vector3.new(0,.01,0)
			f.Parent = Char.PrimaryPart
		else
			Char.PrimaryPart:FindFirstChild("f"):Destroy()
		end
		
		for _,part in pairs(Char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = getgenv().Configuration.Modules.CompleteRaid
			end
		end
	end
	
	local function FireHitRemote(enemy, tool,character)
		-- Create the hit parts table (usually contains the humanoid root part and maybe other parts)
		
		-- These arguments might need adjustment based on your game
		local args = {
			[1] = enemy.Head,
			[2] = {},
			[4] = "0"
		}
		
		local Tool = getTool()
		local success, err = pcall(function()
			if character then
				character:SetPrimaryPartCFrame(enemy.PrimaryPart.CFrame * CFrame.new(0,15,0))
				character.Humanoid:EquipTool(Tool)
				AttackRemote:FireServer(0)
				HitRemote:FireServer(unpack(args))
			end
		end)
		
		if not success then
			warn("Failed to fire HitRemote:", err)
		end
	end
	
	--<font color="rgb(102,255,102)">Island #1 cleared!</font>
	
	local function Attack(Character, Enemies)
		local success,err = pcall(function()
			for _, Enemy in pairs(Enemies:GetChildren()) do
				if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Name == CurrentEnemy then
					local EnemyHumanoid = Enemy.Humanoid
					local EnemyRootPart = Enemy.HumanoidRootPart
					local Humanoid = Character:WaitForChild("Humanoid")
					
					local TargetCFrame = EnemyRootPart.CFrame * CFrame.new(0, 15, 0)
					local TweenDuration = Plr:DistanceFromCharacter(EnemyRootPart.Position) / 325
					
					Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
					
					-- Attack loop
					while Humanoid and EnemyHumanoid and EnemyHumanoid.Health > 0 and getgenv().Config.IsRunning do
						FireHitRemote(Enemy, Tool,Character)
						task.wait(.2)
					end
				end
			end
		end)
		
		if err then warn("Error: " .. err) end
	end
	
	local function IslandCheck()
		local Notifications = game:GetService("Players").LocalPlayer.PlayerGui.Notifications
		
		for _, v in pairs(Notifications:GetChildren()) do
			if v:IsA("TextLabel") and v.Name == "NotificationTemplate" then
				if v.Text == '<font color="rgb(102,255,102)">Island #1 cleared!</font>' then
					return 2
				elseif v.Text == '<font color="rgb(102,255,102)">Island #2 cleared!</font>' then
					return 3
				elseif v.Text == '<font color="rgb(102,255,102)">Island #3 cleared!</font>' then
					return 4
				elseif v.Text == '<font color="rgb(102,255,102)">Island #4 cleared!</font>' then
					return 5
				elseif v.Text == '<font color="rgb(102,255,102)">Island #5 cleared!</font>' then
					return 0
				end
			end
		end
	end
	
	Anchor(Char)
	local loop_thread = task.spawn(function()
		while Char.Humanoid.Health > 0 and getgenv().Configuration.Modules.CompleteRaid do
			local rType = getgenv().ModuleSetting.Raid.RaidType
			
			if rType == "Flame" then
				local island = IslandCheck()
				local islandPosition = {
					CFrame.new(71721.1171875, 10.41573715209961, -25441.32421875),
					CFrame.new(71670, 9.053179740905762, -23932.7265625),
				}
				
				Tween(Char.PrimaryPart, TweenInfo.new((islandPosition[1].Position - Char.PrimaryPart.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = islandPosition[1] * CFrame.new(0,15,0)})
				for _, Inst in pairs(Enemies:GetChildren()) do
					if Inst and Inst.Humanoid.Health > 0 and MobList[Inst.Name] then
						Attack(Char, Inst)
					end
				end
			end
			task.wait()
		end
	end)
end

function closeThread(thread)
	for _, v in pairs(getreg()) do
		if v == thread then				
			Bracket:Notification({Title = "Notice", Description = "Found thread!"})
			Pause()
			coroutine.close(thread)
		end
	end
end

task.spawn(function()
	Plr.CharacterAdded:Connect(function(newChar)
		Char = newChar
	end)
end)

local Bracket = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV32.lua"))()
local name,version = identifyexecutor()

local Window = Bracket:Window({Name = tostring("Lapzurite - Executor: " .. name .. " " .. getgenv().Configuration.CurrentPlace),Enabled = true,Color = Color3.new(0,0,.25),Size = UDim2.new(0,496,0,496),Position = UDim2.new(0.5,-350,0.5,-248)}) do
	local Tab = Window:Tab({Name = "Home"}) do
		local AFSection = Tab:Section({Name = "SubFarm",Side = "Left"}) 
		local AFSection1 = Tab:Section({Name = "AutoFarm",Side = "Left"})
		local RSection = Tab:Section({Name = "Raid",Side = "Left"})
		local STSection = Tab:Section({Name = "Settings",Side = "Right"})

		local Toggle3 = RSection:Toggle({Name = "Complete Raid",Side = "Left",Value = false,Callback = function(Bool)
			getgenv().Configuration.Modules.CompleteRaid = Bool
			local loop_thread = task.spawn(CompleteRaid)
			
			if not Bool then
				closeThread(loop_thread)
			end
		end})		
		
		local Toggle1 = AFSection:Toggle({Name = "Auto Collect Chests",Side = "Left",Value = false,Callback = function(Bool)
			getgenv().Configuration.Modules.AutoFarmChests = Bool
			local loop_thread = task.spawn(AutoFarmChest)
			
			if not Bool then
				closeThread(loop_thread)
			end
		end})
			
		local Slider1 = AFSection:Slider({Name = "Delay between collect",Side = "Left",Min = 0,Max = 5,Value = 1,Precise = 1,Unit = "",Callback = function(Number)
			getgenv().ModuleSetting.AutoFarmChests.Delay = Number
		end})
		
		local Slider = STSection:Slider({Name = "Tween Speed",Side = "Left",Min = 250,Max = 300,Value = 250,Precise = 2,Unit = "",Callback = function(Number)
			getgenv().Configuration.TweenSpeed = Number
		end})
			
		-- Tools
		local Dropdown = STSection:Dropdown({Name = "Weapon type",Side = "Left",Default = getgenv().Configuration.Tool,List = {
			{
				Name = "Melee",
				Mode = "Button",
				--Value = false,
				Callback = function(Selected)
					getgenv().Configuration.Tool = Selected
				end
			},
			{
				Name = "Sword",
				Mode = "Button",
				--Value = false,
				Callback = function(Selected)
					getgenv().Configuration.Tool = Selected
				end
			}
		}})
		
		local Dropdown1 = RSection:Dropdown({Name = "Raid Type",Side = "Left",Default = getgenv().ModuleSetting.Raid.RaidType,List = {
			{
				Name = "Flame",
				Mode = "Button",
				--Value = false,
				Callback = function(Selected)
					getgenv().ModuleSetting.Raid.RaidType = Selected
				end
			},
		}})
		end
end
