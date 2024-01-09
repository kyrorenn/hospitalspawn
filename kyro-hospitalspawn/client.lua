local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kyro-hospitalspawn:performTeleport')
AddEventHandler('kyro-hospitalspawn:performTeleport', function(closestVector)
    local playerPed = PlayerPedId() 

    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["injail"] > 0 then
            local jailTeleportLocation = Config.JailTeleportLocation
            SetEntityCoords(playerPed, jailTeleportLocation.x, jailTeleportLocation.y, jailTeleportLocation.z, false, false, false, true)

        else
            SetEntityCoords(playerPed, closestVector.x, closestVector.y, closestVector.z, false, false, false, true)
            TriggerServerEvent("kyro-hospitalspawn:charge")

            if exports["qb-policejob"]:IsHandcuffed() then
                TriggerEvent("police:client:GetCuffed", -1)
                TriggerServerEvent("removal:server:removalPlayer", playerPed)
            end
        end
    end)
end)


