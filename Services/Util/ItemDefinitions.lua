--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Module
local itemDefinitions = {}

--// Constants
local floorItemModels = ReplicatedStorage.Models.FloorItems

--// Attributes
itemDefinitions.coconut = {
	Model = floorItemModels.Coconut,
    ItemData = {
        ID="coconut",
        Name="Coconut",
        Rarity="Common"
    }
}

itemDefinitions.shell = {
	Model = floorItemModels.Shell,
    ItemData = {
        ID="shell",
        Name="Seashell",
        Rarity="Uncommon"
    }
}

itemDefinitions.mineral = {
	Model = floorItemModels.Mineral,
    ItemData = {
        ID="mineral",
        Name="Crystal",
        Rarity="Rare"
    }
}

--// Variables

--// Methods

--// Closing
return itemDefinitions