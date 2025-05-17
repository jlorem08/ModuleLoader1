--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Module
local crateDefinitions = {}

--// Constants
local crates = ReplicatedStorage.Models.Crates

--// Attributes
crateDefinitions.starterCrate = {
    Capacity = 10,
    Model = crates.StarterCrate,
    currentlyStored = {}
}

crateDefinitions.smallCrate = {
    Capacity = 20,
    Model = crates.SmallCrate,
    currentlyStored = {}
}

crateDefinitions.mediumCrate = {
    Capacity = 30,
    Model = crates.MediumCrate,
    currentlyStored = {}
}

crateDefinitions.largeCrate = {
    Capacity = 40,
    Model = crates.LargeCrate,
    currentlyStored = {}
}

--// Variables

--// Methods

--// Closing
return crateDefinitions