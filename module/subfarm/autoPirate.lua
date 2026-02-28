local autopirate = {}

function autopirate:Init()
	return function()
		local Plr = game.Players.LocalPlayer
		local Enemies = workspace.Enemies
		local Char = Plr.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
		local MobList = {
			"Galley Pirate",
			"Galley Captain",
			"Raider",
			"Mercenary",
			"Vampire",
			"Zombie",
			"Snow Trooper",
			"Winter Warrior",
			"Lab Subordinate",
			"Horned Warrior",
			"Magma Ninja",
			"Lava Pirate",
			"Ship Deckhand",
			"Ship Engineer",
			"Ship Steward",
			"Ship Officer",
			"Arctic Warrior",
			"Snow Lurker",
			"Sea Soldier",
		}
		
		local b = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/FastAttack.lua"))()
		
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
		
		local function getTool()
			for _, tool in pairs(Plr.Backpack:GetChildren()) do
				if tool:GetAttribute("WeaponType") == getgenv().Configuration.Tool and Char:FindFirstChild(tool.Name) == nil then
					return tool
				end
			end
		end
		
		local function notification()
			local Gui = Plr.PlayerGui:FindFirstChild("Notifications")
			for _, tmp in pairs(Gui:GetChildren()) do
				if tmp and tmp:IsA("TextLabel") and (string.find(tmp.Text,"The pirates are raiding Castle on the Sea!") or string.find(tmp.Text,"Pirates have been spotted approaching the castle!")) then
					return tmp
				end
			end
		end
		
		local function mobCheck()
			for _, mob in pairs(getinstances()) do
				if mob:IsA("Model") then
					if mob:FindFirstChildOfClass("Humanoid") and table.find(MobList, mob.Name) then
						return true
					end
				end
			end
		end
		
		local function Attack()
			local success, err = pcall(function()
				for _ = 1, #Enemies:GetChildren() do
					local enemy = Enemies:GetChildren()[1]
					if isAlive(enemy) and table.find(MobList, enemy.Name) then
						local eRoot = enemy.HumanoidRootPart
						local eHum = enemy.Humanoid
						local tool = getTool()
						
						if getgenv().Configuration.Modules.AutoPirate == false or Char.Humanoid.Health <= 0 then break end
						
						local time = TweenInfo.new(Plr:DistanceFromCharacter(eRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear)
						
						Tween(Root, time, {CFrame = eRoot.CFrame * CFrame.new(0,15,0)})
						
						while enemy and isAlive(enemy) and getgenv().Configuration.Modules.AutoPirate == true do
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
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(-5060.41162109375, 318.50201416015625, -3193.224853515625))
		Char:PivotTo(Char:GetPivot() * CFrame.new(15,50,0))
		
		while getgenv().Configuration.Modules.AutoPirate do
			local n = notification()
			local m = mobCheck()
			if n or m then
				task.wait(0.05)
				Attack()
			end
		end
	end	
end

return autopirate
