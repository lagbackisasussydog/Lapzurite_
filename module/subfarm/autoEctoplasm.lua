local autoectoplasm ={}

function autoectoplasm:Init()
	return function()
		local CommF_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/CommFManager.lua"))()
		
		local Plr = game.Players.LocalPlayer
		local Enemies = workspace.Enemies
		local Char = Plr.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
		local a = CFrame.new(915.097168, 126.002701, 33121.5469, -0.999272764, 2.59584123e-08, 0.038131278, 2.31111841e-08, 1, -7.51098597e-08, -0.038131278, -7.41739754e-08, -0.999272764)
		local MobList = {
			"Ship Deckhand",
			"Ship Engineer",
			"Ship Steward",
			"Ship Officer"
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
		
		local function Attack()
			local success, err = pcall(function()
				for _, enemy in pairs(Enemies:GetChildren()) do
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
				end
			end)
			
			if err then print(err) end
		end
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(923.2130126953125, 126.97599792480469, 32852.83203125))
		task.wait(0.2)
		Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(a.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = a})
		
		while getgenv().Configuration.Modules.AutoEctoplasm do
			task.wait(0.05)
			Attack()
		end
	end	
end

return autoectoplasm
