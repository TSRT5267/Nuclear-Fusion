local ServerStorage = game:GetService("ServerStorage")
local bindableEvent = ServerStorage:WaitForChild("MyBindableEvent")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MyRemoteEvent = ReplicatedStorage:WaitForChild("MyRemoteEvent")
local Players = game:GetService("Players")
-- 이벤트를 수신하고 처리합니다
bindableEvent.Event:Connect(function(message)
	for _, player in pairs(Players:GetPlayers()) do	
		player.PlayerGui:FindFirstChild("GameOver"):WaitForChild("Frame").Visible = true 
	end
end)


MyRemoteEvent.OnServerEvent:Connect(function(player, data)
	--print(player.Name .. " has sent data: " .. data)
	for _, player in pairs(Players:GetPlayers()) do	
		player.PlayerGui:FindFirstChild("GameOver"):WaitForChild("Frame").Visible = true 
	end
end)
