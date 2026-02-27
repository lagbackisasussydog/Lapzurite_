task.spawn(function()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("SetTeam", "Pirates")
	repeat task.wait() until game.Players.LocalPlayer.Character
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
end)

local Lapzurite = {}
local Window = {}

local BtnColor = Color3.new(0, 0, 0)
local BgColor = Color3.new(0,0,0)
local BgColor1 = Color3.new(0, 0, 0)
local TxtColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(85, 85, 255))}

getgenv().Configuration = {
	["Tool"] = "Melee",
	["TweenSpeed"] = 250,
	["BringSpeed"] = 250,
	["CurrentPlace"] = "",
	["CurrentTweeningProcess"] = nil,
	["Distance"] = 50,
	["Modules"] = {
		["AutoFarmLevel"] = false,
		["AutoFarmChests"] = false,
		["AutoFactory"] = false,
		["AutoKatakuri"] = false,
		["AutoBone"] = false,
		["Travel"] = false,
		["AutoEctoplasm"] = false
	},
}

getgenv().ModuleSetting = {
	["AutoFarmChests"] = {
		["Delay"] = .5,
		["Method"] = "Tween",
	},
	["AutoBone"] = {
		["getQuest"] = false,
	}
}

getgenv().Threads = {}

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/ui/lapzuriteUI.lua"))()
local ThreadManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/ThreadManager.lua"))()

local Plr = game.Players.LocalPlayer

local a = {
	[1] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoChest.lua"))(),
	[2] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/FastAttack.lua"))(),
	[3] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoBone.lua"))(),
	[4] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoKatakuri.lua"))(),
	[5] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoFactory.lua"))(),
	[6] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoEctoplasm.lua"))(),
	[7] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/autofarm/autoFarm.lua"))()
}

local Win = UI:CreateWindow(getgenv().Theme or "Amethyst", nil)
local Tabs = {
	AutoFarm = Win:AddTab({Name = "AutoFarm"}),
	SubFarm = Win:AddTab({Name = "SubFarm"}),
	Settings = Win:AddTab({Name = "Settings"}),
}

local function Pause()
	local Track = getgenv().Configuration.CurrentTweeningProcess
	if Track and Track.PlaybackState == Enum.PlaybackState.Playing then
		Track:Pause()
		getgenv().Configuration.CurrentTweeningProcess = nil
	end
	
	for _, v in pairs(Plr.Character.PrimaryPart:GetChildren()) do
		if v.Name == "f" and v:IsA("BodyVelocity") then
			v:Destroy()
		end
	end
end

function Anchor(Char)
	if Char.PrimaryPart:FindFirstChild("f") == nil then
		local f = Instance.new("BodyVelocity", Char.PrimaryPart)
		f.Name = "f"
		f.P = 15000
		f.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		f.Velocity = Vector3.new(0,.01,0)
	end
	
	for _, a in pairs(Char:GetDescendants()) do
		if a:IsA("BasePart") then
			a.CanCollide = false
		end
	end
end

function activate()
	if Plr.Character:FindFirstChild("HasBuso") then return end
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
end

task.spawn(function()
	if game.PlaceId == 7449423635 then
		getgenv().Configuration.CurrentPlace = "Third-Seas"
	elseif game.PlaceId == 4442272183 then
		getgenv().Configuration.CurrentPlace = "Second-Seas"
	elseif game.PlaceId == 2753915549 then
		getgenv().Configuration.CurrentPlace = "First-Seas"
	end
end)

Plr.CharacterAdded:Connect(function(newChar)
	task.wait(5)
	activate()
	Anchor(newChar)
	ThreadManager:ResetThread()
end)

Tabs.AutoFarm:AddToggle({Title = "Auto Farm", Callback = function(State)
	getgenv().Configuration.Modules.AutoFarmLevel = State
	Anchor(Plr.Character)
	if State then
		ThreadManager:StartThread("autoFarm")
	else
		ThreadManager:CloseThread("autoFarm")
		Pause()
	end
end})

Tabs.SubFarm:AddToggle({Title = "Auto Chest", Callback = function(State)
	getgenv().Configuration.Modules.AutoFarmChests = State
	Anchor(Plr.Character)
	if State then
		ThreadManager:StartThread("autoChest")
	else
		ThreadManager:CloseThread("autoChest")
		Pause()
	end
end})

Tabs.SubFarm:AddDropdown({Title = "Mode", List = {"Tween", "Teleport"}, Callback = function(Value)
	getgenv().ModuleSetting.AutoFarmChests.Method = Value
end})

Tabs.SubFarm:AddSlider({Title = "Delay", Min = 0, Max = 5, Callback = function(Value)
	getgenv().ModuleSetting.AutoFarmChests.Delay = Value
end})

Tabs.SubFarm:AddToggle({Title = "Auto Bone", Callback = function(State)
	if getgenv().Configuration.CurrentPlace == "Third-Seas" then
		getgenv().Configuration.Modules.AutoBone = State
		Anchor(Plr.Character)
		if State then
			ThreadManager:StartThread("autoBone")
		else
			ThreadManager:CloseThread("autoBone")
			Pause()
		end
	else
		UI:Alarm({Content = "Requirement not sufficient!"})
	end
end})

Tabs.SubFarm:AddToggle({Title = "Auto Katakuri", Callback = function(State)
	if getgenv().Configuration.CurrentPlace == "Third-Seas" then
		getgenv().Configuration.Modules.AutoKatakuri = State
		Anchor(Plr.Character)
		if State then
			ThreadManager:StartThread("autoKatakuri")
		else
			ThreadManager:CloseThread("autoKatakuri")
			Pause()
		end
	else
		UI:Alarm({Content = "Requirement not sufficient!"})
	end
end})

Tabs.SubFarm:AddToggle({Title = "Auto Factory", Callback = function(State)
	if getgenv().Configuration.CurrentPlace == "Second-Seas" then
		getgenv().Configuration.Modules.AutoFactory = State
		Anchor(Plr.Character)
		if State then
			ThreadManager:StartThread("autoFactory")
		else
			ThreadManager:CloseThread("autoFactory")
			Pause()
		end
	else
		UI:Alarm({Content = "Requirement not sufficient!"})
	end
end})

Tabs.SubFarm:AddToggle({Title = "Auto Farm Ectoplasm", Callback = function(State)
	if getgenv().Configuration.CurrentPlace == "Second-Seas" then
		getgenv().Configuration.Modules.AutoEctoplasm = State
		Anchor(Plr.Character)
		if State then
			ThreadManager:StartThread("autoEctoplasm")
		else
			ThreadManager:CloseThread("autoEctoplasm")
			Pause()
		end
	else
		UI:Alarm({Content = "Requirement not sufficient!"})
	end
end})

Tabs.Settings:AddSlider({Title = "Tween speed", Min = 0, Max = 300, Callback = function(Value)
	getgenv().Configuration.TweenSpeed = Value
end})

Tabs.Settings:AddSlider({Title = "Bring range", Min = 0, Max = 300, Callback = function(Value)
	getgenv().Configuration.Distance = Value
end})

Tabs.Settings:AddSlider({Title = "Bring speed", Min = 0, Max = 500, Callback = function(Value)
	getgenv().Configuration.BringSpeed = Value
end})

Tabs.Settings:AddDropdown({Title = "Weapon", List = {"Melee", "Sword"}, Callback = function(Value)
	getgenv().Configuration.Tool = Value
end})

Tabs.Settings:AddButton({Title = "Fast Mode (Tuandz script @elratio for removl)", Callback = function()
	pcall(function()
		repeat task.wait() until game:IsLoaded()

		local Tuandz = game:GetService("Lighting")
		local tuanaov = game:GetService("Workspace")
		local bestaov = game:GetService("RunService")
		local tuanbuff = game:GetService("Players").LocalPlayer
		local tuandz_cam = tuanaov.CurrentCamera
		local tuandz_mat = game:GetService("MaterialService")

		pcall(function()
			Tuandz.Technology = Enum.Technology.Future
			tuandz_mat.Use2022Materials = true
		end)

		for _,v in ipairs(Tuandz:GetChildren()) do
			if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("PostEffect") then
				v:Destroy()
			end
		end

		Tuandz.GlobalShadows = true
		Tuandz.ShadowSoftness = 0.2
		Tuandz.Brightness = 5
		Tuandz.ExposureCompensation = 0.6
		Tuandz.EnvironmentDiffuseScale = 1.2
		Tuandz.EnvironmentSpecularScale = 1.3
		Tuandz.Ambient = Color3.fromRGB(70,70,70)
		Tuandz.OutdoorAmbient = Color3.fromRGB(160,165,180)

		local s = Instance.new("Sky")
		s.SkyboxBk = "rbxassetid://159454299"
		s.SkyboxDn = "rbxassetid://159454296"
		s.SkyboxFt = "rbxassetid://159454293"
		s.SkyboxLf = "rbxassetid://159454286"
		s.SkyboxRt = "rbxassetid://159454300"
		s.SkyboxUp = "rbxassetid://159454288"
		s.SunAngularSize = 12
		s.Parent = Tuandz

		local a = Instance.new("Atmosphere")
		a.Density = 0.18
		a.Offset = 0.1
		a.Color = Color3.fromRGB(235,240,255)
		a.Decay = Color3.fromRGB(180,185,200)
		a.Glare = 0.08
		a.Haze = 0.9
		a.Parent = Tuandz

		local cc = Instance.new("ColorCorrectionEffect")
		cc.Brightness = 0.12
		cc.Contrast = 0.45
		cc.Saturation = 0.35
		cc.Parent = Tuandz

		local bloom = Instance.new("BloomEffect")
		bloom.Intensity = 0.35
		bloom.Size = 28
		bloom.Threshold = 0.9
		bloom.Parent = Tuandz

		task.spawn(function()
			for _,p in ipairs(tuanaov:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CastShadow = true
					if p.Material == Enum.Material.Plastic then
						p.Material = Enum.Material.SmoothPlastic
						p.Reflectance = 0.05
					elseif p.Material == Enum.Material.Metal then
						p.Reflectance = math.clamp(p.Reflectance + 0.25,0,0.8)
					end
				end
			end
		end)

		local function buffFX(o)
			if o:IsA("ParticleEmitter") then
				pcall(function()
					o.Size = NumberSequence.new(2)
					o.Rate = o.Rate * 2
					o.LightEmission = math.clamp(o.LightEmission + 0.6,0,1)
				end)
			end
			if o:IsA("Trail") then
				pcall(function()
					o.WidthScale = NumberSequence.new(1.8)
					o.LightEmission = math.clamp(o.LightEmission + 0.7,0,1)
				end)
			end
			if o:IsA("Beam") then
				pcall(function()
					o.Width0 = o.Width0 * 1.8
					o.Width1 = o.Width1 * 1.8
					o.LightEmission = math.clamp(o.LightEmission + 0.7,0,1)
				end)
			end
			if o:IsA("PointLight") or o:IsA("SpotLight") then
				pcall(function()
					o.Brightness = o.Brightness * 2
					o.Range = o.Range * 1.6
				end)
			end
		end

		for _,o in ipairs(tuanaov:GetDescendants()) do
			buffFX(o)
		end
		tuanaov.DescendantAdded:Connect(buffFX)

		local flash = Instance.new("ColorCorrectionEffect")
		flash.Brightness = 0
		flash.Parent = Tuandz

		local aura
		local after = 0
		local shake = 0
		local t = 0

		local function char(c)
			local r = c:WaitForChild("HumanoidRootPart")
			if r:FindFirstChild("TuandzAura") then r.TuandzAura:Destroy() end
			aura = Instance.new("PointLight")
			aura.Name = "TuandzAura"
			aura.Color = Color3.fromRGB(255,230,200)
			aura.Brightness = 2
			aura.Range = 22
			aura.Parent = r
		end

		if tuanbuff.Character then char(tuanbuff.Character) end
		tuanbuff.CharacterAdded:Connect(char)

		local function afterimg(c)
			for _,b in ipairs(c:GetChildren()) do
				if b:IsA("BasePart") and b.Transparency < 1 then
					local g = b:Clone()
					g.Anchored = true
					g.CanCollide = false
					g.Transparency = 0.5
					g.Material = Enum.Material.Neon
					g.Color = Color3.fromRGB(255,240,220)
					g.Parent = tuanaov
					task.delay(0.12,function() g:Destroy() end)
				end
			end
		end

		bestaov.RenderStepped:Connect(function(dt)
			t += dt
			flash.Brightness = math.sin(t * 8) * 0.04

			if tuanbuff.Character and aura then
				local h = tuanbuff.Character:FindFirstChildOfClass("Humanoid")
				if h then
					local s = h.MoveDirection.Magnitude
					aura.Brightness = 1.8 + s * 2
					aura.Range = 20 + s * 14
					if s > 0.6 then
						after += dt
						if after > 0.08 then
							after = 0
							afterimg(tuanbuff.Character)
						end
					end
				end
			end

			if shake > 0 then
				shake -= dt
				tuandz_cam.CFrame = tuandz_cam.CFrame * CFrame.new(
					math.random(-3,3)/120,
					math.random(-3,3)/120,
					0
				)
			end
		end)

		tuanaov.DescendantAdded:Connect(function(o)
			if o:IsA("ParticleEmitter") or o:IsA("Beam") then
				shake = 0.18
			end
		end)

		Tuandz.ClockTime = 14
		Tuandz.GeographicLatitude = 30
	end)
end})

-- Add Thread
ThreadManager:AddThread("autoChest", a[1]:Init())
ThreadManager:AddThread("autoBone", a[3]:Init())
ThreadManager:AddThread("autoKatakuri", a[4]:Init())
ThreadManager:AddThread("autoFactory", a[5]:Init())
ThreadManager:AddThread("autoEctoplasm", a[6]:Init())
ThreadManager:AddThread("autoFarm", a[7]:Init())
ThreadManager:AddThread("killMob", a[2]:PerformAttack())

-- Execute
ThreadManager:StartThread("killMob")
