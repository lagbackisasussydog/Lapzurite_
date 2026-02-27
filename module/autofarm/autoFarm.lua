local level = {}

function level:Init()
	local Plr = game.Players.LocalPlayer
	local Char = Plr.Character or Plr.CharacterAdded:Wait()
	local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	local State = {
		["QuestTaken"] = false,
		["CurrentTarget"] = ""
	}
	
	local function Tween(Inst, Info,Properties)
		if not Inst or not Inst.Parent then return end
		local TweenSvc = game:GetService("TweenService")
		local Track = TweenSvc:Create(Inst, Info, Properties)
		getgenv().Configuration.CurrentTweeningProcess = Track
		Track:Play()
		Track.Completed:Wait()
	end
		
	local function isAlive(mob)
		if mob and mob.Humanoid and mob.HumanoidRootPart and mob.Humanoid.Health > 0 then
			return true
		end
	end
	
	-- Will expand in the future
	local function getRoutine()
		local lv = Plr.Data.Level.Value
		if lv <= 10 then
			return {
				["Target"] = {
					{"Bandit", 1, 10}
				},
				["Quest"] = {
					{"BanditQuest1", 1, 1, 10}
				},
				["NPC"] = "Bandit Quest Giver"
			}
		elseif lv >= 10 and lv <= 30 then
			return {
				["Target"] = {
					{"Monkey", 10, 15},
					{"Gorilla", 15, 30}
				},
				["Quest"] = {
					{"JungleQuest", 1, 10, 15},
					{"JungleQuest", 2, 15, 30}
				},
				["NPC"] = "Adventurer"
			}
		elseif lv >= 30 and lv <= 60 then
			return {
				["Target"] = {
					{"Pirate", 30, 45},
					{"Brute", 45, 60}
				},
				["Quest"] = {
					{"BuggyQuest1", 1, 30, 45},
					{"BuggyQuest1", 2, 45, 60}
				},
				["NPC"] = "Pirate Adventurer"
			}
		elseif lv >= 60 and lv <= 90 then
			return {
				["Target"] = {
					{"Desert Bandit" 60, 75},
					{"Desert Officer" 75, 90}
				},
				["Quest"] = {
					{"DesertQuest", 1, 60, 75},
					{"DesertQuest", 2, 75, 90}
				},
				["NPC"] = "Desert Adventurer"
			}
		elseif lv >= 90 and lv <= 120 then
			return {
				["Target"] = {
					{"Snow Bandit", 90, 100},
					{"Snowman", 100, 120}
				},
				["Quest"] = {
					{"SnowQuest", 1, 90, 100},
					{"SnowQuest", 2, 100, 120}
				},
				["NPC"] = "Villager"
			}
		elseif lv >= 120 and lv <= 150 then
			return {
				["Target"] = {
					{"Chief Petty Officer", 120, 150},
				},
				["Quest"] = {
					{"MarineQuest2", 1, 120, 150},
				},
				["NPC"] = "Marine"
			}
		elseif lv >= 150 and lv <= 250 then
			return {
				["Target"] = {
					{"Sky Bandit", 150, 175},
					{"Dark Master", 175, 250},
				},
				["Quest"] = {
					{"SkyQuest", 1, 150, 175},
					{"SkyQuest", 2, 175, 250},
				},
				["NPC"] = "Marine"
			}
		end
	end
	
	local function getNPC()
		local Routine = getRoutine()
		for _, n in ipairs({workspace.NPCs, ReplicatedStorage.NPCs}) do
			for _, npc in pairs(n:GetChildren()) do
				if Routine and npc.Name == Routine.NPC then
					return npc
				end
			end
		end
	end
	
	local function getQuest()
		local s = State.QuestTaken
		local npc = getNPC()
		local routine = getRoutine()
		local lv = Plr.Data.Level.Value
		
		if not s and npc and routine then
			for _ = 1, #routine.Quest do
				local q = routine.Quest[_][1]
				local n = routine.Quest[_][2]
				local minlv = routine.Quest[_][3]
				local maxlv = routine.Quest[_][4]
				
				if lv >= minlv and lv <= maxlv then
					Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(npc:GetPivot().Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = npc:GetPivot()})
					ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q, n)
					State.CurrentTarget = routine.Target[_][1]
				end
			end
			State.QuestTaken = true
		end
	end
	
	local function checkNotification()
		local Notification = Plr.PlayerGui:FindFirstChild("Notifications")
		for _, n in pairs(Notification:GetChildren()) do
			if n and n:IsA("TextLabel") and string.find(n.Text, "QUEST COMPLETED") then
				return true
			end
		end
	end
	
	local function getTool()
		for _, tool in pairs(Plr.Backpack:GetChildren()) do
			if tool:GetAttribute("WeaponType") == getgenv().Configuration.Tool and Char:FindFirstChild(tool.Name) == nil then
				return tool
			end
		end
	end
	
	local function Attack()
		local routine = getRoutine()
		local lv = Plr.Data.Level.Value
		local success, err = pcall(function()
			for _, enemy in pairs(workspace.Enemies:GetChildren()) do
				if isAlive(enemy) and routine and enemy.Name == State.CurrentTarget then
					local eRoot = enemy.HumanoidRootPart
					local eHum = enemy.Humanoid
					local tool = getTool()
					
					if getgenv().Configuration.Modules.AutoFarmLevel == false or Char.Humanoid.Health <= 0 then break end
					
					local time = TweenInfo.new(Plr:DistanceFromCharacter(eRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear)
					
					Tween(Root, time, {CFrame = eRoot.CFrame * CFrame.new(0,15,0)})
					
					while enemy and isAlive(enemy) and getgenv().Configuration.Modules.AutoFarmLevel == true do
						task.wait(0.05)
						
						local Char = Plr.Character
						if not Char then break end
						
						local Hum = Char:FindFirstChild("Humanoid")
						if not Hum or Hum.Health <= 0 then break end
						
						Char:PivotTo(enemy:GetPivot() * CFrame.new(0,15,0))
						Char.Humanoid:EquipTool(tool)
					end
				end
			end
		end)
			
		if err then print(err) end
	end
	
	while getgenv().Configuration.Modules.AutoFarmLevel do
		if State.QuestTaken and (checkNotification() or Plr.PlayerGui.Main.Quest.Visible == false) then
			State.QuestTaken = false
			State.CurrentTarget = ""
		end
		
		task.wait(0.05)
		getQuest()
		Attack()
	end
end

return level
