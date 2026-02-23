local autochest = {}

function autochest:Init()
	return function()
		local Plr = game.Players.LocalPlayer
		local Char = Plr.Character
		
		local function Tween(Inst, Info,Properties)
			if not Inst or not Inst.Parent then return end
			local TweenSvc = game:GetService("TweenService")
			local Track = TweenSvc:Create(Inst, Info, Properties)
			getgenv().Configuration.CurrentTweeningProcess = Track
			Track:Play()
			Track.Completed:Wait()
		end
		
		while getgenv().Configuration.Modules.AutoFarmChests do
			for _, chest in pairs(getinstances()) do
				if chest:IsA("BasePart") and string.find(chest.Name, "Chest") then
					if getgenv().ModuleSetting.AutoFarmChests.Method == "Tween" then
						if not getgenv().Configuration.Modules.AutoFarmChests then break end
						
						local time = Plr:DistanceFromCharacter(chest.Position) / getgenv().Configuration.TweenSpeed
								
						Tween(Char.PrimaryPart, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = chest:GetPivot()})
						Char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						task.wait(getgenv().ModuleSetting.AutoFarmChests.Delay)
					elseif getgenv().ModuleSetting.AutoFarmChests.Method == "Teleport" then
						if not getgenv().Configuration.Modules.AutoFarmChests then break end
						
						Char:PivotTo(chest:GetPivot())
						Char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						task.wait(getgenv().ModuleSetting.AutoFarmChests.Delay)
					end
				end
			end
		end
	end
end

return autochest
