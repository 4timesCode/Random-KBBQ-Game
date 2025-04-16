-- getting the remote event
local RepStore = game:GetService("ReplicatedStorage")
local Sleepys = RepStore:WaitForChild("Eepys")

-- get the server storage for quest data
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("Eepys")

-- Get the quest data for the two items
local Bubu = DataStoreService:GetDataStore("BubuGone")
local Dudu = DataStoreService:GetDataStore("DuduGone")
local KittyCounter = 2

-- when the remote event is fired, put the cat onto the bed
Sleepys.OnServerEvent:Connect(function(player, cat, bed)
	
	--remove cat from inventory
	player.Character:WaitForChild(cat, 3):Destroy()
	
	-- clone the cat and depending on its name, will be in a different position
	local Cat = RepStore:WaitForChild(cat, 5)
	local KittyClone = Cat:Clone()
	local PosTable = {
		["Dudu"] = .5,
		["Bubu"] = -.5
	}
	
	--put the object onto the bed
	local BedPos = bed.Position + Vector3.new(PosTable[cat], 0.5, 0)
	KittyClone.Parent = workspace
	KittyClone.Position = BedPos
	
	-- play the sleeping sound effect
	local snoozesound = bed:WaitForChild("Snooze")
	snoozesound:Play()
	
	-- set a random time for the cat to make sound effect
	local waittime = math.random(9, 60)
	KittyCounter -= 1
	
	-- save the data for which cat was retrieved
	if cat.Name == "Bubu" then 
		Bubu:SetAsync(player.UserId, true)
	end
	if cat.Name == "Dudu" then 
		Dudu:SetAsync(player.UserId, true)
	end
	
	-- if both cats are put into the bed, give the player money 
	-- and save that they finished quest
	if KittyCounter == 0 then
		player.leaderstats.Money.Value += 50
		local Awww = bed:WaitForChild("Awww")
		Awww:Play()
		DataStore:SetAsync(player.UserId, true)
		script:Destroy()
	end
	
	-- continuously play sleeping sound effects 
	while wait(waittime) do
		print(waittime)
		snoozesound:Play()
		local waittime = math.random(9, 60)
	end
end)
