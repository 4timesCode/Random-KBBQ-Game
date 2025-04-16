-- Get the server storage
local ServerStorage = game:GetService("ServerStorage")

-- get the tool and click detector objects
local Tool = script.Parent
local ClickDetector = Tool.ClickDetector

-- If the player clicks on the item, give them the item they clicked on
ClickDetector.MouseClick:Connect(function(Player)
	local ToolClone = ServerStorage.Drinks:FindFirstChild(Tool.Name):Clone()
	local Handle = ToolClone.Handle
	ToolClone.Parent = Player.Backpack
	Handle.Anchored = false
end)
