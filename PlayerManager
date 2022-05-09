local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local PlayerData = DataStoreService:GetDataStore("PlayerData")

local function LeaderboardSetup(valueMoney, valueFame)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local money = Instance.new("IntValue")
	money.Name = "Money"
	money.Value = valueMoney
	money.Parent = leaderstats
	
	local Fame = Instance.new("IntValue")
	Fame.Name = "Fame"
	Fame.Value = valueFame
	Fame.Parent = leaderstats
	return leaderstats
end

local function LoadData(player)
	local success, result = pcall(function()
		print(PlayerData:GetAsync(player.UserId))
		return PlayerData:GetAsync(player.UserId)
		
	end)
	if not success then
		warn(result)
	end
	return success, result
end

local function SaveData(player, data)
	local success, result = pcall(function()
		PlayerData:SetAsync(player.UserId, data)
		print(data)
	end)
	if not success then
		warn(result)
	end
	return success 
end



--RESET STATS
--[[local function EraseData(player, data)
	local success, result = pcall(function()
		PlayerData:RemoveAsync(player.UserId, data)
	end)
	if not success then
		warn(result)
	end
	return success 
end]]


local sessionData = {}

local playerAdded = Instance.new("BindableEvent")
local playerRemoving = Instance.new("BindableEvent")

local PlayerManager = {}

PlayerManager.PlayerAdded = playerAdded.Event
PlayerManager.PlayerRemoving = playerRemoving.Event

function PlayerManager.Start()
	for _, player in ipairs(Players:GetPlayers()) do
		coroutine.wrap(PlayerManager.OnPlayerAdded)(player)
	end

	Players.PlayerAdded:Connect(PlayerManager.OnPlayerAdded)
	Players.PlayerRemoving:Connect(PlayerManager.OnPlayerRemoving)

	game:BindToClose(PlayerManager.OnClose)
end

function PlayerManager.OnPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		PlayerManager.OnCharacterAdded(player, character)
	end)

	local success, data = LoadData(player)
	sessionData[player.UserId] = success and data or {
		Money = 0,
		Fame = 0,
		UnlockIds = {}
	}

	local leaderstats = LeaderboardSetup(PlayerManager.GetMoney(player), PlayerManager.GetFame(player))
	leaderstats.Parent = player

	playerAdded:Fire(player)
end

function PlayerManager.OnCharacterAdded(player, character)
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()
			wait(3)
			player:LoadCharacter()
		end)
	end
end

function PlayerManager.GetMoney(player)
	return sessionData[player.UserId].Money
	
end

function PlayerManager.GetFame(player)
	return sessionData[player.UserId].Fame
end

function PlayerManager.SetMoney(player, value)
	if value then
		sessionData[player.UserId].Money = value
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local money = leaderstats:FindFirstChild("Money")
			if money then
				money.Value = value
			end
		end		
	end
end

function PlayerManager.SetFame(player, value)
	if value then
		sessionData[player.UserId].Fame = value
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local Fame = leaderstats:FindFirstChild("Fame")
			if Fame then
				print("Valeur fame : ".. Fame)
				Fame.Value = value
			end
		end		
	end
end


function PlayerManager.AddUnlockId(player, id)
	local data = sessionData[player.UserId]

	if not table.find(data.UnlockIds, id) then
		table.insert(data.UnlockIds, id)
	end
end

function PlayerManager.GetUnlockIds(player)
	return sessionData[player.UserId].UnlockIds
end

function PlayerManager.OnPlayerRemoving(player)
	SaveData(player, sessionData[player.UserId])
	--EraseData(player, sessionData[player.UserId]) -- RESET STATS
	playerRemoving:Fire(player)
end

function PlayerManager.OnClose()
	--if game:GetService("RunService"):IsStudio() then return end
	for _, player in ipairs(Players:GetPlayers()) do
		PlayerManager.OnPlayerRemoving(player)
	end
end

return PlayerManager
