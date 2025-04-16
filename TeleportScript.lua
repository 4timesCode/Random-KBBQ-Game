local Players = game:GetService("Players")

-- get the start point and end point for teleportation
workspace.TeleportParts:WaitForChild('TeleportPad')
workspace.TeleportParts:WaitForChild('TeleportDestination')

-- get the player
local player = Players.LocalPlayer

-- get the parts to teleport to
local teleportPad = workspace.TeleportParts.TeleportPad
local teleportDestination = workspace.TeleportParts.TeleportDestination
local debounce = false

-- when a part touches the object, it checks if the object is from a player. 
teleportPad.Touched:Connect(function(hit)
	local plr = Players:GetPlayerFromCharacter(hit.Parent)	
	
	-- if it is a player part that touches the item, teleport them
	if plr == player and debounce == false then
		debounce = true
		plr.Character.HumanoidRootPart.CFrame = teleportDestination.CFrame + Vector3.new(0, 3, 0)
		wait(5)
		debounce = false
	end
end)
