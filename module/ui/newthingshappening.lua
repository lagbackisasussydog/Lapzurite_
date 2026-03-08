local Lapzurite = {}

function Lapzurite:Window()
	local G2L = {}
	local Window = {}

	G2L["1"] = Instance.new("ScreenGui", game.CoreGui);
	G2L["1"]["Name"] = [[Lapzurite]];
	G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

	G2L["2"] = Instance.new("CanvasGroup", G2L["1"]);
	G2L["2"]["BorderSizePixel"] = 0;
	G2L["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["2"]["Size"] = UDim2.new(0, 400, 0, 300);
	G2L["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
	G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["2"]["Name"] = [[Main]];
	G2L["2"]["BackgroundTransparency"] = 0.6;
	G2L["2"]["GroupTransparency"] = 1;

	G2L["3"] = Instance.new("UICorner", G2L["2"]);

	G2L["4"] = Instance.new("TextLabel", G2L["2"]);
	G2L["4"]["BorderSizePixel"] = 0;
	G2L["4"]["TextSize"] = 14;
	G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	G2L["4"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["4"]["BackgroundTransparency"] = 1;
	G2L["4"]["Size"] = UDim2.new(0, 400, 0, 27);
	G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["4"]["Text"] = [[Lapzurite - v1.5]];
	G2L["4"]["Name"] = [[Title]];

	G2L["5"] = Instance.new("UIPadding", G2L["4"]);
	G2L["5"]["PaddingRight"] = UDim.new(0.75, 0);

	G2L["6"] = Instance.new("UIStroke", G2L["4"]);
	G2L["6"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
	G2L["6"]["Color"] = Color3.fromRGB(255, 255, 255);

	G2L["7"] = Instance.new("UIGradient", G2L["6"]);
	G2L["7"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(0.597, 0.23125),NumberSequenceKeypoint.new(1.000, 1)};
	G2L["7"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(86, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

	G2L["8"] = Instance.new("ImageButton", G2L["2"]);
	G2L["8"]["BorderSizePixel"] = 0;
	G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["8"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["8"]["Image"] = [[http://www.roblox.com/asset/?id=6031094678]];
	G2L["8"]["Size"] = UDim2.new(0, 27, 0, 27);
	G2L["8"]["BackgroundTransparency"] = 1;
	G2L["8"]["Name"] = [[Close]];
	G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["8"]["Position"] = UDim2.new(0.965, 0, 0.045, 0);

	G2L["9"] = Instance.new("ImageButton", G2L["2"]);
	G2L["9"]["BorderSizePixel"] = 0;
	G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["9"]["Image"] = [[http://www.roblox.com/asset/?id=6023426928]];
	G2L["9"]["Size"] = UDim2.new(0, 27, 0, 27);
	G2L["9"]["BackgroundTransparency"] = 1;
	G2L["9"]["Name"] = [[Minimize]];
	G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["9"]["Position"] = UDim2.new(0.8975, 0, 0.045, 0);

	G2L["a"] = Instance.new("ScrollingFrame", G2L["2"]);
	G2L["a"]["Active"] = true;
	G2L["a"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
	G2L["a"]["BorderSizePixel"] = 0;
	G2L["a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["a"]["Name"] = [[ButtonList]];
	G2L["a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["a"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
	G2L["a"]["Size"] = UDim2.new(0, 45, 0, 250);
	G2L["a"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["a"]["Position"] = UDim2.new(0.08, 0, 0.535, 0);
	G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["a"]["ScrollBarThickness"] = 0;
	G2L["a"]["BackgroundTransparency"] = 0.8;

	G2L["b"] = Instance.new("UIStroke", G2L["a"]);
	G2L["b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
	G2L["b"]["Color"] = Color3.fromRGB(255, 255, 255);

	G2L["c"] = Instance.new("UIGradient", G2L["b"]);
	G2L["c"]["Rotation"] = 90;
	G2L["c"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(0.597, 0.23125),NumberSequenceKeypoint.new(1.000, 1)};
	G2L["c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(86, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

	G2L["d"] = Instance.new("UIGridLayout", G2L["a"]);
	G2L["d"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
	G2L["d"]["CellSize"] = UDim2.new(0, 35, 0, 35);
	G2L["d"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
	G2L["d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	G2L["11"] = Instance.new("Folder", G2L["2"]);
	G2L["11"]["Name"] = [[Sections]];
	
	-- StarterGui.Lapzurite2.Notification
	G2L["28"] = Instance.new("CanvasGroup", G2L["1"]);
	G2L["28"]["BorderSizePixel"] = 0;
	G2L["28"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["28"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["28"]["Size"] = UDim2.new(0, 190, 1, 0);
	G2L["28"]["Position"] = UDim2.new(0.90474, 0, 0.47431, 0);
	G2L["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["28"]["Name"] = [[Notification]];
	G2L["28"]["BackgroundTransparency"] = 1;


	-- StarterGui.Lapzurite2.Notification.UIListLayout
	G2L["29"] = Instance.new("UIListLayout", G2L["28"]);
	G2L["29"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
	G2L["29"]["Padding"] = UDim.new(0, 5);
	G2L["29"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
	G2L["29"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	task.spawn(function()
		G2L["2"]["Active"] = true
		G2L["2"]["Draggable"] = true
		
		game:GetService("TweenService"):Create(G2L["2"], TweenInfo.new(), {GroupTransparency = 0}):Play()
		
		G2L["8"].MouseButton1Up:Connect(function()
			G2L["1"]:Destroy()
		end)
	end)

	function Window:Notify(Config)
		local Title = Config.Title or "Title"
		local Content = Config.Content or "Content"
		local Duration = Config.Duration or 5
		local Completed = false
		
		local function create()
			-- StarterGui.Lapzurite2.Notification.Template
			G2L["2a"] = Instance.new("CanvasGroup", G2L["28"]);
			G2L["2a"]["BorderSizePixel"] = 0;
			G2L["2a"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["2a"]["Size"] = UDim2.new(1, 0, 0, 100);
			G2L["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2a"]["Name"] = Title;
			G2L["2a"]["BackgroundTransparency"] = 0.4;
			G2L["2a"]["GroupTransparency"] = 0;

			-- StarterGui.Lapzurite2.Notification.Template.Title
			G2L["2b"] = Instance.new("TextLabel", G2L["2a"]);
			G2L["2b"]["BorderSizePixel"] = 0;
			G2L["2b"]["TextSize"] = 14;
			G2L["2b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["2b"]["Text"] = Title;
			G2L["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["2b"]["BackgroundTransparency"] = 1;
			G2L["2b"]["Size"] = UDim2.new(1, 0, -0.23, 50);
			G2L["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2b"]["Name"] = Title;


			-- StarterGui.Lapzurite2.Notification.Template.Title.UIPadding
			G2L["2c"] = Instance.new("UIPadding", G2L["2b"]);
			G2L["2c"]["PaddingLeft"] = UDim.new(0, 10);


			-- StarterGui.Lapzurite2.Notification.Template.Content
			G2L["2d"] = Instance.new("TextLabel", G2L["2a"]);
			G2L["2d"]["BorderSizePixel"] = 0;
			G2L["2d"]["TextSize"] = 14;
			G2L["2d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["2d"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			G2L["2d"]["Text"] = Content
			G2L["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["2d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["2d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["2d"]["BackgroundTransparency"] = 1;
			G2L["2d"]["Size"] = UDim2.new(1, 0, 0.23, 50);
			G2L["2d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2d"]["Name"] = Content;
			G2L["2d"]["Position"] = UDim2.new(0, 0, 0.27, 0);


			-- StarterGui.Lapzurite2.Notification.Template.Content.UIPadding
			G2L["2e"] = Instance.new("UIPadding", G2L["2d"]);
			G2L["2e"]["PaddingLeft"] = UDim.new(0, 10);


			-- StarterGui.Lapzurite2.Notification.Template.Close
			G2L["2f"] = Instance.new("ImageButton", G2L["2a"]);
			G2L["2f"]["BorderSizePixel"] = 0;
			G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["2f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["2f"]["Image"] = [[http://www.roblox.com/asset/?id=6031094678]];
			G2L["2f"]["Size"] = UDim2.new(0, 20, 0, 19);
			G2L["2f"]["BackgroundTransparency"] = 1;
			G2L["2f"]["Name"] = [[Close]];
			G2L["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2f"]["Position"] = UDim2.new(0.94658, 0, 0.095, 0);


			-- StarterGui.Lapzurite2.Notification.Template.Duration
			G2L["30"] = Instance.new("Frame", G2L["2a"]);
			G2L["30"]["AnchorPoint"] = Vector2.new(0,0.5);
			G2L["30"]["BorderSizePixel"] = 0;
			G2L["30"]["BackgroundColor3"] = Color3.fromRGB(86, 171, 255);
			G2L["30"]["Size"] = UDim2.new(1, 0, 0, 15);
			G2L["30"]["Position"] = UDim2.new(0, 0, 0.92, 0);
			G2L["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["30"]["Name"] = [[Duration]];
			
			return G2L["2a"]
		end
		
		local n = create()
		
		task.spawn(function()
			local TweenService = game:GetService("TweenService")
			local Tween = TweenService:Create(n:FindFirstChild("Duration"), TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 15)})
			Tween:Play()
			Tween.Completed:Wait()
			n:Destroy()
		end)
	end

	function Window:Tab(Config)
		local Tab = {}
		if not Config.Name then warn("Missing arguments") end

		G2L["e"] = Instance.new("ImageButton", G2L["a"]);
		G2L["e"]["BorderSizePixel"] = 0;
		G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["e"]["Image"] = [[http://www.roblox.com/asset/?id=6035145364]] or Config.Icon;
		G2L["e"]["Size"] = UDim2.new(0, 100, 0, 100);
		G2L["e"]["BackgroundTransparency"] = 1;
		G2L["e"]["Name"] = Config.Name;
		G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);

		G2L["12"] = Instance.new("ScrollingFrame", G2L["11"]);
		G2L["12"]["BorderSizePixel"] = 0;
		G2L["12"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["12"]["Name"] = Config.Name;
		G2L["12"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		G2L["12"]["Size"] = UDim2.new(0, 315, 0, 250);
		G2L["12"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["12"]["Position"] = UDim2.new(0.565, 0, 0.53333, 0);
		G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["12"]["ScrollBarThickness"] = 0;
		G2L["12"]["BackgroundTransparency"] = 0.8;
		G2L["12"]["Visible"] = false

		G2L["13"] = Instance.new("UIGridLayout", G2L["12"]);
		G2L["13"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
		G2L["13"]["CellSize"] = UDim2.new(0, 315, 0, 50);
		G2L["13"]["CellPadding"] = UDim2.new(0,0,0,0);
		G2L["13"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		G2L["15"] = Instance.new("Frame", G2L["2"]);
		G2L["15"]["BorderSizePixel"] = 0;
		G2L["15"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["15"]["Size"] = UDim2.new(0, 100, 0, 25);
		G2L["15"]["Position"] = UDim2.new(0.38, 0, 0, 0);
		G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["15"]["Name"] = Config.Name;
		G2L["15"]["BackgroundTransparency"] = 0.7;
		G2L["15"]["Visible"] = false

		G2L["16"] = Instance.new("UIStroke", G2L["15"]);
		G2L["16"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
		G2L["16"]["Color"] = Color3.fromRGB(255, 255, 255);

		G2L["17"] = Instance.new("UIGradient", G2L["16"]);
		G2L["17"]["Rotation"] = 90;
		G2L["17"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(0.597, 0.23125),NumberSequenceKeypoint.new(1.000, 1)};
		G2L["17"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(86, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

		G2L["18"] = Instance.new("TextLabel", G2L["15"]);
		G2L["18"]["BorderSizePixel"] = 0;
		G2L["18"]["TextSize"] = 14;
		G2L["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		G2L["18"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		G2L["18"]["BackgroundTransparency"] = 1;
		G2L["18"]["Size"] = UDim2.new(1, 0, 1, 0);
		G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		G2L["18"]["Text"] = Config.Name;

		task.spawn(function()
			local mouse = game.Players.LocalPlayer:GetMouse()

			local function ClearAllSection()
				for i, v in pairs(G2L["11"]:GetChildren()) do
					if v:IsA("ScrollingFrame") then
						v.Visible = false
					end
				end
			end

			G2L["e"]["MouseButton1Up"]:Connect(function()
				ClearAllSection()
				G2L["11"]:FindFirstChild(Config.Name).Visible = true
			end)

			G2L["e"]["MouseEnter"]:Connect(function(x, y)
				G2L["2"]:FindFirstChild(Config.Name).Visible = true
			end)

			G2L["e"]["MouseLeave"]:Connect(function()
				G2L["2"]:FindFirstChild(Config.Name).Visible = false
			end)
		end)
		
		function Tab:Button(Config)
			local Name = Config.Title or "Button"
			
			G2L["15"] = Instance.new("CanvasGroup", G2L["12"]);
			G2L["15"]["BorderSizePixel"] = 0;
			G2L["15"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["15"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["15"]["Size"] = UDim2.new(0, 100, 0, 100);
			G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["15"]["Name"] = [[Button]];
			G2L["15"]["BackgroundTransparency"] = 0.6;

			G2L["16"] = Instance.new("TextLabel", G2L["15"]);
			G2L["16"]["BorderSizePixel"] = 0;
			G2L["16"]["TextSize"] = 14;
			G2L["16"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["16"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["16"]["BackgroundTransparency"] = 1;
			G2L["16"]["Size"] = UDim2.new(0, 200, 0, 50);
			G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["16"]["Text"] = Name;
			G2L["16"]["Name"] = [[Label]];

			G2L["17"] = Instance.new("UIPadding", G2L["15"]);
			G2L["17"]["PaddingLeft"] = UDim.new(0.05, 0);

			G2L["19"] = Instance.new("ImageButton", G2L["15"]);
			G2L["19"]["BorderSizePixel"] = 0;
			G2L["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["19"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["19"]["Image"] = [[http://www.roblox.com/asset/?id=6031091008]];
			G2L["19"]["Size"] = UDim2.new(0, 37, 0, 37);
			G2L["19"]["BackgroundTransparency"] = 1;
			G2L["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["19"]["Position"] = UDim2.new(0.91604, 0, 0.4825, 0);
			
			G2L["19"]["MouseButton1Up"]:Connect(Config.Callback)
		end

		function Tab:Toggle(Config)
			local Title = Config.Name or "Toggle"
			local State = Config.Default or false			

			-- StarterGui.Lapzurite2.Main.Sections.Test.Toggle
			G2L["20"] = Instance.new("CanvasGroup", G2L["12"]);
			G2L["20"]["BorderSizePixel"] = 0;
			G2L["20"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["20"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["20"]["Size"] = UDim2.new(0, 100, 0, 100);
			G2L["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["20"]["Name"] = [[Toggle]];
			G2L["20"]["BackgroundTransparency"] = 0.6;


			-- StarterGui.Lapzurite2.Main.Sections.Test.Toggle.Label
			G2L["1a"] = Instance.new("TextLabel", G2L["20"]);
			G2L["1a"]["BorderSizePixel"] = 0;
			G2L["1a"]["TextSize"] = 14;
			G2L["1a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1a"]["BackgroundTransparency"] = 1;
			G2L["1a"]["Size"] = UDim2.new(0, 200, 0, 50);
			G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1a"]["Text"] = Title;
			G2L["1a"]["Name"] = [[Label]];


			-- StarterGui.Lapzurite2.Main.Sections.Test.Toggle.UIPadding
			G2L["1b"] = Instance.new("UIPadding", G2L["20"]);
			G2L["1b"]["PaddingLeft"] = UDim.new(0.05, 0);

			G2L["1c"] = Instance.new("ImageButton", G2L["20"]);
			G2L["1c"]["BorderSizePixel"] = 0;
			G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["1c"]["Image"] = [[http://www.roblox.com/asset/?id=6031068429]];
			G2L["1c"]["Size"] = UDim2.new(0, 37, 0, 37);
			G2L["1c"]["BackgroundTransparency"] = 1;
			G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1c"]["Position"] = UDim2.new(0.91604, 0, 0.4825, 0);
			
			G2L["1c"]["MouseButton1Up"]:Connect(function()
				State = not State

				if State then
					G2L["1c"]["Image"] = "http://www.roblox.com/asset/?id=6031068430"
				else
					G2L["1c"]["Image"] = "http://www.roblox.com/asset/?id=6031068429"
				end
				Config.Callback(State)
			end)
		end

		function Tab:Header(Config)
			local Title = Config.Title
			
			-- StarterGui.Lapzurite2.Main.Sections.Test.Header
			G2L["1d"] = Instance.new("CanvasGroup", G2L["12"]);
			G2L["1d"]["BorderSizePixel"] = 0;
			G2L["1d"]["BackgroundColor3"] = Color3.fromRGB(16, 16, 16);
			G2L["1d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["1d"]["Size"] = UDim2.new(0, 100, 0, 100);
			G2L["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1d"]["Name"] = [[Header]];
			G2L["1d"]["BackgroundTransparency"] = 0.7;


			-- StarterGui.Lapzurite2.Main.Sections.Test.Header.Label
			G2L["1e"] = Instance.new("TextLabel", G2L["1d"]);
			G2L["1e"]["BorderSizePixel"] = 0;
			G2L["1e"]["TextSize"] = 25;
			G2L["1e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["1e"]["TextYAlignment"] = Enum.TextYAlignment.Bottom;
			G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1e"]["BackgroundTransparency"] = 1;
			G2L["1e"]["Size"] = UDim2.new(0, 200, 0, 42);
			G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1e"]["Text"] = Title;
			G2L["1e"]["Name"] = [[Label]];
			G2L["1e"]["Position"] = UDim2.new(-0, 0, 0, 0);


			-- StarterGui.Lapzurite2.Main.Sections.Test.Header.UIPadding
			G2L["1f"] = Instance.new("UIPadding", G2L["1d"]);
			G2L["1f"]["PaddingLeft"] = UDim.new(0.045, 0);
		end
		
		function Tab:Label(Config)
			local Title = Config.Title or "Title"
			local SubTitle = Config.Subtitle or "Subtitle"
			
			-- StarterGui.Lapzurite2.Main.Sections.Test.Label.Label
			G2L["21"] = Instance.new("TextLabel", G2L["12"]);
			G2L["21"]["BorderSizePixel"] = 0;
			G2L["21"]["TextSize"] = 18;
			G2L["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["21"]["Text"] = Title;
			G2L["21"]["BackgroundTransparency"] = 1;
			G2L["21"]["Size"] = UDim2.new(0, 200, 0, 18);
			G2L["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["21"]["Name"] = [[Label]];
			G2L["21"]["Position"] = UDim2.new(0, 0, 0, 5);


			-- StarterGui.Lapzurite2.Main.Sections.Test.Label.UIPadding
			G2L["22"] = Instance.new("UIPadding", G2L["20"]);
			G2L["22"]["PaddingLeft"] = UDim.new(0.05, 0);


			-- StarterGui.Lapzurite2.Main.Sections.Test.Label.SubLabel
			G2L["23"] = Instance.new("TextLabel", G2L["20"]);
			G2L["23"]["TextWrapped"] = true;
			G2L["23"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
			G2L["23"]["BorderSizePixel"] = 0;
			G2L["23"]["TextSize"] = 14;
			G2L["23"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["23"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["23"]["BackgroundTransparency"] = 1;
			G2L["23"]["Size"] = UDim2.new(0, 288, 0, 27);
			G2L["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["23"]["Text"] = SubTitle;
			G2L["23"]["Name"] = [[SubLabel]];
			G2L["23"]["Position"] = UDim2.new(0, 0, 0.46, 0);
		end

		return Tab
	end

	return Window
end

return Lapzurite
