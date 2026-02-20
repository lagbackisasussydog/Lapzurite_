local Plr = game.Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")

local HitRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
local AttackRemote = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
local CommF_ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")

getgenv().Config = {
    MobKilled = 0,
    QuestTaken = false,
    NPC = nil,
    CurrentTarget = nil,
    IsRunning = true,
    AttackCooldown = 0.01,
	IsInUnderwater = false,
	IsInSky = false,
	IsInSky2 = false,
	Puzzle = false,
}

local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()

coroutine.wrap(function()
	local character = Plr.Character or Plr.CharacterAdded:Wait()
	local hum = character.Humanoid
	local death = 0
	
	hum.HealthChanged:Connect(function(h)
		if h <= 0 then
			death += 1
			if death == 5 then
				task.wait(1)
				module:Teleport(game.PlaceId)
			end
		end
	end)
end)()

local function Anchor(Char)
    --f Char.PrimaryPart:FindFirstChild("f") then return end
    local f = Instance.new("BodyVelocity")
    f.Name = "f"
    f.P = 15000
    f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    f.Velocity = Vector3.new(0,.01,0)
    f.Parent = Char.PrimaryPart
	
	for _,part in pairs(Char:GetChildren()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
end

local function getMelee()
    local backpack = Plr.Backpack
    for _,item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == "Melee" then
            return item
        end
    end
	for _,item in pairs(Plr.Character:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == "Melee" then
            return item
        end
    end
end

local function getRoutineTable()
    local level = Plr.Data.Level.Value
    if level >= 1 and level < 10 then
        return {
            NPC = "Bandit Quest Giver",
            Target = "Bandit",
            TargetPosition = {
				[1] = Vector3.new(1160.79285, 16.308918, 1396.76758),
				[2] = Vector3.new(1192.06702, 16.7385406, 1619.22168)
			},
            Quest = "BanditQuest1",
            QuestSection = 1,
            QuestGoal = 6,
        }
    elseif level >= 9 and level < 30 then
        return {
            NPC = "Adventurer",
            Target = "Monkey",
            TargetPosition = {
				[1] = Vector3.new(-1612.88428, 36.8870392, 150.707809),
				[2] = Vector3.new(-1554.04565, 22.9448719, 323.000702)
			},
            Quest = "JungleQuest",
            QuestSection = 1,
            QuestGoal = 7,
        }
	elseif level >= 29 and level < 175 then
		return {
            NPC = "Freezeburg Quest Giver",
            Target = "Galley Pirate",
            TargetPosition = {
				[1] = Vector3.new(5578.61182, 38.5360413, 3927.96045),
				[2] = Vector3.new(5578.61182, 38.5360413, 3927.96045)
			},
            Quest = "FountainQuest",
            QuestSection = 1,
            QuestGoal = 30,
        }
	elseif level >= 174 and level < 250 then
		return {
            NPC = "Sky Adventurer",
            Target = "Dark Master",
            TargetPosition = {
				[1] = Vector3.new(-4847.61865, 717.731018, -2632.14331),
				[2] = Vector3.new(-5226.62842, 448.897278, -2396.5481)
			},
            Quest = "SkyQuest",
            QuestSection = 2,
            QuestGoal = 9,
        }
	elseif level >= 249 and level < 300 then
		return {
            NPC = "Colosseum Quest Giver",
            Target = "Toga Warrior",
            TargetPosition = {
				[1] = Vector3.new(-1500.21082, 7.42455006, -2966.73486),
				[2] = Vector3.new(-1773.02649, 52.4644165, -2688.31104)
			},
            Quest = "ColosseumQuest",
            QuestSection = 1,
            QuestGoal = 8,
        }
	elseif level >= 299 and level < 325 then
		return {
            NPC = "The Mayor",
            Target = "Military Soldier",
            TargetPosition = {
				[1] = Vector3.new(-5345.09473, 9.01804161, 8527.49609),
				[2] = Vector3.new(-5566.64648, 17.2521591, 8378.87793)
			},
            Quest = "MagmaQuest",
            QuestSection = 1,
            QuestGoal = 8,
        }
	elseif level >= 324 and level < 375 then
		return {
            NPC = "The Mayor",
            Target = "Military Spy",
            TargetPosition = {
				[1] = Vector3.new(-5345.09473, 9.01804161, 8527.49609),
				[2] = Vector3.new(-5857.83203, 77.2870331, 8847.55762)
			},
            Quest = "MagmaQuest",
            QuestSection = 2,
            QuestGoal = 9,
        }
	elseif level >= 374 and level < 400 then
		return {
            NPC = "King Neptune",
            Target = "Fishman Warrior",
            TargetPosition = {
				[1] = Vector3.new(61127.3008, 18.5067692, 1577.22119),
				[2] = Vector3.new(60930.707, 18.5179844, 1597.11829)
			},
            Quest = "FishmanQuest",
            QuestSection = 1,
            QuestGoal = 9,
			Request = 1
        }
	elseif level >= 399 and level < 450 then
		return {
            NPC = "King Neptune",
            Target = "Fishman Commando",
            TargetPosition = {
				[1] = Vector3.new(61127.3008, 18.5067692, 1577.22119),
				[2] = Vector3.new(61917.8672, 18.5179844, 1450.17859)
			},
            Quest = "FishmanQuest",
            QuestSection = 2,
            QuestGoal = 8,
			Request = 1
        }
	elseif level >= 450 and level < 475 then
		return {
            NPC = "King Neptune",
            Target = "Fishman Commando",
            TargetPosition = {
				[1] = Vector3.new(61127.3008, 18.5067692, 1577.22119),
				[2] = Vector3.new(61917.8672, 18.5179844, 1450.17859)
			},
            Quest = "FishmanQuest",
            QuestSection = 2,
            QuestGoal = 8,
			Request = 1
        }
	elseif level >= 474 and level < 525 then
		return {
            NPC = "Mole",
            Target = "Shanda",
            TargetPosition = {
				[1] = Vector3.new(-7894.6181640625, 5547.14208984375, -380.2909851074219),
				[2] = Vector3.new(-7681.30518, 5566.86328, -497.615448)
			},
            Quest = "SkyExp1Quest",
            QuestSection = 2,
            QuestGoal = 10,
			Request = 3
        }
	elseif level >= 524 and level < 550 then
		return {
            NPC = "Sky Quest Giver 2",
            Target = "Royal Squad",
            TargetPosition = {
				[1] = Vector3.new(-7887.36719, 5635.99902, -1410.34705),
				[2] = Vector3.new(-7634.67285, 5637.1167, -1408.89124)
			},
            Quest = "SkyExp2Quest",
            QuestSection = 1,
            QuestGoal = 9,
        }
	elseif level >= 549 and level < 625 then
		return {
            NPC = "Sky Quest Giver 2",
            Target = "Royal Soldier",
            TargetPosition = {
				[1] = Vector3.new(-7887.36719, 5635.99902, -1410.34705),
				[2] = Vector3.new(-7837.71191, 5622.31689, -1784.57361)
			},
            Quest = "SkyExp2Quest",
            QuestSection = 2,
            QuestGoal = 9,
        }
	elseif level >= 624 and level < 650 then
		return {
            NPC = "Freezeburg Quest Giver",
            Target = "Galley Pirate",
            TargetPosition = {
				[1] = Vector3.new(5578.61182, 38.5360413, 3927.96045),
				[2] = Vector3.new(5578.61182, 38.5360413, 3927.96045)
			},
            Quest = "FountainQuest",
            QuestSection = 1,
            QuestGoal = 9,
        }
	elseif level >= 649 and level < 700 then
		return {
            NPC = "Freezeburg Quest Giver",
            Target = "Galley Captain",
            TargetPosition = {
				[1] = Vector3.new(5578.61182, 38.5360413, 3927.96045),
				[2] = Vector3.new(5443.66845703125, 42.53704833984375, 4949.4296875)
			},
            Quest = "FountainQuest",
            QuestSection = 2,
            QuestGoal = 10,
        }
	end
    return nil
end

local function Tween(Inst, Info, Properties)
    local TweenSvc = game:GetService("TweenService")
    local Track = TweenSvc:Create(Inst, Info, Properties)
    Track:Play()
    Track.Completed:Wait()
end

local function FireHitRemote(enemy, tool,character)
    -- Create the hit parts table (usually contains the humanoid root part and maybe other parts)
    
    -- These arguments might need adjustment based on your game
    local args = {
        [1] = enemy.Head,
        [2] = {},
		[4] = "0"
    }
    
    local success, err = pcall(function()
		if character and enemy then
			character:SetPrimaryPartCFrame(enemy.PrimaryPart.CFrame * CFrame.new(0,15,0))
			AttackRemote:FireServer(0)
			HitRemote:FireServer(unpack(args))
		end
    end)
    
    if not success then
        warn("Failed to fire HitRemote:", err)
    end
end

local function RequestEntrance()
	local args = {
		[1] = "requestEntrance",
		[2] = Vector3.new(61163.8515625, 11.680007934570312, 1819.7840576171875)
	}

	CommF_:InvokeServer(unpack(args))
end

local function RequestEntrance2()
	local args = {
		[1] = "requestEntrance",
		[2] = Vector3.new(-4607.8232421875, 874.3909912109375, -1667.5570068359375)
	}

	CommF_:InvokeServer(unpack(args))
end

local function RequestEntrance3()
	local args = {
		[1] = "requestEntrance",
		[2] = Vector3.new(-7894.6181640625, 5547.14208984375, -380.2909851074219)
	}

	CommF_:InvokeServer(unpack(args))
end

local function Puzzle(Routine,Character)
	if getgenv().Config.Puzzle then return end
	getgenv().Config.Puzzle = true
	CommF_:InvokeServer("Buso")
	local function Attack(Character)
		local Enemies = workspace.Enemies
		local CurrentRoutine = getRoutineTable()
		if not CurrentRoutine then return end
		
		local CurrentEnemy = CurrentRoutine.Target
		local Tool = getMelee()
		
		pcall(function()
			for _, Enemy in pairs(Enemies:GetChildren()) do
				if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Name == CurrentEnemy then
					local EnemyHumanoid = Enemy.Humanoid
					local EnemyRootPart = Enemy.HumanoidRootPart
					local Humanoid = Character:WaitForChild("Humanoid")
					
					local TargetCFrame = EnemyRootPart.CFrame * CFrame.new(0, 15, 0)
					local TweenDuration = Plr:DistanceFromCharacter(EnemyRootPart.Position) / 325
					
					Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
					
					Enemy.Humanoid.Died:Connect(function()
						if target.Humanoid:FindFirstChild("creator") then
							local Player = Character.Humanoid.creator.Value
							if Player == Plr.Name then
								getgenv().Config.MobKilled += 1
							end
						end
					end)
					
					-- Attack loop
					while Humanoid and EnemyHumanoid and EnemyHumanoid.Health > 0 and getgenv().Config.IsRunning do
						Humanoid:EquipTool(Tool)
						FireHitRemote(Enemy, Tool,Character)
						task.wait(getgenv().Config.AttackCooldown)
					end
				end
			end
		end)
	end
	local args = {
		[1] = "DressrosaQuestProgress",
		[2] = "Detective"
	}
	local args2 = {	
		[1] = "TravelDressrosa"
	}
	local p = Routine.Procedure
	Tween(Character.HumanoidRootPart,TweenInfo.new(Plr:DistanceFromCharacter(p[1]) / 325,Enum.EasingStyle.Linear),{CFrame = CFrame.new(p[1])})
	CommF_:InvokeServer(unpack(args))
	Tween(Character.HumanoidRootPart,TweenInfo.new(Plr:DistanceFromCharacter(p[2]) / 325,Enum.EasingStyle.Linear),{CFrame = CFrame.new(p[2])})
    Attack(Character)
	CommF_:InvokeServer(unpack(args))
	task.wait(1)
	CommF_:InvokeServer(unpack(args2))
end

local function ActivateQuest(Character)
	local Routine = getRoutineTable(Plr.Data.Level.Value)
	local TargetNPC = workspace.NPCs:FindFirstChild(Routine.NPC)
	
	if getgenv().Config.QuestTaken then return end
	if TargetNPC == nil then TargetNPC = game.ReplicatedStorage.NPCs:WaitForChild(Routine.NPC) end
	if Routine.Request and Routine.Request == 1 then 
		if getgenv().Config.IsInUnderwater == true then print("") end
		getgenv().Config.IsInUnderwater = true
		RequestEntrance()
	elseif Routine.Request and Routine.Request == 2 then
		getgenv().Config.IsInUnderwater = false
		getgenv().Config.IsInSky = true
		getgenv().Config.IsInSky2 = false
		RequestEntrance2()
	elseif Routine.Request and Routine.Request == 3 then
		getgenv().Config.IsInUnderwater = false
		getgenv().Config.IsInSky = false
		getgenv().Config.IsInSky2 = true
		RequestEntrance3()	
	end
	
	if Routine.Puzzle then
		Puzzle(Routine,Character)
	end
	
	getgenv().Config.QuestTaken = true
	getgenv().MobKilled = 0
	Tween(Character.HumanoidRootPart,TweenInfo.new(Plr:DistanceFromCharacter(Routine.TargetPosition[1]) / 325,Enum.EasingStyle.Linear),{CFrame = CFrame.new(Routine.TargetPosition[1])})
	Character:SetPrimaryPartCFrame(TargetNPC.HumanoidRootPart.CFrame)
	CommF_:InvokeServer("StartQuest",Routine.Quest,Routine.QuestSection)
	task.wait(1)
	Tween(Character.HumanoidRootPart,TweenInfo.new(Plr:DistanceFromCharacter(Routine.TargetPosition[2]) / 325,Enum.EasingStyle.Linear),{CFrame = CFrame.new(Routine.TargetPosition[2])})
end

local function Attack(Character)
    local Enemies = workspace.Enemies
    local CurrentRoutine = getRoutineTable()
    if not CurrentRoutine then return end
	
	local success,err = pcall(function()
		local CurrentEnemy = CurrentRoutine.Target
		local Tool = getMelee()
		for _, Enemy in pairs(Enemies:GetChildren()) do
			if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Name == CurrentEnemy then
				local EnemyHumanoid = Enemy.Humanoid
				local EnemyRootPart = Enemy.HumanoidRootPart
				local Humanoid = Character:WaitForChild("Humanoid")
				
				local TargetCFrame = EnemyRootPart.CFrame * CFrame.new(0, 15, 0)
				local TweenDuration = Plr:DistanceFromCharacter(EnemyRootPart.Position) / 325
				
				Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
				
				Enemy.Humanoid.Died:Connect(function()
					getgenv().Config.MobKilled += 1
				end)
				
				-- Attack loop
				while Humanoid and EnemyHumanoid and EnemyHumanoid.Health > 0 and getgenv().Config.IsRunning do
					Humanoid:EquipTool(Tool)
					FireHitRemote(Enemy, Tool,Character)
					task.wait(getgenv().Config.AttackCooldown)
				end
			end
		end
	end)
	
	if err then warn("Error: " .. err) end
end

coroutine.wrap(function()
	local Codes = {
		"JCWK",
		"ADMINFIGHT",
		"GIFTING_HOURS",
		"1LOSTADMIN",
		"NOMOREHACK",
		"BANEXPLOIT",
		"WildDares",
		"BossBuild",
		"GetPranked",
		"EARN_FRUITS",
		"SUB2GAMERROBOT_EXP1",
		"Sub2UncleKizaru",
		"FIGHT4FRUIT",
		"kittgaming",
		"TRIPLEABUSE",
		"Sub2CaptainMaui",
		"Sub2Fer999",
		"Enyu_is_Pro",
		"Magicbus",
		"Starcodeheo",
		"Bluxxy",
		"krazydares",
		"24NOADMIN",
		"ADMIN_TROLL",
		"NEWTROLL",
		"SECRET_ADMIN",
		"staffbattle",
		"TheGreatAce",
		"StrawHatMaine",
		"TantaiGaming",
		"Sub2Daigrock",
		"Axiore",
		"Sub2NoobMaster123"
	}

	local Remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Redeem")
	
	for _,code in pairs(Codes) do
		Remote:InvokeServer(code)
		task.wait(.1)
	end
end)()

local function Return(Character)
	local CurrentRoutine = getRoutineTable()
	if CurrentRoutine then
		local TweenDuration = Plr:DistanceFromCharacter(CurrentRoutine.TargetPosition[2]) / 250
		Tween(Character.PrimaryPart, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(TargetPosition[2])})
		task.wait(1)
		Attack(Character)
	end
end

local function newQuestCheck()
	local Gui = Plr.PlayerGui:FindFirstChild("Notifications")
	for _, tmp in pairs(Gui:GetChildren()) do
		if tmp and tmp:IsA("TextLabel") and string.find(tmp.Text,"QUEST COMPLETED") then
			return tmp
		end
	end
end

local Points = Plr.Data.Points
Points.Changed:Connect(function(Value)
	if Value >= 1 then
		CommF_:InvokeServer("AddPoint","Melee",math.huge)
	end
end)

local counter = nil
coroutine.wrap(function()
	local gui = Instance.new("ScreenGui", Plr.PlayerGui)
	gui.Name = "placeholder"
	
	counter = Instance.new("TextLabel", gui)
	counter.Size = UDim2.new(0,200,0,50)
	counter.TextSize = 12
	counter.Text = getgenv().Config.MobKilled
end)()

game["Run Service"].Heartbeat:Connect(function()
	counter.Text = getgenv().Config.MobKilled
end)

coroutine.wrap(function()
	print("Init")
	
	local function handleCharacterAdded(newChar)
		Char = newChar
		Root = newChar:WaitForChild("HumanoidRootPart")
		
		task.wait(5) 
		
		Anchor(Char)
		Return(Char)
	end

	Plr.CharacterAdded:Connect(handleCharacterAdded)

	while getgenv().Config.IsRunning do
		Anchor(Char)
		
		local tmp = newQuestCheck()
		if not Char or not Char.Parent or not Root or not Root.Parent then
			repeat task.wait() until Char
			task.wait(1)
			continue
		end

		local CurrentRoutine = getRoutineTable()
		
		if not CurrentRoutine then
			task.wait(3)
			continue
		end
		
		if getgenv().Config.QuestTaken then
			if tmp or getgenv.Config.MobKilled >= CurrentRoutine.QuestGoal then
				getgenv().Config.QuestTaken = false
				getgenv().Config.MobKilled = 0
			else
				Attack(Char)
			end
		else
			ActivateQuest(Char)
			task.wait(1)
		end
		task.wait()
	end
end)()
