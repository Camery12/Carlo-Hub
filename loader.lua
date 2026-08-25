-- Carlo Hub - Ultimate Edition (Mit 3 Checks nacheinander)
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:FindFirstChild("PlayerGui") or CoreGui

if playerGui:FindFirstChild("CarloHub") then
	playerGui.CarloHub:Destroy()
end

-- --- DEFINITION DES FARM-SKRIPTS (Mit 1., 2. und 3. Check) ---
local farmScriptCode = [[
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(5)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

humanoidRootPart.CFrame = CFrame.new(1809.27673, 1947.51843, 83626.2578, 1, 0, 0, 0, 1, 0, 0, 0, 1)
task.wait(1)

local success, errorMessage = pcall(function()
	local map = workspace:WaitForChild("Map", 10) 
	local console = map.Buildings.CustomsFinal.CustomsBuilding.FinalDoor.Command.Console
	humanoidRootPart.CFrame = console.CFrame
end)

if not success then
	return
end

task.wait(1) 
humanoid.Health = 0 -- 1. Reset

-- 2. Check (1 Sekunde später, direkt mit demselben Humanoid)
task.wait(1)
humanoid.Health = 0

-- 3. Check (1 Sekunde später, direkt mit demselben Humanoid)
task.wait(1)
humanoid.Health = 0

task.wait(10)

game:GetService("ReplicatedStorage").FlowClient.ClientRunner.Event:FireServer("GameManager", "Replay")
]]

-- Main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CarloHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = false
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 255, 0)
uiStroke.Thickness = 1.5
uiStroke.Parent = mainFrame

-- --- SMOOTH LOADING INTRO SCREEN ---
local introFrame = Instance.new("Frame")
introFrame.Name = "IntroFrame"
introFrame.Size = UDim2.new(0, 300, 0, 100)
introFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
introFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
introFrame.BorderSizePixel = 0
introFrame.Parent = screenGui

local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0, 8)
introCorner.Parent = introFrame

local introStroke = Instance.new("UIStroke")
introStroke.Color = Color3.fromRGB(0, 255, 0)
introStroke.Thickness = 1.5
introStroke.Parent = introFrame

local introText = Instance.new("TextLabel")
introText.Size = UDim2.new(1, 0, 0, 40)
introText.Position = UDim2.new(0, 0, 0, 15)
introText.BackgroundTransparency = 1
introText.TextColor3 = Color3.fromRGB(0, 255, 0)
introText.TextSize = 14
introText.Font = Enum.Font.Code
introText.Text = "Loading Carlo Hub..."
introText.Parent = introFrame

local loadBarBg = Instance.new("Frame")
loadBarBg.Size = UDim2.new(0, 260, 0, 8)
loadBarBg.Position = UDim2.new(0.5, -130, 0, 65)
loadBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
loadBarBg.BorderSizePixel = 0
loadBarBg.Parent = introFrame

local loadBarBgCorner = Instance.new("UICorner")
loadBarBgCorner.CornerRadius = UDim.new(0, 4)
loadBarBgCorner.Parent = loadBarBg

local loadBarFill = Instance.new("Frame")
loadBarFill.Size = UDim2.new(0, 0, 1, 0)
loadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
loadBarFill.BorderSizePixel = 0
loadBarFill.Parent = loadBarBg

local loadBarFillCorner = Instance.new("UICorner")
loadBarFillCorner.CornerRadius = UDim.new(0, 4)
loadBarFillCorner.Parent = loadBarFill

local toggleUI

task.spawn(function()
	local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local tween = TweenService:Create(loadBarFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
	tween:Play()
	tween.Completed:Wait()
	
	local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(introFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
	TweenService:Create(introText, fadeInfo, {TextTransparency = 1}):Play()
	TweenService:Create(loadBarBg, fadeInfo, {BackgroundTransparency = 1}):Play()
	TweenService:Create(loadBarFill, fadeInfo, {BackgroundTransparency = 1}):Play()
	TweenService:Create(introStroke, fadeInfo, {Transparency = 1}):Play()
	task.wait(0.4)
	introFrame:Destroy()
	
	toggleUI()
end)

-- GUI Elements
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 40, 0)
titleBar.BorderSizePixel = 0
titleBar.TextColor3 = Color3.fromRGB(0, 255, 0)
titleBar.TextSize = 14
titleBar.Font = Enum.Font.Code
titleBar.Text = "  [ Carlo Hub ]"
titleBar.TextXAlignment = Enum.TextXAlignment.Left
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- --- TITLE BAR DRAGGING LOGIC ---
local dragging, dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- --- LARGER PURPLE CLOSE BUTTON (macOS Style) ---
local purpleCloseBtn = Instance.new("TextButton")
purpleCloseBtn.Size = UDim2.new(0, 26, 0, 26)
purpleCloseBtn.Position = UDim2.new(1, -34, 0.5, -13)
purpleCloseBtn.BackgroundColor3 = Color3.fromRGB(160, 60, 220)
purpleCloseBtn.BorderSizePixel = 0
purpleCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
purpleCloseBtn.TextSize = 14
purpleCloseBtn.Font = Enum.Font.GothamBold
purpleCloseBtn.Text = "×" 
purpleCloseBtn.Parent = titleBar

local macCorner = Instance.new("UICorner")
macCorner.CornerRadius = UDim.new(1, 0)
macCorner.Parent = purpleCloseBtn

local macStroke = Instance.new("UIStroke")
macStroke.Color = Color3.fromRGB(220, 140, 255)
macStroke.Transparency = 0.2
macStroke.Thickness = 1.2
macStroke.Parent = purpleCloseBtn

-- --- OUTER WHITE RING & MOBILE BUTTON ---
local outerRing = Instance.new("TextButton")
outerRing.Size = UDim2.new(0, 66, 0, 66)
outerRing.Position = UDim2.new(0, 20, 0.5, -33)
outerRing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
outerRing.BorderSizePixel = 0
outerRing.Text = ""
outerRing.Visible = false
outerRing.Active = true
outerRing.Parent = screenGui

local outerRingCorner = Instance.new("UICorner")
outerRingCorner.CornerRadius = UDim.new(1, 0)
outerRingCorner.Parent = outerRing

local mobileBtn = Instance.new("TextLabel")
mobileBtn.Size = UDim2.new(0, 60, 0, 60)
mobileBtn.Position = UDim2.new(0, 3, 0, 3)
mobileBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mobileBtn.BorderSizePixel = 0
mobileBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
mobileBtn.TextSize = 18
mobileBtn.Font = Enum.Font.Code
mobileBtn.Text = "CH"
mobileBtn.Parent = outerRing

local mobileCorner = Instance.new("UICorner")
mobileCorner.CornerRadius = UDim.new(1, 0)
mobileCorner.Parent = mobileBtn

local mobileStroke = Instance.new("UIStroke")
mobileStroke.Color = Color3.fromRGB(0, 255, 0)
mobileStroke.Thickness = 2
mobileStroke.Parent = mobileBtn

local mobDragging = false
local mobDragInput, mobDragStart, mobStartPos
local totalMoved = 0

outerRing.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		mobDragging = true
		mobDragStart = input.Position
		mobStartPos = outerRing.Position
		totalMoved = 0
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				mobDragging = false
				if totalMoved < 10 then
					toggleUI()
				end
			end
		end)
	end
end)

outerRing.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		mobDragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == mobDragInput and mobDragging then
		local delta = input.Position - mobDragStart
		totalMoved = math.abs(delta.X) + math.abs(delta.Y)
		outerRing.Position = UDim2.new(mobStartPos.X.Scale, mobStartPos.X.Offset + delta.X, mobStartPos.Y.Scale, mobStartPos.Y.Offset + delta.Y)
	end
end)

-- Tab Holder
local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, -20, 0, 30)
tabHolder.Position = UDim2.new(0, 10, 0, 42)
tabHolder.BackgroundTransparency = 1
tabHolder.Parent = mainFrame

local function createTabButton(name, xPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 100, 1, 0)
	btn.Position = UDim2.new(0, xPos, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	btn.BorderSizePixel = 0
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 12
	btn.Font = Enum.Font.Code
	btn.Text = name
	btn.Parent = tabHolder
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	return btn
end

local tab1Btn = createTabButton("Farm", 0)
local tab2Btn = createTabButton("Functions", 110)
local tab3Btn = createTabButton("Settings", 220)

-- Content Container
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -135)
contentFrame.Position = UDim2.new(0, 10, 0, 80)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- --- TAB 1: Farm ---
local tab1Content = Instance.new("Frame")
tab1Content.Size = UDim2.new(1, 0, 1, 0)
tab1Content.BackgroundTransparency = 1
tab1Content.Visible = true
tab1Content.Parent = contentFrame

local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0.83, -5, 0, 50)
farmButton.Position = UDim2.new(0, 0, 0, 20)
farmButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
farmButton.BorderSizePixel = 0
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.TextSize = 13
farmButton.Font = Enum.Font.Code
farmButton.Text = "EXECUTE CREDZ FARM"
farmButton.Parent = tab1Content

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = farmButton

local copyScriptBtn = Instance.new("TextButton")
copyScriptBtn.Size = UDim2.new(0.17, 0, 0, 50)
copyScriptBtn.Position = UDim2.new(0.83, 5, 0, 20)
copyScriptBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
copyScriptBtn.BorderSizePixel = 0
copyScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyScriptBtn.TextSize = 12
copyScriptBtn.Font = Enum.Font.Code
copyScriptBtn.Text = "COPY"
copyScriptBtn.Parent = tab1Content

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 6)
copyCorner.Parent = copyScriptBtn

-- Copy-Button kopiert exakt den gleichen String
copyScriptBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(farmScriptCode)
	end
end)

-- Farm-Execution führt exakt den gleichen String aus
farmButton.MouseButton1Click:Connect(function()
	task.spawn(function()
		local execFunc, err = loadstring(farmScriptCode)
		if execFunc then
			execFunc()
		else
			warn("Fehler beim Ausführen des Farm-Skripts:", err)
		end
	end)
end)

-- --- TAB 2: Functions ---
local tab2Content = Instance.new("ScrollingFrame")
tab2Content.Size = UDim2.new(1, 0, 1, 0)
tab2Content.BackgroundTransparency = 1
tab2Content.BorderSizePixel = 0
tab2Content.ScrollBarThickness = 4
tab2Content.Visible = false
tab2Content.Parent = contentFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = tab2Content

local function addFunctionRow(text, callback, rawScriptCode)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 38)
	container.BackgroundTransparency = 1
	container.Parent = tab2Content
	
	local funcBtn = Instance.new("TextButton")
	funcBtn.Size = UDim2.new(0.83, -5, 1, 0)
	funcBtn.Position = UDim2.new(0, 0, 0, 0)
	funcBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	funcBtn.BorderSizePixel = 0
	funcBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	funcBtn.TextSize = 13
	funcBtn.Font = Enum.Font.Code
	funcBtn.Text = text
	funcBtn.Parent = container
	
	local c1 = Instance.new("UICorner")
	c1.CornerRadius = UDim.new(0, 6)
	c1.Parent = funcBtn
	
	funcBtn.MouseButton1Click:Connect(callback)
	
	local copyBtn = Instance.new("TextButton")
	copyBtn.Size = UDim2.new(0.17, 0, 1, 0)
	copyBtn.Position = UDim2.new(0.83, 5, 0, 0)
	copyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	copyBtn.BorderSizePixel = 0
	copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	copyBtn.TextSize = 12
	copyBtn.Font = Enum.Font.Code
	copyBtn.Text = "COPY"
	copyBtn.Parent = container
	
	local c2 = Instance.new("UICorner")
	c2.CornerRadius = UDim.new(0, 6)
	c2.Parent = copyBtn
	
	copyBtn.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(rawScriptCode)
		end
	end)
end

addFunctionRow("Increase Speed (WalkSpeed 50)", function()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = 50
	end
end, 'local player = game.Players.LocalPlayer\nif player.Character and player.Character:FindFirstChild("Humanoid") then\n\tplayer.Character.Humanoid.WalkSpeed = 50\nend')

addFunctionRow("Reset WalkSpeed (16)", function()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = 16
	end
end, 'local player = game.Players.LocalPlayer\nif player.Character and player.Character:FindFirstChild("Humanoid") then\n\tplayer.Character.Humanoid.WalkSpeed = 16\nend')

-- --- TAB 3: Settings ---
local tab3Content = Instance.new("Frame")
tab3Content.Size = UDim2.new(1, 0, 1, 0)
tab3Content.BackgroundTransparency = 1
tab3Content.Visible = false
tab3Content.Parent = contentFrame

local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(1, 0, 0, 40)
destroyBtn.Position = UDim2.new(0, 0, 0, 10)
destroyBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
destroyBtn.BorderSizePixel = 0
destroyBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
destroyBtn.TextSize = 13
destroyBtn.Font = Enum.Font.Code
destroyBtn.Text = "[ DESTROY / CLOSE GUI ]"
destroyBtn.Parent = tab3Content

local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = destroyBtn

local destroyStroke = Instance.new("UIStroke")
destroyStroke.Color = Color3.fromRGB(255, 0, 0)
destroyStroke.Thickness = 1.5
destroyStroke.Parent = destroyBtn

destroyBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Tab Switch Logic
local function switchTab(tabNum)
	tab1Content.Visible = (tabNum == 1)
	tab2Content.Visible = (tabNum == 2)
	tab3Content.Visible = (tabNum == 3)
	
	tab1Btn.BackgroundColor3 = tabNum == 1 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(25, 25, 25)
	tab2Btn.BackgroundColor3 = tabNum == 2 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(25, 25, 25)
	tab3Btn.BackgroundColor3 = tabNum == 3 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(25, 25, 25)
end

tab1Btn.MouseButton1Click:Connect(function() switchTab(1) end)
tab2Btn.MouseButton1Click:Connect(function() switchTab(2) end)
tab3Btn.MouseButton1Click:Connect(function() switchTab(3) end)

tab1Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Info & Toggle Animation Handler
local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, 0, 0, 20)
infoText.Position = UDim2.new(0, 0, 1, -20)
infoText.BackgroundTransparency = 1
infoText.TextColor3 = Color3.fromRGB(100, 100, 100)
infoText.TextSize = 11
infoText.Font = Enum.Font.Code
infoText.Text = "Toggle UI: [F1]"
infoText.Parent = mainFrame

local isOpened = false
local isTweening = false

toggleUI = function()
	if isTweening then return end
	isTweening = true
	
	if isOpened then
		local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})
		closeTween:Play()
		closeTween.Completed:Wait()
		mainFrame.Visible = false
		outerRing.Visible = true
		isOpened = false
	else
		outerRing.Visible = false
		mainFrame.Visible = true
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		
		local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 520, 0, 380),
			Position = UDim2.new(0.5, -260, 0.5, -190)
		})
		openTween:Play()
		openTween.Completed:Wait()
		isOpened = true
	end
	
	isTweening = false
end

-- Keybind F1
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.F1 then
		toggleUI()
	end
end)

-- Purple X Button connection
purpleCloseBtn.MouseButton1Click:Connect(function()
	toggleUI()
end)

print("Carlo Hub fully optimized and loaded!")
