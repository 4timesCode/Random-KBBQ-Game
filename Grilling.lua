-- Getting game services
local ServerStorage = game:GetService("ServerStorage")
local RepStore = game:GetService("ReplicatedStorage")

-- call for when player wants to grill
local GrillEvent = RepStore:WaitForChild("StartGrilling")
local debounce = true

-- this game has stolen hours of my life i'll never get back

-- Function fires when player clicks on a grill with raw food in hand
GrillEvent.OnServerEvent:Connect(function(player, food, grill, LessWait)
	
	--sets debounce to false so the user spam sound effects
	debounce = false
	
	--get the food from the player's hand and destroy it
	player.Character:WaitForChild(food, 3):Destroy()
	
	--Clones the food from replicated storage
	local Raw = RepStore:WaitForChild(food, 5)
	local Cooked = RepStore:WaitForChild("Cooked" .. food, 5)
	local RawClone = Raw:Clone()
	local CookedClone = Cooked:Clone()
	
	-- randomly sets the position and rotation of the food onto the grill
	local GrillPos = grill.Position + Vector3.new(0, 2.5, 0)
	local GrillSound = grill.Sizzle
	local RandomPos1 = math.random(-2.500, 1.500)
	local RandomPos2 = math.random(-2.500, 1.500)
	local RandomRotate = math.random(1, 360)
	
	--makes smoke emitter to show its cooking
	local Smoke = RepStore:WaitForChild("ParticleEmitter"):Clone()
	Smoke.Parent = RawClone
	
	--sets the positions and rotations of the cooked and raw variant of the food to be the same.
	RawClone.Parent = workspace
	CookedClone.Parent = workspace
	RawClone.Position = grill.Position + Vector3.new(RandomPos1, 2, RandomPos2)
	CookedClone.Position = grill.Position + Vector3.new(RandomPos1, 2, RandomPos2)
	RawClone.Orientation = Vector3.new(Raw.Rotation.X, RandomRotate, Raw.Rotation.Z)
	CookedClone.Orientation = Vector3.new(Cooked.Rotation.X, RandomRotate, Cooked.Rotation.Z)
	
	-- makes sure raw food can only be seen while cooking 
	RawClone.Transparency = 0
	CookedClone.Transparency = 1
	
	-- sets up click detector so player can't pick up cooked food before its done cooking
	CookedClone:WaitForChild("ClickDetector").MaxActivationDistance = 0
	
	--if the player is spamming foods, then the if branch will stop the sounds from stacking
	if debounce == false then
		GrillSound:Play()
	end
	
	-- the time it takes for the food to cook subtracted by player stat that decreases cooking time
	task.wait(20 - LessWait)
	
	-- Stops the grill sound when task.wait is over
	GrillSound:Stop()
	
	--shows the cooked version and destroys the raw version
	RawClone.Transparency = 1
	RawClone:Destroy()
	CookedClone.Transparency = 0
	
	-- player can now cook and sound can now be played again
	CookedClone:FindFirstChild("ClickDetector").MaxActivationDistance = 32
	debounce = true
end)
