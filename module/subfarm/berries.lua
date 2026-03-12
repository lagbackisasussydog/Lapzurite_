local autoberries = {}

function autoberries:Init()
	local Char = game.Players.LocalPlayer.Character
	local Root = Char.PrimaryPart
	
	local function Tween(Inst, Info,Properties)
		if not Inst or not Inst.Parent then return end
		local TweenSvc = game:GetService("TweenService")
		local Track = TweenSvc:Create(Inst, Info, Properties)
		getgenv().Configuration.CurrentTweeningProcess = Track
		Track:Play()
		Track.Completed:Wait()
	end
	
	while getgenv().Configuration.Modules.AutoBerries do
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Configuration") then
				for i, _v in pairs(v:GetDescendants()) do
					if _v:IsA("Model") then
						local info = TweenInfo.new(game.Players.LocalPlayer:DistanceFromCharacter(_v:GetPivot().Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear)
						Tween(Root, info, {CFrame = _v:GetPivot()})
					end
				end
			end
		end
		task.wait()
	end
end

return autoberries
