local ReplicatedStorage = game:GetService("ReplicatedStorage")

local fastAttack = {}

function fastAttack:Init()
	task.spawn(function()
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

function fastAttack:BringMob(Mob)
	local function checkNetworkOwnership(part)
		if part.RecieveAge ~= 0 then
			return true
		else
			return false
		end
	end

	local function GetMob(target)
		if not target or not target.Parent then return end
		
		local targetRoot = target:FindFirstChild("HumanoidRootPart"):Clone()
		local targetHum = target:FindFirstChild("Humanoid")
		
		if not targetRoot or not targetHum or targetHum.Health <= 0 then
			return
		end
		
		local enemiesFolder = workspace:FindFirstChild("Enemies")
		if not enemiesFolder then return end
		
		local enemies = enemiesFolder:GetChildren()
		if #enemies == 0 then return end
		
		for _, enemy in ipairs(enemies) do
			local parts = {}
			if enemy ~= target then
				local eRoot = enemy:FindFirstChild("HumanoidRootPart")
				local eHum = enemy:FindFirstChild("Humanoid")
				
				if eRoot and eHum then
					local distance = (eRoot.Position - targetRoot.Position).Magnitude
					
					if distance < getgenv().Configuration.Distance and checkNetworkOwnership(eRoot) and enemy.Name == target.Name then
						parts[enemy.Name] = {targetRoot, eRoot}
					end
				end
			end
		end
		
		return parts
	end
	
	local function isAlive(mob)
		if mob and mob.Humanoid and mob.HumanoidRootPart and mob.Humanoid.Health > 0 then
			return true
		end
	end
	
	for _, v in pairs(GetMob(Mob)) do
		local target = v[1]
		
		if isAlive(target.Parent) and isAlive(v[2].Parent) then
			v[2].CFrame = target.CFrame
		end
	end
end

return fastAttack
