--// Services
local Players = game:GetService("Players")

--// Module
local InventoryService = {}

--// Constants

--// Variables
local inventories = {}

--// Methods
function InventoryService:Init()
    Players.PlayerAdded:Connect(function(player)
        inventories[player] = {}
    end)

    Players.PlayerRemoving:Connect(function(player)
        inventories[player] = nil
    end)

    return true
end

function InventoryService:Add(player: Player, itemData: table): boolean
    if not inventories[player] then return false end
    local inventory = inventories[player]

    for i, item in ipairs(inventory) do -- "stack" identical items together when more than 1 exist
        if item.ID == itemData.ID then
            item.Quantity += itemData.Quantity or 1
            return true
        end
    end

    table.insert(inventory, {
        ID = itemData.ID,
        Name = itemData.Name,
        Quantity = itemData.Quantity or 1
    })

    return true
end

function InventoryService:Get(player: Player)
    return inventories[player] or {}
end

function InventoryService:Remove(player: Player, itemID: string, amount: number): boolean
    if not inventories[player] then return false end
    local inventory = inventories[player]

    for i, item in ipairs(inventory) do
        if item.ID == itemID then
            item.Quantity -= amount

            if item.Quantity <= 0 then
                table.remove(inventory, i)
            end

            return true
        end
    end

    return false
end

--// Closing
return InventoryService