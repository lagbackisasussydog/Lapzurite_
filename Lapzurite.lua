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

task.spawn(function()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("SetTeam", "Pirates")
	repeat task.wait() until game.Players.LocalPlayer.Character
	task.wait(5)
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
end)

task.spawn(function()
	if getconnections then
		for _, connection in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
			if connection["Disable"] then
				connection["Disable"](connection)
			elseif connection["Disconnect"] then
				connection["Disconnect"](connection)
			end
		end
	else
		game.Players.LocalPlayer.Idled:Connect(function()
			Services.VirtualUser:CaptureController()
			Services.VirtualUser:ClickButton2(Vector2.new())
		end)
	end
end)

task.spawn(function()
    local HttpService = game:GetService("HttpService")
    local path = "state.txt"
    
    if isfile(path) then
        local content = readfile(path)
        local decoded = HttpService:JSONDecode(content)
        
        for k, v in pairs(decoded) do
            if getgenv().Configuration.Modules[k] ~= nil then
                getgenv().Configuration.Modules[k] = v
            end
        end
    end
end)

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
end}):SetToggle(getgenv().Configuration.Modules.AutoFarmLevel)

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

Tabs.Settings:AddButton({Title = "Fast Mode", Callback = function(State)
	local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CastShadow = false
			v.Material = "Plastic"
			v.Reflectance = 0
			v.BackSurface = "SmoothNoOutlines"
			v.BottomSurface = "SmoothNoOutlines"
			v.FrontSurface = "SmoothNoOutlines"
			v.LeftSurface = "SmoothNoOutlines"
			v.RightSurface = "SmoothNoOutlines"
			v.TopSurface = "SmoothNoOutlines"
		elseif v:IsA("Decal") then
			v.Transparency = 1
			v.Texture = ""
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		end
	end
	for _, v in pairs(Lighting:GetDescendants()) do
		if v:IsA("PostEffect") then
			v.Enabled = false
		end
	end
	workspace.DescendantAdded:Connect(function(child)
		task.spawn(function()
			if child:IsA("ForceField") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire") or child:IsA("Beam") then
				RunService.Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA("BasePart") then
				child.CastShadow = false
			end
		end)
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
