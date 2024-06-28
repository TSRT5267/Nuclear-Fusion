local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MyRemoteEvent = ReplicatedStorage:WaitForChild("MyRemoteEvent")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

local moveDirection = Vector3.new(0, 0, 0)
local moveSpeed  = 0.5
local centerPosition = workspace:WaitForChild("Center").Position
local distance = 20

humanoid.WalkSpeed = 0
humanoid.JumpPower = 0
humanoid.JumpHeight  = 0

-- 중심으로부터 거리 고정
local function updateMovement()
	local offset = character.PrimaryPart.Position - centerPosition
	local currentDistance = offset.magnitude

	if currentDistance >= distance then
		local direction = (centerPosition - character.PrimaryPart.Position).unit
		local newPosition = centerPosition - direction * distance
		character:SetPrimaryPartCFrame(CFrame.new(newPosition))
	end
end

-- 이동제어
local function updateMoveDirection(input, isPressed)
	if input.KeyCode == Enum.KeyCode.W then
		moveDirection = moveDirection + (isPressed and Vector3.new(0, 1, 0) or Vector3.new(0, -1, 0))
	elseif input.KeyCode == Enum.KeyCode.S then
		moveDirection = moveDirection + (isPressed and Vector3.new(0, -1, 0) or Vector3.new(0, 1, 0))
	elseif input.KeyCode == Enum.KeyCode.A then
		moveDirection = moveDirection + (isPressed and Vector3.new(-1, 0, 0) or Vector3.new(1, 0, 0))
	elseif input.KeyCode == Enum.KeyCode.D then
		moveDirection = moveDirection + (isPressed and Vector3.new(1, 0, 0) or Vector3.new(-1, 0, 0))
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		updateMoveDirection(input, true)
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if not gameProcessed then
		updateMoveDirection(input, false)
	end
end)

RunService.RenderStepped:Connect(function()
	humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(moveDirection * moveSpeed)
	updateMovement()
end)

--강제 게임 오버
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.P then
			local score = Players.leaderstats.Score.Value
			MyRemoteEvent:FireServer(score)
		end
	end
end)


