
local BallDetection = {}

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

BallDetection.Target = nil
BallDetection.Distance = math.huge
BallDetection.Speed = 0
BallDetection.Direction = Vector3.zero

function BallDetection:GetCharacterRoot()
    local character = Player.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

function BallDetection:Scan()
    local root = self:GetCharacterRoot()

    if not root then
        self.Target = nil
        return
    end

    local nearest = nil
    local nearestDistance = math.huge

    for _, ball in ipairs(
        CollectionService:GetTagged("SakuraBall")
    ) do
        if ball:IsA("BasePart") and ball:IsDescendantOf(workspace) then
            local distance = (ball.Position - root.Position).Magnitude

            if distance < nearestDistance then
                nearest = ball
                nearestDistance = distance
            end
        end
    end

    self.Target = nearest
    self.Distance = nearestDistance

    if nearest then
        self.Speed = nearest.AssemblyLinearVelocity.Magnitude
        self.Direction = nearest.AssemblyLinearVelocity
    else
        self.Speed = 0
        self.Direction = Vector3.zero
    end
end

function BallDetection.Init(Sakura)
    local Settings = Sakura.Modules.Settings

    RunService.Heartbeat:Connect(function()
        if Settings:Get("BallDetection") then
            BallDetection:Scan()
        else
            BallDetection.Target = nil
        end
    end)

    print("[Sakura] BallDetection ready")
end

return BallDetection

