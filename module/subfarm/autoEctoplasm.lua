local autoectoplasm ={}

function autoectoplasm:Init()
	return function()
		local CommF_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/CommFManager.lua"))()
		
		local Plr = game.Players.LocalPlayer
		local Enemies = workspace.Enemies
		local Char = Plr.Character
		local Root = Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart")
		local a = CFrame.new(915.097168, 126.002701, 33121.5469, -0.999272764, 2.59584123e-08, 0.038131278, 2.31111841e-08, 1, -7.51098597e-08, -0.038131278, -7.41739754e-08, -0.999272764)
		local MobList = {
			"Ship Deckhand",
			"Ship Engineer",
			"Ship Steward",
			"Ship Officer"
		}
		local b = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/FastAttack.lua"))()
		
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
		
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", vector.create(923.2130126953125, 126.97599792480469, 32852.83203125))
		task.wait(0.2)
		Tween(Root, TweenInfo.new(Plr:DistanceFromCharacter(a.Position) / getgenv().Configuration.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = a})
		
		while getgenv().Configuration.Modules.AutoEctoplasm do
			task.wait(0.05)
			Attack()
		end
	end	
end

return autoectoplasm
