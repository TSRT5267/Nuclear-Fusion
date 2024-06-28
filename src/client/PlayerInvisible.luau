local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- 플레이어 투명화
for _, part in pairs(character:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Transparency = 1 -- 파트의 투명도를 1로 설정하여 보이지 않게 함
		part.CanCollide = false -- 파트의 충돌을 비활성화
		part.CanQuery = false 
		part.CanTouch = false -- 상호작용 비활성화
	end
end

