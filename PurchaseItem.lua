-- Gets remote events from replicated storage
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PurchaseItem = ReplicatedStorage:WaitForChild("PurchasedItem")
local ItemSold = ReplicatedStorage:WaitForChild("ItemIsSold")

-- gets the player's save data for purchased items
local DataStoreService = game:GetService("DataStoreService")
local PurchaseHistory = DataStoreService:GetDataStore("PlayerPurchases") --PlayerPurchases, PurchaseHistory

-- when the player purchases an item, fire this event 
PurchaseItem.OnServerEvent:Connect(function(player, PurchaseAmount, PosValue)
	-- take out money from player's money 
	player.leaderstats.Money.Value -= PurchaseAmount
	
	-- Get the player data 
	local data = PurchaseHistory:GetAsync(player.UserId)
	
	-- if the player has no existing data, it will update with new data
	local success, errormessage = pcall(function()
		
		if data then 
			data["Item" .. PosValue] = true
		else
			data = {["Item" .. PosValue] = true} 
		end	
	end)
	
	if not success then
		print(errormessage)
	end
	
	-- camera value (indicating what item is being purchased) dictates what buff is permenantly applied to the player. 
	if PosValue == 1 then
		ReplicatedStorage:WaitForChild("TissueBuff"):FireClient(player)
	end

	if PosValue == 2 then
		ReplicatedStorage:WaitForChild("ForkBuff"):FireClient(player)
	end

	if PosValue == 3 then
		ReplicatedStorage:WaitForChild("SpoonBuff"):FireClient(player)
	end

	if PosValue == 4 then
		ReplicatedStorage:WaitForChild("KnifeBuff"):FireClient(player)
	end

	if PosValue == 5 then
		ReplicatedStorage:WaitForChild("ChopstickBuff"):FireClient(player)
	end

	if PosValue == 6 then
		ReplicatedStorage:WaitForChild("MetalBottleBuff"):FireClient(player)
	end

	if PosValue == 7 then
		ReplicatedStorage:WaitForChild("AirTightContainerBuff"):FireClient(player)
	end

	if PosValue == 8 then
		ReplicatedStorage:WaitForChild("RiceCookerBuff"):FireClient(player)
	end

	if PosValue == 9 then
		ReplicatedStorage:WaitForChild("SweetAndSourSauceBuff"):FireClient(player)
	end

	if PosValue == 10 then
		ReplicatedStorage:WaitForChild("SoySauceBuff"):FireClient(player)
	end

	if PosValue == 11 then
		ReplicatedStorage:WaitForChild("KetchupBuff"):FireClient(player)
	end

	if PosValue == 12 then
		ReplicatedStorage:WaitForChild("LaoGanMaBuff"):FireClient(player)
	end

	if PosValue == 13 then
		ReplicatedStorage:WaitForChild("SirachaSauceBuff"):FireClient(player)
	end

	if PosValue == 14 then
		ReplicatedStorage:WaitForChild("OysterBuff"):FireClient(player)
	end

	if PosValue == 15 then
		ReplicatedStorage:WaitForChild("TongsBuff"):FireClient(player)
	end

	if PosValue == 16 then
		ReplicatedStorage:WaitForChild("LiquidPurifierBuff"):FireClient(player)
	end

	if PosValue == 17 then
		ReplicatedStorage:WaitForChild("PropaneTankBuff"):FireClient(player)
	end

	if PosValue == 18 then
		ReplicatedStorage:WaitForChild("AirVentilationBuff"):FireClient(player)
	end

	if PosValue == 19 then
		ReplicatedStorage:WaitForChild("GalvanizedSteelPlatingBuff"):FireClient(player)
	end

	if PosValue == 20 then
		ReplicatedStorage:WaitForChild("HoisinSauceBuff"):FireClient(player)
	end
	
	-- set the async for the new player data 
	PurchaseHistory:SetAsync(player.UserId, data)
	
end)
