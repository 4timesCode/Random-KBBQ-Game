-- get services to track player keyboard inputs
local UserInputService = game:GetService("UserInputService")
local Humanoid = script.Parent:WaitForChild("Humanoid")
local R = Enum.KeyCode.R
local debounce = true

-- when the player inputs a key, fire function.
UserInputService.InputBegan:Connect(function(input)
	
	-- if both debounce is true and the key that was pressed was R, 
	-- make player run and show on screen a running icon for the player
	if debounce then
		if input.KeyCode == Enum.KeyCode.R then
			local player = game.Players.LocalPlayer
			local GUI = player.PlayerGui.RunningIcon
			Humanoid.WalkSpeed = 32
			debounce = false
			GUI.Enabled = true
		end
		
	-- if debounce is false and player presses R again, make player walk
	-- and hide the icon. Additionally debounce is reset so they player can toggle again.
	elseif not debounce then
		if input.KeyCode == Enum.KeyCode.R then
			local player = game.Players.LocalPlayer
			local GUI = player.PlayerGui.RunningIcon
			Humanoid.WalkSpeed = 16
			debounce = true
			GUI.Enabled = false
		end
	end
end)
