local autobone ={}

function autobone:Init()
	return function()
		local CommF_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/CommFManager.lua"))()
		
		local Plr = game.Players.LocalPlayer
		local Enemies = workspace.Enemies
		local Char = Plr.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
		local a = CFrame.new(-9502.98145, 172.149506, 6154.40332, -0.999924958, 5.73953107e-09, -0.0122516705, 5.38207168e-09, 1, 2.92093407e-08, 0.0122516705, 2.91412086e-08, -0.999924958)
		local MobList = {
			"Reborn Skeleton",
			"Living Zombie",
			"Demonic Soul",
			"Posessed Mummy"
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
				for _, enemy in pairs(Enemies:GetChildren()) do
					if isAlive(enemy) and table.find(MobList, enemy.Name) then
						local eRoot = enemy.HumanoidRootPart
						local eHum = enemy.Humanoid
						
						if getgenv().Configuration.Modules.AutoBone == false or Char.Humanoid.Health <= 0 then break end
						
						local time = TweenInfo.new(Plr:DistanceFromCharacter(eRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear)
						
						Tween(Root, time, {CFrame = eRoot.CFrame * CFrame.new(0,15,0)})
						
						while enemy and isAlive(enemy) and getgenv().Configuration.Modules.AutoBone == true do
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
			end)
			
			if err then print(err) end
		end
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(-5060.41162109375, 318.50201416015625, -3193.224853515625))
		Char:PivotTo(Char:GetPivot() * CFrame.new(15,50,0))
		task.wait(1)
		Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(a.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = a})
		
		while getgenv().Configuration.Modules.AutoBone do
			task.wait(0.05)
			Attack()
		end
	end	
end

return autobone
