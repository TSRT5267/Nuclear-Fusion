local Tool = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")



local fireSpeed = 100 --발사속도
local distance = 5 -- 거리

local coolDown = false -- 쿨타임
local coolTime = 0.5 -- 쿨타임 0.5초

-- 공 발사 함수
local function Shooting()	
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	-- 카메라 방향 가져오기
	local camera = workspace.CurrentCamera
	local direction = (camera.CFrame.LookVector).Unit
	-- 공 생성 위치를 플레이어 앞쪽으로 설정
	local spawnPosition = humanoidRootPart.CFrame.Position + (direction * distance)
	--서버로 신호
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")	
	RemoteEvent:FireServer(spawnPosition,direction)
	
end

-- 키 입력을 감지하고 공 발사 함수 호출
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.UserInputType == Enum.UserInputType.MouseButton1 and coolDown == false then
			Shooting()
			coolDown = true
		end
	end
end)

-- 쿨타임 시스템
while true  do
	wait(coolTime)
	coolDown = false
end
