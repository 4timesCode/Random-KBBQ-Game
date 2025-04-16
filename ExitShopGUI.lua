--This code activates when the player clicks on the button to exit the shop UI
script.Parent.MouseButton1Click:Connect(function()
	
	-- activates the player GUI
	script.Parent.Parent.Active = not script.Parent.Parent.Active
	
	--enables player movement 
	local player = game.Players.LocalPlayer
	local playerscripts = player:WaitForChild("PlayerScripts")
	local PlayerModule = require(playerscripts:WaitForChild("PlayerModule"))
	local Controls = PlayerModule:GetControls()
	Controls:Enable()
	
	-- Changes the camera position value to default to the first item in the shop
	local PosValue = script.Parent.Parent.Parent.PositionValue
	PosValue.Value = 1
	
	-- Enables the user to see their upgrade stats
	local BoosterGUI = player.PlayerGui:WaitForChild("BoostButton")
	BoosterGUI.Enabled = true
end)
