local completeraid = {}

function completeraid:Init()
	local Plr = game.Players.LocalPlayer
	local Char = Plr.Character or Plr.CharacterAdded:Wait()
	local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
	
	local currentTarget = nil
	
	local function isAlive(mob)
			if mob and mob.Humanoid and mob.HumanoidRootPart and mob.Humanoid.Health > 0 then
				return true
			end
		end
		
	local function getTool()
		for _, tool in pairs(Plr.Backpack:GetChildren()) do
			if tool:GetAttribute("WeaponType") == getgenv().Configuration.Tool and Char:FindFirstChild(tool.Name) == nil then
				return tool
			end
		end
	end
	
	local function getNearestMob()
		local mx = math.huge
		
		for _, enemy in pairs(workspace.Enemies:GetChildren()) do
			if enemy and isAlive(enemy) and Plr:DistanceFromCharacter(enemy:GetPivot().Position) <= 1000 then
				mx = (enemy.PrimaryPart.Position - Root.Position).Magnitude
				currentTarget = enemy
			end
		end
	end
	
	local function getIsland()
		local a
		for _ = 5, 1, -1 do
			for i, island in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
				if island.Name == "Island " .. tostring(_) and Plr:DistanceFromCharacter(island:GetPivot().Position) < 3000 then
					a = island
					break
				end
				if a then break end
			end
		end
		return a
	end
	
	local function Tween(Inst, Info,Properties)
		if not Inst or not Inst.Parent then return end
		local TweenSvc = game:GetService("TweenService")
		local Track = TweenSvc:Create(Inst, Info, Properties)
		getgenv().Configuration.CurrentTweeningProcess = Track
		Track:Play()
		Track.Completed:Wait()
	end
	
	local function Attack(enemy)
		local success, err = pcall(function()
			if isAlive(enemy) and table.find(MobList, enemy.Name) then
				local eRoot = enemy.HumanoidRootPart
				local eHum = enemy.Humanoid
				local tool = getTool()
					
				if getgenv().Configuration.Modules.AutoEctoplasm == false or Char.Humanoid.Health <= 0 then break end
				
				local time = TweenInfo.new(Plr:DistanceFromCharacter(eRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear)
					
				Tween(Root, time, {CFrame = eRoot.CFrame * CFrame.new(0,15,0)})
					
				while enemy and isAlive(enemy) and getgenv().Configuration.Modules.AutoEctoplasm == true do
					task.wait(0.05)
					
					local Char = Plr.Character
					if not Char then break end
					
					local Hum = Char:FindFirstChild("Humanoid")
					if not Hum or Hum.Health <= 0 then break end
					
					Char:PivotTo(enemy:GetPivot() * CFrame.new(0,15,0))
					Char.Humanoid:EquipTool(tool)
					b:GroupMob(enemy)
				end
			end
		end)
			
		if err then print(err) end
	end
	
	while getgenv().Configuration.Modules.CompleteRaid do
		local enemy = getNearestMob()
		
		while enemy and getgenv().Configuration.Modules.CompleteRaid do
			if Char.Humanoid.Health <= 0 or not getgenv().Configuration.Modules.CompleteRaid then break end
			
			local island = getIsland()
			local l = {
				"Island 1",
				"Island 2",
				"Island 3",
				"Island 4",
				"Island 5"
			}
			
			if not enemy then
				Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(island:GetPivot().Position), Enum.EasingStyle.Linear), {CFrame = island:GetPivot() * CFrame.new(0,40,0)})
			end
			
			if table.find(l, island.Name) then
				Attack(enemy)
			end
		end
	end
end

function completeraid:BuyChip()
	local cmf = game.ReplicatedStorage.Remotes.CommF_
	local a
	
	for _, item in pairs(cmf:InvokeServer("getInventory")) do
		if item.Type == "Blox Fruit" then
			for _, v in pairs(item) do
				if v.Value < 1000000 then
					a = v.Name
					break
				end
			end
		end
	end
	
	cmf:InvokeServer("LoadFruit", a)
	task.wait(0.1)
	cmf:InvokeServer("RaidsNpc", "Select", getgenv().ModuleSettings.RaidType)
end

return completeraid
