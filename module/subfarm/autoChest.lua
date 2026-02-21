local FirstSeasChests = {
	CFrame.new(1147.56067, 19.7403679, 1260.95337),
	CFrame.new(958.973572, 16.3185673, 1339.90894),
	CFrame.new(-781.18103, 31.5049992, 1606.97498),
	CFrame.new(-1203.08105, 0.504998803, 1871.54602),
	CFrame.new(-387.940002, 0.504998803, 1648.08801),
	CFrame.new(-654.679993, 5.70499563, 1421.47595),
	CFrame.new(-1439.12097, 79.9300079, -2955.59692),
	CFrame.new(-1580.61804, 109.108002, -3333.73804),
	CFrame.new(-1832.09204, 79.1240082, -3054.45605),
	CFrame.new(958.301025390625, 14.088006973266602, 1339.7459716796875),
	CFrame.new(-2528.717041015625, 4.754006862640381, 1979.2020263671875),
	CFrame.new(-2878.488037109375, 22.342004776000977, 2303.76904296875),
	CFrame.new(-2956.06005859375, 38.86699676513672, 2025.4139404296875),
	CFrame.new(-3117.447021484375, 207.114013671875, 2048.069091796875),
	CFrame.new(831.8980102539062, 4.290994167327881, 4365.78515625),
	CFrame.new(908.260986328125, 13.142007827758789, 4567.93798828125),
	CFrame.new(1239.9959716796875, 13.590997695922852, 4525.865234375),
	CFrame.new(1456.1094970703125, -0.02189837396144867, 4384.60888671875),
	CFrame.new(-2834.1220703125, 5.415002346038818, 5484.5830078125),
	CFrame.new(1201.71179, 45.369545, -1253.7146),
	CFrame.new(-387.94000244140625, 0.5049988031387329, 1648.0880126953125),
	CFrame.new(-1609.35888671875, 9.904001235961914, 146.10513305664062),
	CFrame.new(-1177.26904296875, 9.704004287719727, 131.5749969482422),
	CFrame.new(-1128.869140625, 38.334007263183594, -526.4371337890625),
	CFrame.new(-1665.70703125, 20.704004287719727, 329.9750061035156),
	CFrame.new(1202.2469482421875, 43.178001403808594, -1252.6099853515625),
	CFrame.new(1409.10498046875, 53.178001403808594, -1272.404052734375),
}
	
local SecondSeasChests = {
	CFrame.new(-5238.79931640625, 111.73799133300781, -6258.2392578125),
	CFrame.new(-2387.873046875, 71.1729965209961, -2869.718994140625),
	CFrame.new(-2630.079345703125, 70.76406860351562, -3966.360107421875),
	CFrame.new(-2303.556884765625, 71.8030014038086, -4264.97607421875),
	CFrame.new(-1701.342041015625, 71.1729965209961, -3088.489990234375),
	CFrame.new(-1545.5491943359375, 174.45362854003906, -3651.255859375),
	CFrame.new(-1477.1859130859375, 40.88534164428711, -3897.052978515625),
	CFrame.new(-413.65069580078125, 13.964944839477539, 258.1788330078125),
	CFrame.new(-411.2218017578125, 70.9229507446289, 371.271484375),
	CFrame.new(-353.50390625, 70.9229507446289, 371.27154541015625),
	CFrame.new(-894.0555419921875, 184.81260681152344, 658.243896484375),
	CFrame.new(-134.7222900390625, 70.8125991821289, 355.7315368652344),
	CFrame.new(-511.9065856933594, 329.7139587402344, 588.4630126953125),
	CFrame.new(-1014.435302734375, 70.8125991821289, 850.7462768554688),
	CFrame.new(-1070.09130859375, 120.7647476196289, 857.2682495117188)
}

local Plr = game.Players.LocalPlayer

local function Tween(Inst, Info,Properties)
	if not Inst or not Inst.Parent then return end
    local TweenSvc = game:GetService("TweenService")
    local Track = TweenSvc:Create(Inst, Info, Properties)
	getgenv().Configuration.CurrentTweeningProcess = Track
    Track:Play()
    Track.Completed:Wait()
end

function Anchor(Char)
	if Char.PrimaryPart:FindFirstChild("f") == nil then
		local f = Instance.new("BodyVelocity", Char.PrimaryPart)
		f.Name = "f"
		f.P = 15000
		f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		f.Velocity = Vector3.new(0,.01,0)
	end
end

local loop_thread = task.spawn(function()
	Anchor(Char)
	while getgenv().Configuration.Modules.AutoFarmChests do
		local root = Char.PrimaryPart
		if not root then task.wait() continue end
		
		local chestList
		if getgenv().Configuration.CurrentPlace == "First-Seas" then
			chestList = FirstSeasChests
		elseif getgenv().Configuration.CurrentPlace == "Second-Seas" then
			chestList = SecondSeasChests
		end
		
		if chestList then
			for _, chest in pairs(chestList) do
				if not getgenv().Configuration.Modules.AutoFarmChests then break end
				
				local time = Plr:DistanceFromCharacter(chest.Position) / getgenv().Configuration.TweenSpeed
				
				Tween(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = chest})
				task.wait(getgenv().ModuleSetting.AutoFarmChests.Delay)
			end
		end
		task.wait()
	end
end)
