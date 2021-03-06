--[[
  ___ __  __ _  ____ ____ __   __ _ ____ ____ 
 / __)  \(  ( \/ ___|_  _) _\ (  ( (_  _) ___)
( (_(  O )    /\___ \ )(/    \/    / )( \___ \
 \___)__/\_)__)(____/(__)_/\_/\_)__)(__)(____/
 
]]--

-- [[ Services ]] --
local Services = {}
Services.Players = game:GetService("Players")
Services.UserInputService = game:GetService("UserInputService")
Services.TweenService = game:GetService("TweenService")
Services.RunService = game:GetService("RunService")

-- [[ LocalPlayer ]] --
local LocalPlayer = Services.Players.LocalPlayer

-- [[ Custom Functions ]] --
local CustomFunctions = {}
CustomFunctions.SetHidden = sethiddenproperty or set_hidden_property or set_hidden_prop
CustomFunctions.GetHidden = gethiddenproperty or get_hidden_property or get_hidden_prop
CustomFunctions.SetSimulation = setsimulationradius or set_simulation_radius

-- [[ UI Service ]] --
local UserInterfaceService
if Services.RunService:IsStudio() then
	UserInterfaceService = LocalPlayer.PlayerGui
else
	UserInterfaceService = game:GetService("CoreGui")
end

--[[
   _____         .__        
  /     \ _____  |__| ____  
 /  \ /  \\__  \ |  |/    \ 
/    Y    \/ __ \|  |   |  \
\____|__  (____  /__|___|  /
        \/     \/        \/
]]

-- // TigronFE \\ --
local TigronFE = {}

-- [[ Functions ]] --
function TigronFE.new(Class, Properties)
	-- Creates the Instance --
	local NewInstance = Instance.new(Class)

	-- Sets the Properties --
	for i,v in next, Properties do
		if NewInstance[i] ~= nil and i ~= "Parent" then
			NewInstance[i] = v
		end
	end

	-- Sets Parent --
	if Properties.Parent then
		NewInstance.Parent = Properties.Parent
	end

	return NewInstance
end

function TigronFE.Tween(Object, TweenInformation, Goal, Data)
	local TweenSettings = Data or {Play = true, Yield = false}

	local NewTween = Services.TweenService:Create(Object, TweenInformation, Goal)

	if TweenSettings.Play == true then
		NewTween:Play()
		if TweenSettings.Yield == true then
			NewTween.Completed:Wait()
		end
	end

	return NewTween
end

-- [[ ScreenGui ]] --
TigronFE.ScreenGui = TigronFE.new("ScreenGui", {Name = "Tigron Hub", Parent = UserInterfaceService})

-- [[ Bindable Function ]] --
TigronFE.CommandExecute = TigronFE.new("BindableFunction", {Name = "CommandExecute"})

function TigronFE.CreateUI(ChangeLogContent, CommandList)
	-- // TIGRON HUB \\ --
	local UserInterface = {}

	-- [[ Interface ]] --
	local Intro = {}
	local ChangeLog = {}
	local Commands = {}
	local Settings = {}
	local CommandBar = {}

	-- [[ Info ]] --
	local GeneralPositions = {}
	GeneralPositions.CollapsedGoal = {Position = UDim2.new(0.5, 0, 1.25, 0), AnchorPoint = Vector2.new(0.5, 0)}
	GeneralPositions.ExpandedGoal = {Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5)}
	
	local NetworkInfo = {}
	NetworkInfo.Toggled = false
	
	local ChangeLogInfo = {}
	ChangeLogInfo.Toggled = false

	local CommandsInfo = {}
	CommandsInfo.Toggled = false

	local SettingsInfo = {}
	SettingsInfo.Toggled = false

	local CommandBarInfo = {}
	CommandBarInfo.Expanded = true
	CommandBarInfo.ExpandedGoal = {Position = UDim2.new(-0.005, 0, 1, 0), AnchorPoint = Vector2.new(0, 1)}
	CommandBarInfo.CollapsedGoal = {Position = UDim2.new(0, 0, 1, 0), AnchorPoint = Vector2.new(1, 1)}

	
	-- // FUNCTIONS \\ --
	--[[
		CreateContainer(String Name, Dictionary Data)
	Creates a Interface Container
	]]
	local function CreateContainer(Name, Data)
		local Container = {}
		
		-- Main Frame --
		Container.Frame = TigronFE.new("Frame", {
			Name = Name,
			Parent = TigronFE.ScreenGui,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 1.25, 0),
			Size = UDim2.new(0.6, 0, 0.6, 0)
		})

		TigronFE.new("UICorner", {CornerRadius = UDim.new(0.03, 0), Parent = Container.Frame})
		TigronFE.new("UIAspectRatioConstraint", {AspectRatio = 0.855, Parent = Container.Frame})
		
		-- Title Folder --
		local Title = TigronFE.new("Folder", {Name = "Title", Parent = Container.Frame})
		
		-- Title --
		TigronFE.new("TextLabel", {
			Name = "Title",
			Parent = Title,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.new(0.75, 0, 0.15, 0),
			Font = Enum.Font.SciFi,
			Text = Name,
			TextColor3 = Color3.fromRGB(255, 125, 0),
			TextScaled = true
		})
		
		-- Divider --
		TigronFE.new("Frame", {Name = "Divider", Parent = Title, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 125, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.175, 0), Size = UDim2.new(0.6, 0, 0.0025, 0)})
		
		-- Close Button --
		Container.Close = TigronFE.new("ImageButton", {Name = "Close", Parent = Container.Frame, AnchorPoint = Vector2.new(0.75, 0.25), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0.125, 0, 0.125, 0), BackgroundColor3 = Color3.fromRGB(255, 0, 0), AutoButtonColor = false, Modal = true, Image = "rbxassetid://3944676352", ScaleType = Enum.ScaleType.Fit})

		TigronFE.new("UICorner", {Parent = Container.Close, CornerRadius = UDim.new(1, 0)})
		TigronFE.new("UIAspectRatioConstraint", {Parent = Container.Close})

		-- Main Contents --
		if Data.ScrollingFrame then
			Container.Main = TigronFE.new("ScrollingFrame", {
				Name = "ScrollingFrame", 
				Parent = Container.Frame, 
				Active = true, 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundTransparency = 1, 
				BorderSizePixel = 0, 
				Position = UDim2.new(0.5, 0, 0.975, 0), 
				Size = UDim2.new(1, 0, 0.775, 0), 
				ScrollingDirection = Enum.ScrollingDirection.Y, 
				ScrollBarImageColor3 = Color3.fromRGB(25, 25, 25), 
				ScrollBarImageTransparency = 0.25, 
				ScrollBarThickness = 7.5
			})
			
			local UIListLayout = TigronFE.new("UIListLayout", {Parent = Container.Main, Padding = UDim.new(0.005, 0), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder})

			Container.Main.CanvasSize = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
			UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Container.Main.CanvasSize = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
			end)
		else
			Container.Main = TigronFE.new("Frame", {
				Name = "MainContainer", 
				Parent = Container.Frame, 
				AnchorPoint = Vector2.new(0.5, 1), 
				BackgroundTransparency = 1, 
				Position = UDim2.new(0.5, 0, 1, 0), 
				Size = UDim2.new(1, 0, 0.815, 0)
			})
		end

		return Container
	end

	--[[
	ExecuteCommand(String Command)
		Executes the string
	]]
	local function ExecuteCommand(Command)
		return TigronFE.CommandExecute:Invoke(Command)
	end

	--[[
	ToggleContainer(String Container, Boolean Status)
		Toggles a container
	]]
	local function ToggleContainer(Frame, Status)
		if Status == true then
			TigronFE.Tween(Frame, TweenInfo.new(0.5), GeneralPositions.ExpandedGoal)
		else
			TigronFE.Tween(Frame, TweenInfo.new(0.5), GeneralPositions.CollapsedGoal)
		end
	end

	--[[
	 _  _   __  __ __ _ 
	( \/ ) / _\(  |  ( \
	/ \/ \/    \)(/    /
	\_)(_/\_/\_(__)_)__)

	]]--
	
	--  Command Bar Frame --
	CommandBar.CommandBarFrame = TigronFE.new("Frame", {
		Name = "CommandBar",
		Parent = TigronFE.ScreenGui,
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		Position = UDim2.new(-0.005, 0, 1, 0),
		Size = UDim2.new(0.6, 0, 0.215, 0)
	})
	TigronFE.new("UIAspectRatioConstraint", {Parent = CommandBar.CommandBarFrame, AspectRatio = 2.8})
	TigronFE.new("UICorner", {Parent = CommandBar.CommandBarFrame, CornerRadius = UDim.new(0.075, 0)})

	-- Title --
	local TextLabel = TigronFE.new("TextLabel", {
		Parent = CommandBar.CommandBarFrame, 
		AnchorPoint = Vector2.new(0.5, 1), 
		BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
		Position = UDim2.new(0.5, 0, 0.025, 0), 
		Size = UDim2.new(0.4, 0, 0.25, 0), 
		ZIndex = 0, 
		Font = Enum.Font.SciFi, 
		Text = "Tigron Hub", 
		TextColor3 = Color3.fromRGB(255, 125, 0), 
		TextScaled = true, 
		TextSize = 28, 
		TextWrapped = true
	})
	TigronFE.new("UICorner", {CornerRadius = UDim.new(0.2, 0), Parent = TextLabel})
	TigronFE.new("UITextSizeConstraint", {MaxTextSize = 28, Parent = TextLabel})

	-- Command Box --
	CommandBar.CommandBox = TigronFE.new("TextBox", {
		Name = "CommandFrame", 
		Parent = CommandBar.CommandBarFrame, 
		AnchorPoint = Vector2.new(0.5, 0.5), 
		BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
		BorderSizePixel = 0, 
		Position = UDim2.new(0.5, 0, 0.255, 0), 
		Size = UDim2.new(0.75, 0, 0.4, 0), 
		PlaceholderColor3 = Color3.fromRGB(200, 200, 200), 
		PlaceholderText = "Command", 
		Text = "", 
		TextColor3 = Color3.fromRGB(255, 255, 255), 
		TextScaled = true, 
		TextSize = 16, 
		TextWrapped = true, 
		TextXAlignment = Enum.TextXAlignment.Left
	})
	TigronFE.new("UICorner", {CornerRadius = UDim.new(0.1, 0), Parent = CommandBar.CommandBox})
	TigronFE.new("UIPadding", {PaddingLeft = UDim.new(0.025, 0), Parent = CommandBar.CommandBox})
	TigronFE.new("UITextSizeConstraint", {MaxTextSize = 16, Parent = CommandBar.CommandBox})
	
	-- Execute Button --
	CommandBar.Execute = TigronFE.new("ImageButton", {
		Name = "Execute", 
		Parent = CommandBar.CommandBox, 
		AnchorPoint = Vector2.new(0.5, 0.5), 
		BackgroundColor3 = Color3.fromRGB(255, 255, 255), 
		BackgroundTransparency = 1, 
		BorderSizePixel = 0, 
		Position = UDim2.new(0.9, 0, 0.5, 0), 
		Size = UDim2.new(0.8, 0, 0.8, 0), 
		AutoButtonColor = false, 
		Image = "rbxassetid://4384407160", 
		ScaleType = Enum.ScaleType.Fit
	})
	TigronFE.new("UIAspectRatioConstraint", {Parent = CommandBar.Execute})

	-- ButtonFrame --
	CommandBar.ButtonFrame = TigronFE.new("Frame", {
		Name = "ButtonFrame",
		Parent = CommandBar.CommandBarFrame,
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BorderColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 2,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.625, 0, 0.45, 0)
	})
	TigronFE.new("UIListLayout", {Parent = CommandBar.ButtonFrame, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0.01, 0)})

	local function NewButton(IconID, TitleText, ClickFunction)
		local ButtonContent = {}

		-- Button --
		ButtonContent.Button = TigronFE.new("Frame", {
			Name = TitleText,
			Parent = CommandBar.ButtonFrame,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			BackgroundTransparency = 0,
			BorderColor3 = Color3.fromRGB(255, 255, 255), 
			BorderSizePixel = 2,
			Size = UDim2.new(1, 0, 0.975, 0)
		})
		TigronFE.new("UIAspectRatioConstraint", {Parent = ButtonContent.Button})
		
		-- Icon --
		ButtonContent.Icon = TigronFE.new("ImageLabel", {
			Name = "Icon",
			Parent = ButtonContent.Button,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.375, 0),
			Size = UDim2.new(0.75, 0, 0.75, 0),
			Image = IconID,
			ScaleType = Enum.ScaleType.Fit
		})
		
		-- Title --
		ButtonContent.Title = TigronFE.new("TextLabel", {
			Name = "Title",
			Parent = ButtonContent.Button,
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.95, 0),
			Size = UDim2.new(0.9, 0, 0.225, 0),
			Font = Enum.Font.SourceSans,
			Text = TitleText,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true
		})

		-- Actions --
		ButtonContent.Button.MouseEnter:Connect(function()
			TigronFE.Tween(ButtonContent.Icon, TweenInfo.new(0.1), {Size = UDim2.new(0.775, 0, 0.775, 0)})
		end)

		ButtonContent.Button.MouseLeave:Connect(function()
			TigronFE.Tween(ButtonContent.Icon, TweenInfo.new(0.1), {Size = UDim2.new(0.75, 0, 0.75, 0)})
		end)

		ButtonContent.Button.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				TigronFE.Tween(ButtonContent.Icon, TweenInfo.new(0.1), {Size = UDim2.new(0.675, 0, 0.675, 0)})
			end
		end)
		
		ButtonContent.Button.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				TigronFE.Tween(ButtonContent.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Size = UDim2.new(0.775, 0, 0.775, 0)})
			end
		end)

		return ButtonContent
	end

	-- Buttons --
	CommandBar.Network = NewButton("rbxassetid://4370317928", "Network")
	CommandBar.Changelog = NewButton("rbxassetid://4335484884", "Changelog")
	CommandBar.Commands = NewButton("rbxassetid://4370346095", "Commands")
	CommandBar.Settings = NewButton("rbxassetid://3605022185", "Settings")



	-- Expander --
	CommandBar.Expander = TigronFE.new("ImageButton", {
		Name = "Expander",
		Parent = CommandBar.CommandBarFrame,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0.07, 0, 0.325, 0),
		AutoButtonColor = false,
		Image = "rbxassetid://3610253853",
		ScaleType = Enum.ScaleType.Fit
	})
	
	-- [[ Functions ]]--
	local function FocusLost(CorrectInput, inputThatCausedFocusLost)
		if CorrectInput then
			local String = CommandBar.CommandBox.Text
			CommandBar.CommandBox.Text = ""
			CommandBar.Execute.Image = "rbxassetid://4370306254"

			CommandBar.CommandBox:ReleaseFocus()
			TigronFE.Tween(CommandBar.CommandBox, TweenInfo.new(0.1), {Size = UDim2.new(0.75, 0, 0.4, 0)})

			TigronFE.Tween(CommandBar.Execute, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Rotation = 360, Size = UDim2.new(0.75, 0, 0.75, 0)})
			wait(0.1)
			local NextTweenInfo = {Image = "rbxassetid://3944669799", Color = Color3.fromRGB(250, 25, 25)}
			if ExecuteCommand(String) == true then
				NextTweenInfo.Image = "rbxassetid://3944680095"
				NextTweenInfo.Color = Color3.fromRGB(25, 240, 25)
			end
			CommandBar.Execute.Image = NextTweenInfo.Image
			TigronFE.Tween(CommandBar.Execute, TweenInfo.new(0.05), {ImageColor3 = NextTweenInfo.Color})
			wait(1)
			TigronFE.Tween(CommandBar.Execute, TweenInfo.new(0.15), {ImageColor3 = Color3.new(255,255,255), Rotation = 0, Size = UDim2.new(0.8, 0, 0.8, 0)})
			CommandBar.Execute.Image = "rbxassetid://4384407160"
		end
	end

	CommandBar.CommandBox.Focused:Connect(function()
		TigronFE.Tween(CommandBar.Execute, TweenInfo.new(0.1), {Size = UDim2.new(0.755, 0, 0.405, 0), ImageColor3 = Color3.new(255,255,255), Rotation = 0, Size = UDim2.new(0.8, 0, 0.8, 0)})
		CommandBar.Execute.Image = "rbxassetid://4384407160"
	end)

	CommandBar.CommandBox.FocusLost:Connect(FocusLost)

	local CommandBarExecuteHovered = false

	CommandBar.Execute.MouseEnter:Connect(function(Input)
		CommandBarExecuteHovered = true
	end)

	CommandBar.Execute.MouseLeave:Connect(function(Input)
		CommandBarExecuteHovered = false
	end)

	Services.UserInputService.InputBegan:Connect(function(Input, Proccessed)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 and CommandBarExecuteHovered == true then
			FocusLost(true, Enum.KeyCode.KeypadEnter)
		end
	end)
	
	-- // ChangeLog \\ --
	ChangeLog = CreateContainer("ChangeLog", {ScrollingFrame = true})

	for i,v in ipairs(ChangeLogContent) do
		local Entry = {}

		Entry.Frame = TigronFE.new("Frame", {
			Name = "Entry",
			BackgroundTransparency = 1,
			Parent = ChangeLog.Main
		})
		local UIListLayout = TigronFE.new("UIListLayout", {HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Entry.Frame})

		Entry.Frame.Size = UDim2.new(0.75, 0, 0, UIListLayout.AbsoluteContentSize.Y + 2.5)
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Entry.Frame.Size = UDim2.new(0.75, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
		end)

		Entry.Title = TigronFE.new("TextLabel", {
			Name = "EntryTitle",
			Parent = Entry.Frame,
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.new(0.55, 0, 1, 0),
			Text = v.Title,
			TextColor3 = Color3.fromRGB(175, 175, 175),
			TextScaled = true,
			TextSize = 14,
			TextWrapped = true
		})
		TigronFE.new("UIAspectRatioConstraint", {AspectRatio = 3.5, Parent = Entry.Title})

		for i,v in ipairs(v.Content) do
			local Text = TigronFE.new("TextLabel", {
				Name = "Item",
				Parent = Entry.Frame,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				Size = UDim2.new(0.9, 0, 0.3, 0),
				Font = Enum.Font.Roboto,
				Text = tostring(i) .. "- " .. v,
				TextColor3 = Color3.fromRGB(125, 125, 125),
				TextScaled = true,
				TextSize = 20,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			TigronFE.new("UIAspectRatioConstraint", {AspectRatio = 7.5, Parent = Text})
			TigronFE.new("UITextSizeConstraint", {MaxTextSize = 20, Parent = Text})
		end
	end


	-- // COMMAND LIST \\ --
	Commands = CreateContainer("Commands", {ScrollingFrame = true})

	for i,v in ipairs(CommandList) do
		local TextButton = TigronFE.new("TextButton", {
			Parent = Commands.Main,
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			Size = UDim2.new(0.75, 0, 0, 30),
			Font = Enum.Font.Roboto,
			Text = tostring(i) .. ". " .. v,
			TextColor3 = Color3.fromRGB(225, 225, 225),
			TextScaled = true,
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left
		})

		TextButton.MouseButton1Click:Connect(function()
			CommandBar.CommandBox.Text = v
			FocusLost(true, Enum.KeyCode.KeypadEnter)
		end)
	end

	Settings = CreateContainer("Settings", {ScrollingFrame = true})
	local WIP = Instance.new("TextLabel", Settings.Main)
	WIP.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	WIP.Size = UDim2.new(0.4, 0, 0.25, 0)
	WIP.ZIndex = 1
	WIP.Font = Enum.Font.SciFi
	WIP.Text = "Not Finished yet"
	WIP.TextColor3 = Color3.new(1,1,1)

	-- [[ Dynamic Scripts ]] --
	-- [ Open/Close ] --
	CommandBar.Expander.MouseButton1Click:Connect(function()
		local Image = "rbxassetid://3610253853"
		local Goal = CommandBarInfo.ExpandedGoal

		if CommandBarInfo.Expanded then
			Image = "rbxassetid://3610253578"
			Goal = CommandBarInfo.CollapsedGoal
		end
		TigronFE.Tween(CommandBar.CommandBarFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine), Goal)
		CommandBar.Expander.Image = Image

		CommandBarInfo.Expanded = not CommandBarInfo.Expanded
	end)

	-- [ Button Toggles ] --

	-- Toggle Network --
	local function ToggleNetwork(Value)
		NetworkInfo.Toggled = not NetworkInfo.Toggled
		if Value ~= nil then
			NetworkInfo.Toggled = Value
		end

		local Image = "rbxassetid://4370317928"
		local Info = {Rotation = 0, ImageColor3 = Color3.new(1, 1, 1)}
		local Text = "Network"
		if NetworkInfo.Toggled == true then
			Image = "rbxassetid://3944680095"
			Info.Rotation = 360
			Info.ImageColor3 = Color3.new(0, 1, 0)
			Text = "Simulating..."
		end
		TigronFE.Tween(CommandBar.Network.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Network.Title.Text = Text
		CommandBar.Network.Icon.Image = Image
		
		settings().Physics.AllowSleep = false
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
	end
	-- <eof>
	

	
	-- Toggle ChangeLog --
	local function ToggleChangeLog(Value)
		ChangeLogInfo.Toggled = not ChangeLogInfo.Toggled
		if Value ~= nil then
			ChangeLogInfo.Toggled = Value
		end

		ToggleContainer(ChangeLog.Frame, ChangeLogInfo.Toggled)

		local Image = "rbxassetid://4335484884"
		local Info = {Rotation = 0}
		if ChangeLogInfo.Toggled == true then
			Image = "rbxassetid://4335479121"
			Info.Rotation = 360
		end
		TigronFE.Tween(CommandBar.Changelog.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Changelog.Icon.Image = Image
	end
	
	-- Toggle Commands --
	local function ToggleCommands(Value)
		CommandsInfo.Toggled = not CommandsInfo.Toggled
		if Value ~= nil then
			CommandsInfo.Toggled = Value
		end

		ToggleContainer(Commands.Frame, CommandsInfo.Toggled)

		local Image = "rbxassetid://4370346095"
		local Info = {Rotation = 0}
		if CommandsInfo.Toggled == true then
			Image = "rbxassetid://4370319235"
			Info.Rotation = 360
		end
		TigronFE.Tween(CommandBar.Commands.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Commands.Icon.Image = Image
	end
	
	-- Toggle Settings --
	local function ToggleSettings(Value)
		SettingsInfo.Toggled = not SettingsInfo.Toggled
		if Value ~= nil then
			SettingsInfo.Toggled = Value
		end

		ToggleContainer(Settings.Frame, SettingsInfo.Toggled)

		local Image = "rbxassetid://3605022185"
		local Info = {Rotation = 0}
		if SettingsInfo.Toggled == true then
			Image = "rbxassetid://4483345737"
			Info.Rotation = 360
		end
		TigronFE.Tween(CommandBar.Settings.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Settings.Icon.Image = Image
	end

	-- Toggle Events --
	CommandBar.Network.Button.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleNetwork()
		end
	end)

	CommandBar.Changelog.Button.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleCommands(false)
			ToggleSettings(false)
			ToggleChangeLog()
		end
	end)

	CommandBar.Commands.Button.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleChangeLog(false)
			ToggleSettings(false)
			ToggleCommands()
		end
	end)

	CommandBar.Settings.Button.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleChangeLog(false)
			ToggleCommands(false)
			ToggleSettings()
		end
	end)

	ChangeLog.Close.MouseButton1Click:Connect(function()
		ToggleChangeLog(false)
	end)

	Commands.Close.MouseButton1Click:Connect(function()
		ToggleCommands(false)
	end)

	Settings.Close.MouseButton1Click:Connect(function()
		ToggleSettings(false)
	end)

	-- Loops --	
	Services.RunService.RenderStepped:Connect(function()
		if NetworkInfo.Toggled == true then
			for i,v in ipairs(Services.Players:GetPlayers()) do
				if v ~= LocalPlayer then
					CustomFunctions.SetHidden(v, "MaximumSimulationRadius", 0.1)
					CustomFunctions.SetHidden(v, "SimulationRadius", 0.1)
				end
				CustomFunctions.SetHidden(LocalPlayer, "MaximumSimulationRadius", math.huge)
				CustomFunctions.SetSimulation(math.huge)
				LocalPlayer.ReplicationFocus = workspace
			end
		end
	end)
	
	return UserInterface
end

return TigronFE
