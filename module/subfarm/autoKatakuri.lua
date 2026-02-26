local autokatakuri ={}

function autokatakuri:Init()
	return function()
		local CommF_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/CommFManager.lua"))()
		
		local Plr = game.Players.LocalPlayer
		local Enemies = workspace.Enemies
		local Char = Plr.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
		local a = CFrame.new(-2137.66699, 69.5312195, -12326.2383, -0.965907454, 0, -0.25888893, 0, 1, 0, 0.25888893, 0, -0.965907454)
		local MobList = {
			"Cookie Crafter",
			"Cake Guard",
			"Baking Staff",
			"Head Baker",
		}
		local BossList = {
			"Cake Prince",
			"Dough King"
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
		
		local function Attack()
			local success, err = pcall(function()
				for i, inst in pairs({Enemies, game.ReplicatedStorage}) do
					for _, enemy in pairs(inst:GetChildren()) do
						if isAlive(enemy) and (table.find(MobList, enemy.Name) or table.find(BossList, enemy.Name)) then
							local eRoot = enemy.HumanoidRootPart
							local eHum = enemy.Humanoid
								
							if getgenv().Configuration.Modules.AutoKatakuri == false or Char.Humanoid.Health <= 0 then break end
								
							local time = TweenInfo.new(Plr:DistanceFromCharacter(eRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear)
								
							Tween(Root, time, {CFrame = eRoot.CFrame * CFrame.new(0,15,0)})
								
							while enemy and isAlive(enemy) and getgenv().Configuration.Modules.AutoKatakuri == true do
								task.wait(0.05)
									
								local Char = Plr.Character
								if not Char then break end
									
								local Hum = Char:FindFirstChild("Humanoid")
								if not Hum or Hum.Health <= 0 then break end
								
								Char:PivotTo(enemy:GetPivot() * CFrame.new(0,15,0))
								b:GroupMob(enemy)
							end
						end
					end
				end
			end)
			
			if err then print(err) end
		end
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(-5060.41162109375, 318.50201416015625, -3193.224853515625))
		Char:PivotTo(Char:GetPivot() * CFrame.new(15,50,0))
		task.wait(1)
		Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(a.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = a})
		
		while getgenv().Configuration.Modules.AutoKatakuri do
			task.wait(0.05)
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			Attack()
		end
	end	
end

return autokatakuri
