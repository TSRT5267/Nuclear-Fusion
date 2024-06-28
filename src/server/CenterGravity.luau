-- 서버 스크립트
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")

local gravitySphere = script.Parent
local GravityStrength = 100

local atomsFolder = workspace:WaitForChild("Atoms")
local atomsList = {"H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne","Na","Mg","Al"}

-- 모든 원자에게 중력 적용 함수
local function applyCustomGravity()
	local spherePosition = gravitySphere.Position
	local atoms = workspace.Atoms:GetChildren()
	for _, part in pairs(atoms) do
		local partPosition = part.Position
		local direction = (spherePosition - partPosition).unit
		part.BodyForce.Force = direction * GravityStrength
	end
end



-- RemoteEvent 핸들러: 공 생성
RemoteEvent.OnServerEvent:Connect(function(player,spawnPosition,direction)
	
	--공 종류 랜덤
	local random_value  = math.random(1,10)
	local temp =0
	if random_value  <= 4 then
		temp = 1
	elseif	random_value  <=7 then
		temp = 2
	elseif	random_value  <=9 then
		temp = 3
	else	 
		temp = 4
	end
	
	--temp = 1
	
	local ballTemplate = ReplicatedStorage.Atoms:WaitForChild(atomsList[temp])	
	local fireSpeed = 100 --발사속도
	-- 공 생성
	local ball = ballTemplate:Clone()
	ball.CFrame = CFrame.new(spawnPosition)
	ball.Parent = workspace.Atoms
	-- 공에 물리 효과 추가
	local bodyForce = Instance.new("BodyForce")
	bodyForce.Force = direction * fireSpeed
	bodyForce.Parent = ball
	
end)



game:GetService("RunService").Stepped:Connect(function(_, deltaTime)
	applyCustomGravity()
end)


---- 자식이 추가될 때마다 applyCustomGravity() 실행
--workspace.Atoms.ChildAdded :Connect(function()
--	print("Child added to Atoms folder")
--	applyCustomGravity()
--end)

---- 자식이 제거될 때마다 applyCustomGravity() 실행
--workspace.Atoms.ChildRemoved:Connect(function()
--	print("Child removed from Atoms folder")
--	applyCustomGravity()
--end)

---- applyCustomGravity()를 초기에 실행
--applyCustomGravity()
