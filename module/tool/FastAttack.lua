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
			
			HitRemote:FireServer(unpack(Args))
			AttackRemote:FireServer(0)
		end
	end
end

function fastAttack:MultipleAttack(Char, HeadParts)
	local HitRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
	local AttackRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
	
	if Chat and HeadParts then
		for _, head in pairs(HeadParts) do
			if head then
				local Args = {
				[1] = head,
				[2] = {},
				[3] = "89134891234"
			}
			
			HitRemote:FireServer(unpack(Args))
			AttackRemote:FireServer(0)
			end
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
			Target.Humanoid:TakeDamage(99999999)
		end
	end
end

return fastAttack
