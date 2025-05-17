--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--// Module
local AnimationService = {}

--// Constants
local animationFolder: Folder = ReplicatedStorage.Animations

--// Variables
local playerAnimations = {}

--// Functions
local function loadAnimationsForCharacter(player: Player, character: Model)
    local humanoid: Humanoid = character:WaitForChild("Humanoid")
	local animator: Animator = humanoid:WaitForChild("Animator")
	local anims = {}

    for i, anim in ipairs(animationFolder:GetChildren()) do
        anims[anim.Name] = animator:LoadAnimation(anim)
    end

    playerAnimations[player.UserId] = anims
end

local function handlePlayer(player: Player)
    player.CharacterAdded:Connect(function(char: Model)
        loadAnimationsForCharacter(player, char)
    end)

    player.CharacterRemoving:Connect(function(char: Model)
        playerAnimations[player.UserId] = {}
    end)

    if player.Character then
        loadAnimationsForCharacter(player, player.Character)
    end
end

--// Methods
function AnimationService:Init()
    for i, player in ipairs(Players:GetPlayers()) do
        handlePlayer(player)
    end

    Players.PlayerAdded:Connect(handlePlayer)
    return true
end

function AnimationService:Play(player: Player, animName: string)
    local anims = playerAnimations[player.UserId]

    if anims and anims[animName] then
        anims[animName]:Play()
    else
        warn("[AnimationService]: Animation not found for:", player.Name, animName .. ".")
    end
end

function AnimationService:Stop(player: Player, animName: string)
    local anims = playerAnimations[player.UserId]
    
	if anims and anims[animName] then
		anims[animName]:Stop()
	end
end

--// Closing
return AnimationService