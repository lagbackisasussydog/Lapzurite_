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
		
		
		function Anchor(Char)
			if Char.PrimaryPart:FindFirstChild("f") == nil then
				local f = Instance.new("BodyVelocity", Char.PrimaryPart)
				f.Name = "f"
				f.P = 15000
				f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				f.Velocity = Vector3.new(0,.01,0)
			end
		end
		
		local function Tween(Inst, Info,Properties)
			if not Inst or not Inst.Parent then return end
			local TweenSvc = game:GetService("TweenService")
			local Track = TweenSvc:Create(Inst, Info, Properties)
			getgenv().Configuration.CurrentTweeningProcess = Track
			Track:Play()
			Track.Completed:Wait()
		end
		
		local function isAlive(mob)
			if mob.Humanoid and mob.HumanoidRootPart and mob.Humanoid.Health > 0 then
				return true
			end
		end
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(-5060.41162109375, 318.50201416015625, -3193.224853515625))
		Char:PivotTo(Char:GetPivot() * CFrame.new(15,-50,0))
		task.wait(1)
		Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(a.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = a})
		
		while getgenv().Configuration.Modules.AutoBone do
			pcall(function()
				for _, enemy in pairs(Enemies:GetChildren()) do
					if isAlive(enemy) and table.find(MobList, enemy.Name) then
						local eRoot = enemy.HumanoidRootPart
						local eHum = enemy.Humanoid
						
						local time = TweenInfo.new(Plr:DistanceFromCharacter(eRoot.CFrame), Enum.EasingStyle.Linear)
						
						Tween(Root, time, {CFrame = eRoot.CFrame * CFrame.new(0,15,0)})
						
						repeat
							for _, _enemy in pairs(Enemies:GetChildren()) do
								if isAlive(_enemy) and _enemy.Name == enemy.Name and (_enemy.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < getgenv().Configuration.Distance then
									repeat taks.wait(0.01)
										enemy:PivotTo(eRoot.CFrame * CFrame.new(0,15,0))
										_enemy:PivotTo(enemy:GetPivot())
									until _enemy.Humanoid.Health <= 0
								end
							end
						until enemy.Humanoid.Health <= 0
					end
				end
			task.wait()
		end
	end	
end

return autobone
