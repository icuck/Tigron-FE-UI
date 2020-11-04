local function CreateUI(ChangeLogContent, CommandList)
	--[[
	  ___ __  __ _  ____ ____ __   __ _ ____ ____ 
	 / __)  \(  ( \/ ___|_  _) _\ (  ( (_  _) ___)
	( (_(  O )    /\___ \ )(/    \/    / )( \___ \
	 \___)__/\_)__)(____/(__)_/\_/\_)__)(__)(____/
	 
	]]--

	local Services = {}
	Services.Players = game:GetService("Players")
	Services.UserInputService = game:GetService("UserInputService")
	Services.TweenService = game:GetService("TweenService")
	Services.RunService = game:GetService("RunService")

	-- [[ LocalPlayer ]] --
	local LocalPlayer = {}
	LocalPlayer.Player = Services.Players.LocalPlayer
	LocalPlayer.Character = LocalPlayer.Player.Character or LocalPlayer.Player.CharacterAdded:Wait()
	LocalPlayer.CharacterContents = LocalPlayer.Character:GetChildren()

	--[[
	 _  _  __  ____ __  __  ____ __   ____ ____ 
	/ )( \/ _\(  _ (  )/ _\(  _ (  ) (  __) ___)
	\ \/ /    \)   /)(/    \) _ ( (_/\) _)\___ \
	 \__/\_/\_(__\_|__)_/\_(____|____(____|____/

	]]

	-- // TIGRON HUB \\ --
	local TigronHub = {}

	-- [[ ScreenGui ]] --
	TigronHub.ScreenGui = Instance.new("ScreenGui")
	TigronHub.ScreenGui.Name = "Tigron Hub"

	if Services.RunService:IsStudio() then
		TigronHub.ScreenGui.Parent = LocalPlayer.Player.PlayerGui
	else
		TigronHub.ScreenGui.Parent = game:GetService("CoreGui")
	end

	-- [[ Events ]] --
	TigronHub.CommandExecute = Instance.new("BindableFunction")

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

	--[[
	 ____ _  _ __ _  ___ ____ __ __  __ _  ____ 
	(  __) )( (  ( \/ __|_  _|  )  \(  ( \/ ___)
	 ) _)) \/ (    ( (__  )(  )(  O )    /\___ \
	(__) \____|_)__)\___)(__)(__)__/\_)__)(____/

	]]

	-- // TWEENS \\ --

	--[[
	Tween(Instance Object, TweenInfo TweenInformation, Dictionary Goal, Dictionary Data)
		Creates a tween
	]]
	local function Tween(Object, TweenInformation, Goal, Data)
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

	--[[
	TweenModel(Instance Model, TweenInfo TweenInformation, Dictionary Goal)
		Tweens a model with primary part
	]]
	local function TweenModel(Model, TweenInformation, Goal)
		local CFrameValue = Instance.new("CFrameValue")
		CFrameValue.Value = Model.PrimaryPart.CFrame
		CFrameValue.Changed:Connect(function(Value)
			Model:SetPrimaryPartCFrame(Value)
		end)

		local Tween = Tween(CFrameValue, TweenInformation, Goal)

		coroutine.wrap(function() Tween.Completed:Wait() CFrameValue:Destroy() end)()

		return Tween
	end

	--[[
		CreateContainer(String Name, Dictionary Data)
	Creates a Interface Container
	]]
	local function CreateContainer(Name, Data)
		local Container = {}

		Container.Frame = Instance.new("Frame")
		Container.Frame.Name = Name
		Container.Frame.Parent = TigronHub.ScreenGui
		Container.Frame.AnchorPoint = Vector2.new(0.5, 0)
		Container.Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Container.Frame.BorderSizePixel = 0
		Container.Frame.Position = UDim2.new(0.5, 0, 1.25, 0)
		Container.Frame.Size = UDim2.new(0.6, 0, 0.6, 0)

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0.03, 0)
		UICorner.Parent = Container.Frame

		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint.Parent = Container.Frame
		UIAspectRatioConstraint.AspectRatio = 0.855

		local Title = Instance.new("Folder")
		Title.Name = "Title"
		Title.Parent = Container.Frame

		Container.Title = Instance.new("TextLabel")
		Container.Title.Name = "Title"
		Container.Title.Parent = Title
		Container.Title.AnchorPoint = Vector2.new(0.5, 0)
		Container.Title.BackgroundTransparency = 1
		Container.Title.Position = UDim2.new(0.5, 0, 0, 0)
		Container.Title.Size = UDim2.new(0.75, 0, 0.15, 0)
		Container.Title.Font = Enum.Font.SciFi
		Container.Title.Text = Name
		Container.Title.TextColor3 = Color3.fromRGB(255, 125, 0)
		Container.Title.TextScaled = true

		Container.Divider = Instance.new("Frame")
		Container.Divider.Name = "Divider"
		Container.Divider.Parent = Title
		Container.Divider.AnchorPoint = Vector2.new(0.5, 0)
		Container.Divider.BackgroundColor3 = Color3.fromRGB(255, 125, 0)
		Container.Divider.BorderSizePixel = 0
		Container.Divider.Position = UDim2.new(0.5, 0, 0.175, 0)
		Container.Divider.Size = UDim2.new(0.6, 0, 0.0025, 0)

		Container.Close = Instance.new("ImageButton")
		Container.Close.Name = "Close"
		Container.Close.Parent = Container.Frame
		Container.Close.AnchorPoint = Vector2.new(0.75, 0.25)
		Container.Close.Position = UDim2.new(1, 0, 0, 0)
		Container.Close.Size = UDim2.new(0.125, 0, 0.125, 0)
		Container.Close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		Container.Close.AutoButtonColor = false
		Container.Close.Modal = true
		Container.Close.Image = "rbxassetid://3944676352"
		Container.Close.ScaleType = Enum.ScaleType.Fit

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Container.Close

		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint.Parent = Container.Close


		if Data.ScrollingFrame then
			Container.Main = Instance.new("ScrollingFrame")
			Container.Main.Name = "ScrollingFrame"
			Container.Main.Parent = Container.Frame
			Container.Main.Active = true
			Container.Main.AnchorPoint = Vector2.new(0.5, 1)
			Container.Main.BackgroundTransparency = 1
			Container.Main.BorderSizePixel = 0
			Container.Main.Position = UDim2.new(0.5, 0, 0.975, 0)
			Container.Main.Size = UDim2.new(1, 0, 0.775, 0)
			Container.Main.ScrollingDirection = Enum.ScrollingDirection.Y
			Container.Main.ScrollBarImageColor3 = Color3.fromRGB(25, 25, 25)
			Container.Main.ScrollBarImageTransparency = 0.25
			Container.Main.ScrollBarThickness = 7.5

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Parent = Container.Main
			UIListLayout.Padding = UDim.new(0.005, 0)
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			Container.Main.CanvasSize = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
			UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Container.Main.CanvasSize = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
			end)
		else
			Container.Main = Instance.new("Frame")
			Container.Main.Name = "MainContainer"
			Container.Main.Parent = Container.Frame
			Container.Main.AnchorPoint = Vector2.new(0.5, 1)
			Container.Main.BackgroundTransparency = 1
			Container.Main.Position = UDim2.new(0.5, 0, 1, 0)
			Container.Main.Size = UDim2.new(1, 0, 0.815, 0)
		end

		return Container
	end

	-- // Main Functions \\ --
	--[[
	ExecuteCommand(String Command)
		Executes the string
	]]
	local function ExecuteCommand(Command)
		return TigronHub.CommandExecute:Invoke(Command)
	end

	--[[
	ToggleContainer(String Container, Boolean Status)
		Toggles a container
	]]
	local function ToggleContainer(Frame, Status)
		if Status == true then
			Tween(Frame, TweenInfo.new(0.5), GeneralPositions.ExpandedGoal)
		else
			Tween(Frame, TweenInfo.new(0.5), GeneralPositions.CollapsedGoal)
		end
	end

--[[
 _  _   __  __ __ _ 
( \/ ) / _\(  |  ( \
/ \/ \/    \)(/    /
\_)(_/\_/\_(__)_)__)

]]--
	
	-- // COMMAND BAR \\ --
	-- [[ Command Bar Background ]] --
	-- [ Instances ] --
	CommandBar.CommandBarFrame = Instance.new("Frame")

	-- [ Effects ] --
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	local UICorner = Instance.new("UICorner")

	-- [ Properties ] --
	CommandBar.CommandBarFrame.Name = "CommandBar"
	CommandBar.CommandBarFrame.Parent = TigronHub.ScreenGui
	CommandBar.CommandBarFrame.AnchorPoint = Vector2.new(0, 1)
	CommandBar.CommandBarFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	CommandBar.CommandBarFrame.Position = UDim2.new(-0.005, 0, 1, 0)
	CommandBar.CommandBarFrame.Size = UDim2.new(0.6, 0, 0.215, 0)

	-- Effect Properties --
	UIAspectRatioConstraint.Parent = CommandBar.CommandBarFrame
	UIAspectRatioConstraint.AspectRatio = 2.8

	UICorner.CornerRadius = UDim.new(0.075, 0)
	UICorner.Parent = CommandBar.CommandBarFrame


	-- [[ Title ]] --
	-- [ Instances ] --
	CommandBar.TextLabel = Instance.new("TextLabel")

	-- [ Effects ] --
	local UICorner = Instance.new("UICorner")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	-- [ Properties ] --
	CommandBar.TextLabel.Parent = CommandBar.CommandBarFrame
	CommandBar.TextLabel.AnchorPoint = Vector2.new(0.5, 1)
	CommandBar.TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	CommandBar.TextLabel.Position = UDim2.new(0.5, 0, 0.025, 0)
	CommandBar.TextLabel.Size = UDim2.new(0.4, 0, 0.25, 0)
	CommandBar.TextLabel.ZIndex = 0
	CommandBar.TextLabel.Font = Enum.Font.SciFi
	CommandBar.TextLabel.Text = "Tigron Hub"
	CommandBar.TextLabel.TextColor3 = Color3.fromRGB(255, 125, 0)
	CommandBar.TextLabel.TextScaled = true
	CommandBar.TextLabel.TextSize = 28
	CommandBar.TextLabel.TextWrapped = true

	-- Effects --
	UICorner.CornerRadius = UDim.new(0.2, 0)
	UICorner.Parent = CommandBar.TextLabel

	UITextSizeConstraint.Parent = CommandBar.TextLabel
	UITextSizeConstraint.MaxTextSize = 28


	-- [[ Command Box ]] --
	-- [ Instances ] --
	CommandBar.CommandBox = Instance.new("TextBox")
	CommandBar.Execute = Instance.new("ImageButton")

	-- [ Effects ] --
	local UICorner = Instance.new("UICorner")
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	local UIPadding = Instance.new("UIPadding")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	-- [ Properties ] --
	CommandBar.CommandBox.Name = "CommandFrame"
	CommandBar.CommandBox.Parent = CommandBar.CommandBarFrame
	CommandBar.CommandBox.AnchorPoint = Vector2.new(0.5, 0.5)
	CommandBar.CommandBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	CommandBar.CommandBox.BorderSizePixel = 0
	CommandBar.CommandBox.Position = UDim2.new(0.5, 0, 0.255, 0)
	CommandBar.CommandBox.Size = UDim2.new(0.75, 0, 0.4, 0)
	CommandBar.CommandBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	CommandBar.CommandBox.PlaceholderText = "Command"
	CommandBar.CommandBox.Text = ""
	CommandBar.CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	CommandBar.CommandBox.TextScaled = true
	CommandBar.CommandBox.TextSize = 16
	CommandBar.CommandBox.TextWrapped = true
	CommandBar.CommandBox.TextXAlignment = Enum.TextXAlignment.Left

	CommandBar.Execute.Name = "Execute"
	CommandBar.Execute.Parent = CommandBar.CommandBox
	CommandBar.Execute.AnchorPoint = Vector2.new(0.5, 0.5)
	CommandBar.Execute.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CommandBar.Execute.BackgroundTransparency = 1
	CommandBar.Execute.BorderSizePixel = 0
	CommandBar.Execute.Position = UDim2.new(0.9, 0, 0.5, 0)
	CommandBar.Execute.Size = UDim2.new(0.8, 0, 0.8, 0)
	CommandBar.Execute.AutoButtonColor = false
	CommandBar.Execute.Image = "rbxassetid://4384407160"
	CommandBar.Execute.ScaleType = Enum.ScaleType.Fit

	-- Effect Properties --
	UICorner.CornerRadius = UDim.new(0.1, 0)
	UICorner.Parent = CommandBar.CommandBox

	UIAspectRatioConstraint.Parent = CommandBar.Execute

	UIPadding.Parent = CommandBar.CommandBox
	UIPadding.PaddingLeft = UDim.new(0.025, 0)

	UITextSizeConstraint.Parent = CommandBar.CommandBox
	UITextSizeConstraint.MaxTextSize = 16

	-- [[ Effect Scripts ]] --
	local function FocusLost(CorrectInput, inputThatCausedFocusLost)
		if CorrectInput then
			local String = CommandBar.CommandBox.Text
			CommandBar.CommandBox.Text = ""
			CommandBar.Execute.Image = "rbxassetid://4370306254"

			CommandBar.CommandBox:ReleaseFocus()
			Tween(CommandBar.CommandBox, TweenInfo.new(0.1), {Size = UDim2.new(0.75, 0, 0.4, 0)})

			Tween(CommandBar.Execute, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Rotation = 360, Size = UDim2.new(0.75, 0, 0.75, 0)})
			wait(0.1)
			local NextTweenInfo = {Image = "rbxassetid://3944669799", Color = Color3.fromRGB(250, 25, 25)}
			if ExecuteCommand(String) == true then
				NextTweenInfo.Image = "rbxassetid://3944680095"
				NextTweenInfo.Color = Color3.fromRGB(25, 240, 25)
			end
			CommandBar.Execute.Image = NextTweenInfo.Image
			Tween(CommandBar.Execute, TweenInfo.new(0.05), {ImageColor3 = NextTweenInfo.Color})
			wait(1)
			Tween(CommandBar.Execute, TweenInfo.new(0.15), {ImageColor3 = Color3.new(255,255,255), Rotation = 0, Size = UDim2.new(0.8, 0, 0.8, 0)})
			CommandBar.Execute.Image = "rbxassetid://4384407160"
		end
	end

	CommandBar.CommandBox.Focused:Connect(function()
		Tween(CommandBar.Execute, TweenInfo.new(0.1), {Size = UDim2.new(0.755, 0, 0.405, 0), ImageColor3 = Color3.new(255,255,255), Rotation = 0, Size = UDim2.new(0.8, 0, 0.8, 0)})
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


	-- [[ Button Frame ]] --
	-- [ Instances ] --
	CommandBar.ButtonFrame = Instance.new("Frame")

	-- [ Effects ] --
	local UIListLayout = Instance.new("UIListLayout")

	-- [ Functions ] --
	CommandBar.ButtonFrameFunction = {}

	function CommandBar.ButtonFrameFunction:CreateButton(IconID, TitleText, ClickFunction)
		local ButtonContent = {}

		-- Instances --
		ButtonContent.Button = Instance.new("Frame")
		ButtonContent.Icon = Instance.new("ImageLabel")
		ButtonContent.Title = Instance.new("TextLabel")

		-- Effects --
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

		-- Properties --
		ButtonContent.Button.Name = TitleText
		ButtonContent.Button.Parent = CommandBar.ButtonFrame
		ButtonContent.Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		ButtonContent.Button.BackgroundTransparency = 0
		ButtonContent.Button.BorderColor3 = Color3.fromRGB(255, 255, 255)
		ButtonContent.Button.BorderSizePixel = 2
		ButtonContent.Button.Size = UDim2.new(1, 0, 0.975, 0)

		ButtonContent.Icon.Name = "Icon"
		ButtonContent.Icon.Parent = ButtonContent.Button
		ButtonContent.Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		ButtonContent.Icon.BackgroundTransparency = 1
		ButtonContent.Icon.Position = UDim2.new(0.5, 0, 0.375, 0)
		ButtonContent.Icon.Size = UDim2.new(0.75, 0, 0.75, 0)
		ButtonContent.Icon.Image = IconID
		ButtonContent.Icon.ScaleType = Enum.ScaleType.Fit

		ButtonContent.Title.Name = "Title"
		ButtonContent.Title.Parent = ButtonContent.Button
		ButtonContent.Title.AnchorPoint = Vector2.new(0.5, 1)
		ButtonContent.Title.BackgroundTransparency = 1
		ButtonContent.Title.Position = UDim2.new(0.5, 0, 0.95, 0)
		ButtonContent.Title.Size = UDim2.new(0.9, 0, 0.225, 0)
		ButtonContent.Title.Font = Enum.Font.SourceSans
		ButtonContent.Title.Text = TitleText
		ButtonContent.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonContent.Title.TextScaled = true

		UIAspectRatioConstraint.Parent = ButtonContent.Button

		-- Actions --
		ButtonContent.Button.MouseEnter:Connect(function()
			Tween(ButtonContent.Icon, TweenInfo.new(0.1), {Size = UDim2.new(0.775, 0, 0.775, 0)})
		end)

		ButtonContent.Button.MouseLeave:Connect(function()
			Tween(ButtonContent.Icon, TweenInfo.new(0.1), {Size = UDim2.new(0.75, 0, 0.75, 0)})
		end)

		ButtonContent.Button.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Tween(ButtonContent.Icon, TweenInfo.new(0.1), {Size = UDim2.new(0.675, 0, 0.675, 0)})
			end
		end)

		ButtonContent.Button.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Tween(ButtonContent.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Size = UDim2.new(0.775, 0, 0.775, 0)})
			end
		end)

		return ButtonContent
	end

	-- [ Properties ] --
	CommandBar.ButtonFrame.Name = "ButtonFrame"
	CommandBar.ButtonFrame.Parent = CommandBar.CommandBarFrame
	CommandBar.ButtonFrame.AnchorPoint = Vector2.new(0.5, 0)
	CommandBar.ButtonFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	CommandBar.ButtonFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
	CommandBar.ButtonFrame.BorderSizePixel = 2
	CommandBar.ButtonFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	CommandBar.ButtonFrame.Size = UDim2.new(0.625, 0, 0.45, 0)

	-- Effect Properties --
	UIListLayout.Parent = CommandBar.ButtonFrame
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0.01, 0)

	-- [ Extras ] --
	CommandBar.Network = CommandBar.ButtonFrameFunction:CreateButton("rbxassetid://4370317928", "Network")
	CommandBar.Changelog = CommandBar.ButtonFrameFunction:CreateButton("rbxassetid://4335484884", "Changelog")
	CommandBar.Commands = CommandBar.ButtonFrameFunction:CreateButton("rbxassetid://4370346095", "Commands")
	CommandBar.Settings = CommandBar.ButtonFrameFunction:CreateButton("rbxassetid://3605022185", "Settings")


	-- [[ Expander ]] --
	-- [ Instances ] --
	CommandBar.Expander = Instance.new("ImageButton")

	-- [ Property ] --
	CommandBar.Expander.Name = "Expander"
	CommandBar.Expander.Parent = CommandBar.CommandBarFrame
	CommandBar.Expander.AnchorPoint = Vector2.new(0, 0.5)
	CommandBar.Expander.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	CommandBar.Expander.BorderSizePixel = 0
	CommandBar.Expander.Position = UDim2.new(1, 0, 0.5, 0)
	CommandBar.Expander.Size = UDim2.new(0.07, 0, 0.325, 0)
	CommandBar.Expander.AutoButtonColor = false
	CommandBar.Expander.Image = "rbxassetid://3610253853"
	CommandBar.Expander.ScaleType = Enum.ScaleType.Fit
	
	
	-- // ChangeLog \\ --
	ChangeLog = CreateContainer("ChangeLog", {ScrollingFrame = true})

	for i,v in ipairs(ChangeLogContent) do
		local Entry = {}

		Entry.Frame = Instance.new("Frame")
		Entry.Frame.Name = "Entry"
		Entry.Frame.Parent = ChangeLog.Main
		Entry.Frame.BackgroundTransparency = 1

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.Parent = Entry.Frame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		Entry.Frame.Size = UDim2.new(0.75, 0, 0, UIListLayout.AbsoluteContentSize.Y + 2.5)
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Entry.Frame.Size = UDim2.new(0.75, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
		end)

		Entry.Title = Instance.new("TextLabel")
		Entry.Title.Name = "EntryTitle"
		Entry.Title.Parent = Entry.Frame
		Entry.Title.AnchorPoint = Vector2.new(0.5, 0)
		Entry.Title.BackgroundTransparency = 1
		Entry.Title.Position = UDim2.new(0.5, 0, 0, 0)
		Entry.Title.Size = UDim2.new(0.55, 0, 1, 0)
		Entry.Title.Text = v.Title
		Entry.Title.TextColor3 = Color3.fromRGB(175, 175, 175)
		Entry.Title.TextScaled = true
		Entry.Title.TextSize = 14
		Entry.Title.TextWrapped = true

		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint.Parent = Entry.Title
		UIAspectRatioConstraint.AspectRatio = 3.5

		for i,v in ipairs(v.Content) do
			local Item = Instance.new("TextLabel")
			Item.Name = "Item"
			Item.Parent = Entry.Frame
			Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Item.BackgroundTransparency = 1.000
			Item.Size = UDim2.new(0.9, 0, 0.3, 0)
			Item.Font = Enum.Font.Roboto
			Item.Text = tostring(i) .. "- " .. v
			Item.TextColor3 = Color3.fromRGB(125, 125, 125)
			Item.TextScaled = true
			Item.TextSize = 20
			Item.TextWrapped = true
			Item.TextXAlignment = Enum.TextXAlignment.Left

			local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint_2.Parent = Item
			UIAspectRatioConstraint_2.AspectRatio = 7.5

			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
			UITextSizeConstraint.Parent = Item
			UITextSizeConstraint.MaxTextSize = 20
		end
	end


	-- // COMMAND LIST \\ --
	Commands = CreateContainer("Commands", {ScrollingFrame = true})

	for i,v in ipairs(CommandList) do
		local TextButton = Instance.new("TextButton")

		TextButton.Parent = Commands.Main
		TextButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		TextButton.Size = UDim2.new(0.75, 0, 0, 30)
		TextButton.Font = Enum.Font.Roboto
		TextButton.Text = tostring(i) .. ". " .. v
		TextButton.TextColor3 = Color3.fromRGB(225, 225, 225)
		TextButton.TextScaled = true
		TextButton.TextSize = 14
		TextButton.TextWrapped = true
		TextButton.TextXAlignment = Enum.TextXAlignment.Left

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
		Tween(CommandBar.CommandBarFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine), Goal)
		CommandBar.Expander.Image = Image

		CommandBarInfo.Expanded = not CommandBarInfo.Expanded
	end)

	-- [ Button Toggles ] --

	-- Toggle Functions --
	local function ToggleChangeLog(Value)
		ChangeLogInfo.Toggled = not ChangeLogInfo.Toggled
		if Value == true or Value == false then
			ChangeLogInfo.Toggled = Value
		end

		ToggleContainer(ChangeLog.Frame, ChangeLogInfo.Toggled)

		local Image = "rbxassetid://4335484884"
		local Info = {Rotation = 0}
		if ChangeLogInfo.Toggled == true then
			Image = "rbxassetid://4335479121"
			Info.Rotation = 360
		end
		Tween(CommandBar.Changelog.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Changelog.Icon.Image = Image
	end

	local function ToggleCommands(Value)
		CommandsInfo.Toggled = not CommandsInfo.Toggled
		if Value == true or Value == false then
			CommandsInfo.Toggled = Value
		end

		ToggleContainer(Commands.Frame, CommandsInfo.Toggled)

		local Image = "rbxassetid://4370346095"
		local Info = {Rotation = 0}
		if CommandsInfo.Toggled == true then
			Image = "rbxassetid://4370319235"
			Info.Rotation = 360
		end
		Tween(CommandBar.Commands.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Commands.Icon.Image = Image
	end

	local function ToggleSettings(Value)
		SettingsInfo.Toggled = not SettingsInfo.Toggled
		if Value == true or Value == false then
			SettingsInfo.Toggled = Value
		end

		ToggleContainer(Settings.Frame, SettingsInfo.Toggled)

		local Image = "rbxassetid://3605022185"
		local Info = {Rotation = 0}
		if SettingsInfo.Toggled == true then
			Image = "rbxassetid://4483345737"
			Info.Rotation = 360
		end
		Tween(CommandBar.Settings.Icon, TweenInfo.new(0.5), Info)
		wait()
		CommandBar.Settings.Icon.Image = Image
	end

	-- Toggle Events --
	CommandBar.Network.Button.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			--bruh
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
	
	return TigronHub
end

return CreateUI
