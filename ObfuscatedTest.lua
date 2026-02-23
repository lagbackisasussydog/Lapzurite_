getgenv().Configuration = {
	["Tool"] = "Melee",
	["TweenSpeed"] = 250,
	["CurrentPlace"] = "",
	["CurrentTweeningProcess"] = nil,
	["Distance"] = 50,
	["Modules"] = {
		["AutoFarmLevel"] = false,
		["AutoFarmChests"] = false,
		["CompleteRaid"] = false,
		["AutoKatakuri"] = false,
		["AutoBone"] = false,
		["Travel"] = false,
	},
}

getgenv().ModuleSetting = {
	["AutoFarmChests"] = {
		["Delay"] = .5,
		["Method"] = "Tween",
	}
}

getgenv().Threads = {}

task.spawn(function()
	if game.PlaceId == 7449423635 then
		getgenv().Configuration.CurrentPlace = "Third-Seas"
	elseif game.PlaceId == 4442272183 then
		getgenv().Configuration.CurrentPlace = "Second-Seas"
	elseif game.PlaceId == 2753915549 then
		getgenv().Configuration.CurrentPlace = "First-Seas"
	end
end)

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/ui/lapzuriteUI.lua"))()
local ThreadManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/ThreadManager.lua"))()

local Plr = game.Players.LocalPlayer

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
end

local Win = UI:CreateWindow("Amethyst", nil)
local Tabs = {
	AutoFarm = Win:AddTab({Name = "AutoFarm"}),
	SubFarm = Win:AddTab({Name = "SubFarm"}),
	Settings = Win:AddTab({Name = "Settings"}),
}

Plr.CharacterAdded:Connect(function()
	ThreadManager:ResetThread()
end)

local a = {
	[1] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoChest.lua"))(),
	[2] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/tool/FastAttack.lua"))(),
	--[3] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoBone.lua"))(),
}

-- Add Thread
ThreadManager:AddThread("autoChest", a[1]:Init())
--ThreadManager:AddThread("autoBone", a[3]:Init())
ThreadManager:AddThread("killMob", a[2]:PerformAttack())

-- Execute
ThreadManager:StartThread("killMob")

Tabs.SubFarm:AddToggle({Title = "AutoFarm Chest", Callback = function(State)
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

Tabs.Settings:AddSlider({Title = "Delay", Min = 0, Max = 5, Callback = function(Value)
	getgenv().ModuleSetting.AutoFarmChests.Delay = Value
end})

Tabs.Settings:AddSlider({Title = "Tween speed", Min = 0, Max = 300, Callback = function(Value)
	getgenv().Configuration.TweenSpeed = Value
end})
