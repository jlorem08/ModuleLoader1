--// Services

--// Module
local FloorItemSpawner = {}

--// Constants
local framework: Folder = script.Parent.Parent.Parent
local loader: ModuleScript = framework.loader
local required_loader: table = require(loader)

local FloorItem = required_loader:Get("FloorItem")
local ItemDefinitions = required_loader:Get("ItemDefinitions")

--// Variables

--// Methods
function FloorItemSpawner.Spawn(id: string, position: Vector3)
    local def = ItemDefinitions[id]

    if not def then
        warn("No item definitions found for ID: ", id)
        return nil
    end

    local model = def.Model:Clone()
	model:SetPrimaryPartCFrame(CFrame.new(position))
	model.Parent = workspace

    local itemData = table.clone(def.ItemData)
    itemData.Quantity = 1

    return FloorItem.new(model, itemData)
end

--// Closing
return FloorItemSpawner