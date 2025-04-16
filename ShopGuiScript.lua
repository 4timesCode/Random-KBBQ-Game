-- Get the proximity prompt object
local ProximityPrompt = workspace:WaitForChild("FrontDesk"):WaitForChild("Cashier"):WaitForChild("Head"):WaitForChild("ProximityPrompt")
local ProximityPromptService = game:GetService("ProximityPromptService")

-- find the objects for the shop camera
local ShopCameraPositions = workspace:WaitForChild("ShopCameraPositions")
local StarterShopCamera = ShopCameraPositions:WaitForChild("ShopCamera1")
local Camera = workspace.CurrentCamera

-- get the shop GUI objects and frames
local GUI = script.Parent:WaitForChild("ShopGui")
local Value = GUI.ShopFrame.Value:WaitForChild("TextLabel")
local Title = GUI.ShopFrame.Title:WaitForChild("TextLabel")
local Description = GUI.ShopFrame.Description:WaitForChild("TextLabel")
local PurchaseAmount = GUI:WaitForChild("PurchaseAmount")

-- get the Replicated storage items
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemFolder = ReplicatedStorage:WaitForChild("ItemDescriptions")
local TissueFolder = ItemFolder:WaitForChild("Item1")


-- when the player interacts with the proximity prompt, 
-- open the shop UI and set the camera to the first shop camera position
ProximityPrompt.Triggered:Connect(function(player)
	
	-- get the player controls and disable them so they cannot move while in the shop
	local playerscripts = player:WaitForChild("PlayerScripts")
	local PlayerModule = require(playerscripts:WaitForChild("PlayerModule"))
	local Controls = PlayerModule:GetControls()
	Controls:Disable()
	
	-- disable player GUI
	local BoosterGui = player.PlayerGui:WaitForChild("BoostButton")
	BoosterGui.Enabled = false
	local BoosterValuesGui = player.PlayerGui:WaitForChild("ValuesGUI")
	BoosterValuesGui.Enabled = false
	GUI.Enabled = not GUI.Enabled
	
	-- set the player's camera to the shop camera
	Camera.CFrame = StarterShopCamera.CFrame
	Camera.CameraType = Enum.CameraType.Scriptable
	
	-- Get the camera values 
	local PositionValue = GUI:WaitForChild("PositionValue")
	
	-- check the bool values for if the item has been bought or not 
	local BoolValue = workspace.ShopCameraPositions:WaitForChild("ShopCamera" .. PositionValue.Value):WaitForChild("Pos" .. PositionValue.Value)
	
	local BuyButton = GUI.ShopFrame:WaitForChild("BuyButton")
	
	-- load the text onto the shop UI
	Title.Text = TissueFolder.Title.Value
	Description.Text = TissueFolder.Description.Value
	Value.Text = "Costs: " .. TissueFolder.Value.Value
	PurchaseAmount.Value = TissueFolder.PurchaseAmount.Value
	
	-- if the item has been bought, set the button text to "Sold!"
	if BoolValue.Value == true then
		BuyButton.Text = "Purchase"
	else
		BuyButton.Text = "Sold!"
	end
	
end)

-- Sets camera back to player and enables player GUI
GUI.ShopFrame.ExitButton.Activated:Connect(function(mouse)
	GUI.Enabled = not GUI.Enabled
	Camera.CameraType = Enum.CameraType.Custom
	Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)

-- if the player dies while in shop, set their GUI to not be visible and have their camera snap back to their head
game.Players.LocalPlayer.CharacterAdded:Connect(function(player)
	GUI.Enabled = false
	Camera.CameraType = Enum.CameraType.Custom
	Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)
