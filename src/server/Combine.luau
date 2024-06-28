local Workspace = game:GetService("Workspace")
local atomsList = {"H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne","Na","Mg","Al"}
local atomsFolder = workspace:WaitForChild("Atoms")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- 원자 이름이 atomsList에서 몇 번째에 위치하는지 찾는 함수
local function GetAtomIndex(atomName)
	for index, name in ipairs(atomsList) do
		if name == atomName then
			return index
		end
	end
	return nil -- 목록에 이름이 없을 경우 nil 반환
end

-- 원소 합성 함수
local function Combine(part, otherPart)
	local index = GetAtomIndex(part.Name)
	if index and index < #atomsList then
		local ballTemplate = ReplicatedStorage.Atoms:WaitForChild(atomsList[index + 1])
		local fireSpeed = 100 -- 발사속도
		local spawnPosition = (part.Position + otherPart.Position) / 2
		-- 공 생성
		local ball = ballTemplate:Clone()
		ball.CFrame = CFrame.new(spawnPosition)
		ball.Parent = workspace.Atoms
		-- 공에 물리 효과 추가
		local bodyForce = Instance.new("BodyForce")
		local direction = spawnPosition - workspace.Center.Position
		bodyForce.Force = direction * fireSpeed
		bodyForce.Parent = ball	
		--점수추가
		for _, player in pairs(Players:GetPlayers()) do
			local point = index*(index+1)/2
			player.leaderstats.Score.Value = player.leaderstats.Score.Value + point
		end
		
	end
end

-- 같은 원소 충돌시 제거 후 상위 원소 생성
local function onTouch(part, otherPart)
	if otherPart.Name == part.Name and not part:GetAttribute("Debounce") and not otherPart:GetAttribute("Debounce") then
		if not(part.Name =="Al") then
			part:SetAttribute("Debounce", true)
			otherPart:SetAttribute("Debounce", true)
			part:Destroy()
			otherPart:Destroy()
			Combine(part, otherPart)
		end		
	end
end

-- 모든 물체를 추적하고 Touched 이벤트 연결
local function monitorParts()
	for _, part in pairs(atomsFolder:GetChildren()) do
		part.Touched:Connect(function(otherPart)
			onTouch(part, otherPart)
		end)
	end
end

-- 새로운 물체가 추가될 때마다 Touched 이벤트 연결
Workspace.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("BasePart") and descendant.Parent == atomsFolder then
		descendant.Touched:Connect(function(otherPart)
			onTouch(descendant, otherPart)
		end)
	end
end)

-- 초기 모니터링 설정
monitorParts()

