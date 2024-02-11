local QBCore = exports['qb-core']:GetCoreObject()


local function CalculateDistanceSquared(x1, y1, z1, x2, y2, z2)
    return (x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2
end


local function CalculateDistance(x1, y1, z1, x2, y2, z2)
    return math.sqrt(CalculateDistanceSquared(x1, y1, z1, x2, y2, z2))
end

RegisterServerEvent('kyro-hospitalspawn:toClosestVector')
AddEventHandler('kyro-hospitalspawn:toClosestVector', function()
    local Player = QBCore.Functions.GetPlayer(src)
    local player = source
    local playerPed = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(playerPed)
    local closestVector = nil
    local minDistance = math.huge
    for _, vector in ipairs(Config.Vectors) do
        if vector.x and vector.y and vector.z then
            local dist = CalculateDistance(playerCoords.x, playerCoords.y, playerCoords.z, vector.x, vector.y, vector.z)
            
            if dist < minDistance then
                minDistance = dist
                closestVector = vector
            end
        end
    end
    
    if closestVector then
        TriggerClientEvent('kyro-hospitalspawn:performTeleport', player, closestVector)
    end
end)

RegisterServerEvent('kyro-hospitalspawn:charge', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cost = Config.Cost

    Player.Functions.RemoveMoney('bank', cost, 'Hospital-Transport')
end)




----------------------------item removal----------------------------------

RemovalItems = Config.items

RegisterNetEvent('removal:server:removalPlayer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    for slot, item in pairs(Player.PlayerData.items) do
        if RemovalItems[item.name] then
            Player.Functions.RemoveItem(item.name, item.amount, slot)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
            TriggerClientEvent("inventory:client:UpdatePlayerInventory", src, true)
        end
    end
end)

