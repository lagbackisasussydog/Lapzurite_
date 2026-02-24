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
		
		local function Tween(Inst, Info,Properties)
			if not Inst or not Inst.Parent then return end
			local TweenSvc = game:GetService("TweenService")
			local Track = TweenSvc:Create(Inst, Info, Properties)
			getgenv().Configuration.CurrentTweeningProcess = Track
			Track:Play()
			Track.Completed:Wait()
		end
		
		CommF_:requestEntrance(vector.create(-5060.41162109375, 318.50201416015625, -3193.224853515625))
		Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(a.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = a})
		while getgenv().Configuration.Modules.AutoBone do
			for _, enemy in pairs(Enemies:GetChildren()) do
				if enemy and enemy.Humanoid.Health > 0 and table.find(MobList, enemy.Name) then
					local enemyRoot = enemy.PrimaryPart
					local enemyHum = enemy.Humanoid
					
					if enemyRoot then
						Tween(Root, TweenInfo.new(game.Players.LocalPlayer:DistanceFromCharacter(enemyRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = enemyRoot.CFrame * CFrame.new(0,15,0)})
						
						repeat
							for _, _enemy in pairs(Enemies:GetChildren()) do
								if _enemy.Humanoid and _enemy.Humanoid.Health > 0 and _enemy.Name == enemy.Name then
									_enemy:PivotTo(enemy:GetPivot())
								end
							end
						until enemyHum.Health <= 0
					end
				end
			end
			task.wait()
		end
	end	
end

return autobone
