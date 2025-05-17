--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Constants
local framework = ReplicatedStorage:WaitForChild("Framework")
local loader = require(framework:WaitForChild("loader"))

--// Variables

--// Functions

--// Logic
loader:Load()