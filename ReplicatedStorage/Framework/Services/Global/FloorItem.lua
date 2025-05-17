--// Services

--// Module
local FloorItem = {}
FloorItem.__index = FloorItem

--// Constants
local framework: Folder = script.Parent.Parent.Parent
local loader: ModuleScript = framework.loader
local required_loader: table = require(loader)

local inventoryService = required_loader:Get("InventoryService")

--// Variables

--// Functions
function FloorItem.new(model: Model, itemData: table)
    local self = setmetatable({}, FloorItem)

    self.Model = model
    self.ItemData = { -- use given values or else use default values
        ID = itemData.ID or "unidentified_item",
        Name = itemData.Name or "Unnamed item",
        Quantity = itemData.Quantity or 1,
        Rarity = itemData.Rarity or "Common"
    }
    self.Prompt = model:FindFirstChildWhichIsA("ProximityPrompt")

    if self.Prompt then
        self.Prompt.Triggered:Connect(function(player)
            self:OnPickup(player)
        end)
    end

    return self
end

--// Methods
function FloorItem:OnPickup(player)
    local success = inventoryService:Add(player, self.ItemData)

    if success then
        self:Destroy()
    end
end

function FloorItem:GetItemData()
    return self.ItemData
end

function FloorItem:Destroy()
    if self.Model then
        self.Model:Destroy()
    end
end

--// Closing
return FloorItem