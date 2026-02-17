local Lapzurite = {}
local Window = {}

function Lapzurite:CreateWindow(Theme : string)
	local Lapzurite = Instance.new("ScreenGui")
	local Main = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local UIGradient = Instance.new("UIGradient")
	local UIPadding = Instance.new("UIPadding")
	local ButtonList = Instance.new("ScrollingFrame")
	local UIGridLayout = Instance.new("UIGridLayout")
	local Storage = Instance.new("Folder")
	local BtnColor = Color3.new(0, 0, 0)
	local BgColor = Color3.new(0,0,0)
	local BgColor1 = Color3.new(0, 0, 0)
	local TxtColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(85, 85, 255))}
	
	task.spawn(function()
		if Theme == "Blue" then
			BgColor = Color3.fromRGB(85, 170, 255)
			BgColor1 = Color3.fromRGB(85, 85, 255)
			BtnColor = Color3.fromRGB(43, 87, 130)
			TxtColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(85, 85, 255))}
		elseif Theme == "Red" then
			BgColor = Color3.fromRGB(255, 0, 0)
			BgColor1 = Color3.fromRGB(121, 0, 0)
			BtnColor = Color3.fromRGB(170, 0, 0)
			TxtColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(170, 0, 0))}
		elseif Theme == "Green" then
			BgColor = Color3.fromRGB(72, 216, 0)
			BgColor1 = Color3.fromRGB(0, 91, 0)
			BtnColor = Color3.fromRGB(0, 198, 0)
			TxtColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 76, 0))}
		elseif Theme == "Amethyst" then
			BgColor = Color3.fromRGB(170, 85, 255)
			BgColor1 = Color3.fromRGB(105, 0, 158)
			BtnColor = Color3.fromRGB(170, 0, 255)
			TxtColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(170, 170, 255))}
		elseif Theme == "Pink" then
			
		end
	end)

	Lapzurite.Name = "Lapzurite"
	Lapzurite.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Lapzurite.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = Lapzurite
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Main.BackgroundTransparency = 0.500
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0.445492655, 0, 0.5859375, 0)
	Main.Active = true
	Main.Draggable = true

	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0.470588237, 0, 0.0733333305, 0)
	Title.Font = Enum.Font.SourceSansBold
	Title.Text = "Lapzurite_"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 20.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	UIGradient.Color = TxtColor
	UIGradient.Parent = Title

	UIPadding.Parent = Title
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.PaddingTop = UDim.new(0, 5)

	ButtonList.Name = "ButtonList"
	ButtonList.Parent = Main
	ButtonList.Active = true
	ButtonList.AnchorPoint = Vector2.new(0.5, 0.5)
	ButtonList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ButtonList.BackgroundTransparency = 1.000
	ButtonList.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ButtonList.BorderSizePixel = 0
	ButtonList.Position = UDim2.new(0.169411764, 0, 0.526666641, 0)
	ButtonList.Size = UDim2.new(0.291764706, 0, 0.856666684, 0)
	ButtonList.ScrollBarThickness = 0

	UIGridLayout.Parent = ButtonList
	UIGridLayout.FillDirection = Enum.FillDirection.Vertical
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 6)
	UIGridLayout.CellSize = UDim2.new(0, 124, 0, 30)
	
	Storage.Name = "Storage"
	Storage.Parent = Main
	
	function Window:AddTab(Config)
		local Tabs = {}
		
		local tName = Config.Name

		local Tab = Instance.new("TextButton")
		local UIGradient = Instance.new("UIGradient")

		local Section = Instance.new("ScrollingFrame")
		local UIGridLayout_2 = Instance.new("UIGridLayout")
		local UIGradient_2 = Instance.new("UIGradient")
	
		Tab.Name = tName
		Tab.Parent = ButtonList
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 0.800
		Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(0, 200, 0, 50)
		Tab.Font = Enum.Font.SourceSans
		Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
		Tab.TextSize = 18.000
		Tab.Text = tName

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, BgColor), ColorSequenceKeypoint.new(1.00, BgColor1)}
		UIGradient.Parent = Tab

		Section.Name = tName
		Section.Parent = Storage
		Section.Active = true
		Section.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
		Section.BackgroundTransparency = 0.500
		Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Section.BorderSizePixel = 0
		Section.Position = UDim2.new(0.336470574, 0, 0.0966666639, 0)
		Section.Size = UDim2.new(0.642352939, 0, 0.860000014, 0)
		Section.ScrollBarThickness = 0
		Section.Visible = false
	
		UIGridLayout_2.Parent = Section
		UIGridLayout_2.FillDirection = Enum.FillDirection.Vertical
		UIGridLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout_2.CellPadding = UDim2.new(0, 0, 0, 5)
		UIGridLayout_2.CellSize = UDim2.new(0, 273, 0, 50)

		UIGradient_2.Rotation = -90
		UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient_2.Color = TxtColor
		UIGradient_2.Parent = Section
		
		Tab.MouseButton1Up:Connect(function()
			local function setSectionInvisible()
				for _, frame in pairs(Storage:GetChildren()) do
					if frame:IsA("ScrollingFrame") then
						frame.Visible = false
					end
				end
			end
			
			setSectionInvisible()
			Storage:FindFirstChild(tName).Visible = true
		end)

		function Tabs:AddButton(Config)
			local tName = Config.Title
			local tSubName = Config.SubTitle

			local Button = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIPadding = Instance.new("UIPadding")
			local Subtitle = Instance.new("TextLabel")
			local UIPadding_2 = Instance.new("UIPadding")
			local ImageLabel = Instance.new("ImageLabel")

			Button.Name = "Button"
			Button.Parent = Section
			Button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
			Button.BackgroundTransparency = 0.800
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(0, 200, 0, 50)
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14.000

			UICorner.Parent = Button

			Title.Name = "Title"
			Title.Parent = Button
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.271062285, 0, 0.455000013, 0)
			Title.Size = UDim2.new(0, 148, 0, 22)
			Title.ZIndex = 9999999
			Title.Font = Enum.Font.SourceSans
			Title.Text = Config.Title
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 14.000
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding.Parent = Title
			UIPadding.PaddingLeft = UDim.new(0, 10)
			UIPadding.PaddingTop = UDim.new(0, 5)

			UIPadding_2.Parent = Subtitle
			UIPadding_2.PaddingLeft = UDim.new(0, 10)

			ImageLabel.Parent = Button
			ImageLabel.BackgroundTransparency = 1.000
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(0.857142866, 0, 0.200000003, 0)
			ImageLabel.Size = UDim2.new(0, 30, 0, 30)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=6031091008"
			
			Button.MouseButton1Up:Connect(Config.Callback)
		end
		
		function Tabs:AddToggle(Config)
			local tName = Config.Title
			local State = Config.State or false
			
			local Toggle = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIPadding = Instance.new("UIPadding")
			local ImageLabel = Instance.new("ImageButton")

			Toggle.Name = "Toggle"
			Toggle.Parent = Section
			Toggle.Active = true
			Toggle.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
			Toggle.BackgroundTransparency = 0.800
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Selectable = true
			Toggle.Size = UDim2.new(0, 200, 0, 50)

			UICorner.Parent = Toggle

			Title.Name = "Title"
			Title.Parent = Toggle
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.271062285, 0, 0.455000013, 0)
			Title.Size = UDim2.new(0, 148, 0, 22)
			Title.Font = Enum.Font.SourceSans
			Title.Text = tName
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 14.000
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding.Parent = Title
			UIPadding.PaddingLeft = UDim.new(0, 10)

			ImageLabel.Name = "ImageLabel"
			ImageLabel.Parent = Toggle
			ImageLabel.Active = false
			ImageLabel.BackgroundTransparency = 1.000
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(0.857142866, 0, 0.200000003, 0)
			ImageLabel.Selectable = false
			ImageLabel.Size = UDim2.new(0, 30, 0, 30)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=6031068429"
			ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 0)
			
			local function Toggle()
				State = not State
				
				if State then
					ImageLabel.Image = "http://www.roblox.com/asset/?id=6031068430"
					ImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 0)
				else
					ImageLabel.Image = "http://www.roblox.com/asset/?id=6031068429"
					ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 0)
				end
				Config.Callback(State)
			end
			
			ImageLabel.MouseButton1Up:Connect(Toggle)
		end
	
		function Tabs:AddSlider(Config)
			local outputValue = Config.Min
			
			local Slider = Instance.new("CanvasGroup")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIPadding = Instance.new("UIPadding")
			local Fill = Instance.new("Frame")
			local Trigger = Instance.new("TextButton")
			local UICorner_3 = Instance.new("UICorner")

			Slider.Name = "Slider"
			Slider.Parent = Section
			Slider.Active = true
			Slider.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
			Slider.BackgroundTransparency = 0.800
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Selectable = true
			Slider.Size = UDim2.new(0, 200, 0, 50)

			UICorner.Parent = Slider

			Title.Name = "Title"
			Title.Parent = Slider
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.271062285, 0, 0.455000013, 0)
			Title.Size = UDim2.new(0, 148, 0, 22)
			Title.ZIndex = 9999999
			Title.Font = Enum.Font.SourceSans
			Title.Text = Config.Title .. ": " .. outputValue
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 14.000
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding.Parent = Title
			UIPadding.PaddingLeft = UDim.new(0, 10)

			Fill.Name = "Fill"
			Fill.Parent = Slider
			Fill.Active = true
			Fill.BackgroundColor3 = BgColor
			Fill.BackgroundTransparency = 0.800
			Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Fill.BorderSizePixel = 0
			Fill.Selectable = true
			Fill.Size = UDim2.new(outputValue, 0, 1, 0)

			Trigger.Name = "Trigger"
			Trigger.Parent = Slider
			Trigger.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			Trigger.BackgroundTransparency = 1.000
			Trigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Trigger.BorderSizePixel = 0
			Trigger.Size = UDim2.new(0, 273, 0, 50)
			Trigger.Font = Enum.Font.SourceSans
			Trigger.Text = ""
			Trigger.TextColor3 = Color3.fromRGB(0, 0, 0)
			Trigger.TextSize = 14.000

			UICorner_3.Parent = Trigger
			
			local State = false
			
			local function UpdateSlider()
				local output = math.clamp((game.Players.LocalPlayer:GetMouse().X - Slider.AbsolutePosition.X)/ Slider.AbsoluteSize.X,0,1)
				
				outputValue = (Config.Min / 100) + (output * ((Config.Max / 100) - (Config.Min / 100)))
				
				Fill.Size = UDim2.fromScale(output, 1)
				Title.Text = Config.Title .. ": " .. math.round(outputValue * 100)
				Config.Callback(math.round(outputValue * 100))
			end
			
			local function ActivateSlider()
				State = true
				while State do
					UpdateSlider()
					task.wait()
				end
			end
			
			Trigger.MouseButton1Down:Connect(ActivateSlider)
			
			game.UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					State = false
				end	
			end)
		end
		
		function Tabs:AddDropdown(Config)
			local Dropdown = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")
			local UIPadding = Instance.new("UIPadding")
			local ImageLabel = Instance.new("ImageButton")

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Section
			Dropdown.Active = true
			Dropdown.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
			Dropdown.BackgroundTransparency = 0.800
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Selectable = true
			Dropdown.Size = UDim2.new(0, 200, 0, 50)

			UICorner.Parent = Dropdown

			Title.Name = "Title"
			Title.Parent = Dropdown
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.271062285, 0, 0.455000013, 0)
			Title.Size = UDim2.new(0, 148, 0, 22)
			Title.ZIndex = 9999999
			Title.Font = Enum.Font.SourceSans
			Title.Text = Config.Title
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 14.000
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding.Parent = Title
			UIPadding.PaddingLeft = UDim.new(0, 10)

			ImageLabel.Name = "ImageLabel"
			ImageLabel.Parent = Dropdown
			ImageLabel.Active = false
			ImageLabel.BackgroundTransparency = 1.000
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(0.857142866, 0, 0.200000003, 0)
			ImageLabel.Rotation = 90.000
			ImageLabel.Selectable = false
			ImageLabel.Size = UDim2.new(0, 30, 0, 30)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=6031091008"
			
			local DropdownMenu = Instance.new("ScrollingFrame")
			local UIGridLayout = Instance.new("UIGridLayout")

			DropdownMenu.Name = "DropdownMenu"
			DropdownMenu.Parent = Main
			DropdownMenu.Active = true
			DropdownMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			DropdownMenu.BackgroundTransparency = 0.500
			DropdownMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownMenu.BorderSizePixel = 0
			DropdownMenu.Position = UDim2.new(0,0,1,0)
			DropdownMenu.Size = UDim2.new(1, 0, 0, 83)
			DropdownMenu.ScrollBarThickness = 0
			DropdownMenu.Visible = false
			
			UIGridLayout.Parent = DropdownMenu
			UIGridLayout.FillDirection = Enum.FillDirection.Vertical
			UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
			UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)
			
			task.spawn(function()
				for _, v in pairs(Config.List) do
					if typeof(v) == "string" then
						local TextButton = Instance.new("TextButton")
						
						TextButton.Name = v
						TextButton.Parent = DropdownMenu
						TextButton.BackgroundColor3 = BtnColor
						TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BorderSizePixel = 0
						TextButton.Position = UDim2.new(0, 0, -0.00681319181, 0)
						TextButton.Size = UDim2.new(0, 200, 0, 50)
						TextButton.Font = Enum.Font.SourceSans
						TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.TextSize = 14.000
						TextButton.Text = v
						
						TextButton.MouseButton1Up:Connect(function()
							Config.Callback(v)
							DropdownMenu.Visible = false
							ImageLabel.Rotation = 90
						end)
					end
				end
			end)
			
			ImageLabel.MouseButton1Up:Connect(function()
				DropdownMenu.Visible = not DropdownMenu.Visible
				
				if DropdownMenu.Visible then
					ImageLabel.Rotation = -90
				else
					ImageLabel.Rotation = 90
				end
			end)
		end
	
		return Tabs
	end

	return Window
end

return Lapzurite
