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
		
		local function Attack()
			local success, err = pcall(function()
				for _ = 1, #getinstances() do
					if _ > 1 then
						local e = Enemies:GetChildren()[1]
						local Tool = getTool()
						
						if isAlive(e) and table.find(MobList, e.Name) then
							Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(e:GetPivot().Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = e:GetPivot() * CFrame.new(0,15,0)})
							
							repeat task.wait()
								local enemy = b:GroupMob(e)
								Char.Humanoid:EquipTool(Tool)
								Char:PivotTo(enemy:GetPivot() * CFrame.new(0,15,0))
							until not isAlive(e) and not isAlive(enemy)
						end
					end
				end
			end)
			
			if err then print(err) end
		end
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(-5060.41162109375, 318.50201416015625, -3193.224853515625))
		Char:PivotTo(Char:GetPivot() * CFrame.new(15,50,0))
		
		while getgenv().Configuration.Modules.AutoPirate do
			Attack()
		end
	end	
end

return autopirate
