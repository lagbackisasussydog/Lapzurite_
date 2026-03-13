local autofactory = {}

function autofactory:Init()
	return function()
		local Plr = game.Players.LocalPlayer
		local Enemies = workspace.Enemies
		local Char = Plr.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
		local a = CFrame.new(429.071503, 211.429855, -426.440735, 0.844450235, 7.25498737e-08, -0.535634041, -8.5469452e-08, 1, 7.00421665e-10, 0.535634041, 4.51888766e-08, 0.844450235)

		local MobList = {
			"Core"
		}

		local function Tween(Inst, Info,Properties)
			if not Inst or not Inst.Parent then return end
			local TweenSvc = game:GetService("TweenService")
			local Track = TweenSvc:Create(Inst, Info, Properties)
			getgenv().Configuration.CurrentTweeningProcess = Track
			Track:Play()
			Track.Completed:Wait()
		end
			
		local function isAlive(mob)
			if mob and mob.Humanoid and mob.HumanoidRootPart and mob.Humanoid.Health > 0 then
				return true
			end
		end
			
		local function getTool()
			for _, tool in pairs(Plr.Backpack:GetChildren()) do
				if tool:GetAttribute("WeaponType") == getgenv().Configuration.Tool and Char:FindFirstChild(tool.Name) == nil then
					return tool
				end
			end
		end
		
		local function checkNotification()
			local Notification = Plr.PlayerGui:FindFirstChild("Notifications")
			for _, n in pairs(Notification:GetChildren()) do
				if n and n:IsA("TextLabel") and string.find(n.Text, "We are breaching the factory in 30 seconds!") then
					return true
				end
			end
		end
		
		local function Attack()
			local success, err = pcall(function()
				for _ = 1, #Enemies:GetChildren() do
					if _ > 1 then
						local e = Enemies:GetChildren()[1]
						local Tool = getTool()
						
						if isAlive(e) and table.find(MobList, e.Name) then
							Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(e:GetPivot().Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = e:GetPivot() * CFrame.new(0,15,0)})
							
							repeat task.wait()
								local enemy = b:GroupMob(e)
								Char.Humanoid:EquipTool(Tool)
								Char:PivotTo(enemy:GetPivot() * CFrame.new(0,15,0))
							until not isAlive(e) and not isAlive(enemy)
						end
					end
				end
			end)
				
			if err then print(err) end
		end
		
		while getgenv().Configuration.Modules.AutoFactory do
			Attack()
		end
	end
end

return autofactory
