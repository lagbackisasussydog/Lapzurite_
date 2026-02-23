local autobone ={}

local function autobone:Init()
	return function()
		local Enemies = workspace.Enemies
		local Char = game.Players.LocalPlayer.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
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
		
		while getgenv().Configuration.Modules.AutoBone do
			for _, enemy in pairs(Enemies:GetChildren()) do
				if enemy and enemy.Humanoid.Health > 0 and MobList[enemy.Name] then
					local enemyRoot = enemy.PrimaryPart
					local enemyHum = enemy.Humanoid
				
					Tween(Root, TweenInfo.new(game.Players.LocalPlayer:DistanceFromCharacter(enemyRoot.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = enemyRoot.CFrame * CFrame.new(0,15,0)})
					
					repeat
						for _, _enemy in pairs(Enemies:GetChildren()) do
							if _enemy.Humanoid and _enemy.Humanoid.Health > 0 and _enemy.Name == enemy then
								_enemy:PivotTo(enemy:GetPivot())
							end
						end
					until enemyHum.Health <= 0
				end
			end
			task.wait()
		end
	end	
end

return autobone
