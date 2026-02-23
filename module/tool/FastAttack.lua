local ReplicatedStorage = game:GetService("ReplicatedStorage")

local fastAttack = {}

function fastAttack:PerformAttack(Char, Target)
	local HitRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
	local AttackRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
	
	if Char and Target then
		local Head = Target.Head
		
		if Head then
			local Args = {
				[1] = Head,
				[2] = {},
				[3] = "89134891234"
			}
			
			require(ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true)
			AttackRemote:FireServer(0)
			HitRemote:FireServer(unpack(Args))
		end
	end
end

function fastAttack:InstantKillSpoof(Char, Target)
	local HitRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
	local AttackRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
	
	if Char and Target then
		local Head = Target.Head
		
		if Head then
			local Args = {
				[1] = Head,
				[2] = {},
				[3] = "89134891234"
			}
			
			HitRemote:FireServer(unpack(Args))
			AttackRemote:FireServer(0)
			Target.Humanoid:BreakJoints()
		end
	end
end

function fastAttack:ReturnNearbyTargetLoop(Char)
	local Enemies, Characters = workspace.Enemies, workspace.Characters
	
	while task.wait(0.05) do
		for _, Target in ipairs({Enemies, Characters} or {}) do
			local TargetHumanoid = Target:FindFirstChild("Humanoid")
			if Target ~= Char and TargetHumanoid and TargetHumanoid.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Target:GetPivot().Position) < getgenv().Configuration.Distance then
				return Target
			end
		end
	end
end

return fastAttack
