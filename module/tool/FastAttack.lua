local ReplicatedStorage = game:GetService("ReplicatedStorage")

local fastAttack = {}

function fastAttack:PerformAttack()
	local remote, idremote
	for _, v in next, ({game.ReplicatedStorage.Util, game.ReplicatedStorage.Common, game.ReplicatedStorage.Remotes, game.ReplicatedStorage.Assets, game.ReplicatedStorage.FX}) do
		for _, n in next, v:GetChildren() do
			if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
				remote, idremote = n, n:GetAttribute("Id")				
			end
		end
		v.ChildAdded:Connect(function(n)
			if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
				remote, idremote = n, n:GetAttribute("Id")
			end
		end)
	end
	task.spawn(function()
		while task.wait(0.05) do
			local char = game.Players.LocalPlayer.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local parts = {}
			for _, x in ipairs({workspace.Enemies, workspace.Characters}) do
				for _, v in ipairs(x and x:GetChildren() or {}) do
					local hrp = v:FindFirstChild("HumanoidRootPart")
					local hum = v:FindFirstChild("Humanoid")
					if v ~= char and hrp and hum and hum.Health > 0 and (hrp.Position - root.Position).Magnitude <= 60 then
						for _, _v in ipairs(v:GetChildren()) do
							if _v:IsA("BasePart") and (hrp.Position - root.Position).Magnitude <= 60 then
								parts[#parts+1] = {v, _v}
							end
						end
					end
				end
			end
			local tool = char:FindFirstChildOfClass("Tool")
			if #parts > 0 and tool and (tool:GetAttribute("WeaponType") == "Melee" or tool:GetAttribute("WeaponType") == "Sword") then
				pcall(function()
					require(game.ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true)
					game.ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer()
					local head = parts[1][1]:FindFirstChild("Head")
					if not head then return end
					game.ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(head, parts, {}, tostring(game.Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15))
					cloneref(remote):FireServer(string.gsub("RE/RegisterHit", ".", function(c)
						return string.char(bit32.bxor(string.byte(c), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1))
					end),
					bit32.bxor(idremote + 909090, game.ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), head, parts)
				end)
			end
		end
	end)
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
	
	for _, n in next, ({Enemies, Characters}) do
		for _, Target in pairs(n:GetChildren()) do
			local TargetHumanoid = Target:FindFirstChild("Humanoid")
			if Target ~= Char and TargetHumanoid and TargetHumanoid.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Target:GetPivot().Position) < getgenv().Configuration.Distance then
				return Target
			end
		end
	end
end

return fastAttack
