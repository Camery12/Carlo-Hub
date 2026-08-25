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

-- 3. Check (noch eine kurze Sicherung / 3. Check direkt hinterher)
task.wait(1)
humanoid.Health = 0

task.wait(10)

game:GetService("ReplicatedStorage").FlowClient.ClientRunner.Event:FireServer("GameManager", "Replay")
]]
