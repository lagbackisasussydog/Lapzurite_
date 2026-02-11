local Lapzurite = {}

function Lapzurite:Init(stopFunction)
	local Lapzurite = Instance.new("ScreenGui")
	local Base = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local UIGradient = Instance.new("UIGradient")
	local SubTitle = Instance.new("TextLabel")
	local Stop = Instance.new("TextButton")

	Lapzurite.Name = "Lapzurite"
	Lapzurite.Parent = game.CoreGui
	Lapzurite.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Base.Name = "Base"
	Base.Parent = Lapzurite
	Base.AnchorPoint = Vector2.new(0.5, 0.5)
	Base.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Base.BackgroundTransparency = 0.750
	Base.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Base.BorderSizePixel = 0
	Base.Position = UDim2.new(0.499478638, 0, 0.5, 0)
	Base.Size = UDim2.new(0.312825859, 0, 0.48828125, 0)

	Title.Name = "Title"
	Title.Parent = Base
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0666666701, 0, 0, 0)
	Title.Size = UDim2.new(0.666666687, 0, 0.200000003, 0)
	Title.Font = Enum.Font.TitilliumWeb
	Title.Text = "Lapzurite_"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(85, 85, 255))}
	UIGradient.Parent = Title

	SubTitle.Name = "SubTitle"
	SubTitle.Parent = Base
	SubTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SubTitle.BackgroundTransparency = 1.000
	SubTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SubTitle.BorderSizePixel = 0
	SubTitle.Position = UDim2.new(0.333333343, 0, 0.100000001, 0)
	SubTitle.Size = UDim2.new(0.666666687, 0, 0.200000003, 0)
	SubTitle.Font = Enum.Font.Michroma
	SubTitle.Text = "Special AutoBounty Edition"
	SubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	SubTitle.TextSize = 12.000
	SubTitle.TextWrapped = true

	Stop.Name = "Stop"
	Stop.Parent = Base
	Stop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Stop.BackgroundTransparency = 1.000
	Stop.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Stop.BorderSizePixel = 0
	Stop.Position = UDim2.new(0.166666672, 0, 0.400000006, 0)
	Stop.Size = UDim2.new(0.666666687, 0, 0.200000003, 0)
	Stop.Font = Enum.Font.SourceSans
	Stop.Text = "Stop Instance"
	Stop.TextColor3 = Color3.fromRGB(255, 255, 255)
	Stop.TextSize = 20.000
	Stop.TextWrapped = true
	
	Stop.MouseButton1Up:Connect(stopFunction)
end

return Lapzurite
