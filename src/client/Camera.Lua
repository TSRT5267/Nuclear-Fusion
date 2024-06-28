local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- 바라보게 할 위치를 설정합니다.
local targetPart = workspace:WaitForChild("Center")  

-- 카메라 업데이트 함수
local function updateCamera()
	if targetPart then
		-- targetPart의 위치를 바라보게 CFrame 설정
		local lookAt = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
		camera.CFrame = lookAt
	end
end

-- RenderStepped 이벤트를 연결하여 매 프레임마다 카메라를 업데이트합니다.
RunService.RenderStepped:Connect(updateCamera)




