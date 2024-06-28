local Players = game:GetService("Players")

local function onPlayerAdded(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local score = Instance.new("IntValue") 
	score.Name = "Score"
	score.Value = 0
	score.Parent = leaderstats
end

Players.PlayerAdded:Connect(onPlayerAdded)