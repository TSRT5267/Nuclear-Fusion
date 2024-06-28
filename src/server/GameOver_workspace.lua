local bigSphere = script.Parent
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
-- Server Script
local ServerStorage = game:GetService("ServerStorage")
local bindableEvent = ServerStorage:WaitForChild("MyBindableEvent")

-- 거대한 구의 반지름과 위치를 가져옵니다.
local bigSphereRadius = bigSphere.Size.X / 2
local bigSpherePosition = bigSphere.Position

local score =0
-- 매 프레임마다 충돌 감지
game:GetService("RunService").Stepped:Connect(function()
	--점수추가
	for _, player in pairs(Players:GetPlayers()) do				
		local score =player.leaderstats.Score.Value
	end
	 
	for _, smallSphere in ipairs(workspace.Atoms:GetChildren()) do
		local smallSphereRadius = smallSphere.Size.X / 2
		local smallSpherePosition = smallSphere.Position

		-- 두 구 사이의 거리를 계산합니다.
		local distance = (smallSpherePosition - bigSpherePosition).magnitude

		-- 두 구가 충돌하는지 확인합니다.
		if distance + smallSphereRadius > bigSphereRadius  then			
			bindableEvent:Fire(score)
			
		end
	end
end)

--강제 게임 오버
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.P then
			local score = Players.leaderstats.Score.Value
			bindableEvent:Fire(score)
		end
	end
end)