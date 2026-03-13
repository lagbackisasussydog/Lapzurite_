local autoberries = {}

function autoberries:Init()
	local Plr = game.Players.LocalPlayer
	local Char = Plr.Character
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
			if v:IsA("Model") and v.Parent:IsA("Configuration") and v.Parent.Name == "Berries" then
				local t = Plr:DistanceFromCharacter(v:GetPivot().Position) / getgenv().Configuration.TweenSpeed
				Tween(Root, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = v:GetPivot()})
			end
		end
		task.wait()
	end
end

return autoberries
