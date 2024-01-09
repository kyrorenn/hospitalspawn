
 If a player is dead, the script checks their location and teleports them to the nearest hospital or prison infirmary definied in config.lua,

The script also has an item removal to remove specified items on players teleport.

trigger with --   TriggerServerEvent("kyro-hospitalspawn:toClosestVector")

add this into your death timer event in qb-ambulancejob


--[[ function DeathTimer()
    hold = 5
    while isDead do
        Wait(1000)
        deathTime = deathTime - 1
        if deathTime <= 0 then
            if IsControlPressed(0, 38) and hold <= 0 and not isInHospitalBed then
                TriggerServerEvent("kyro-hospitalspawn:toClosestVector")
                hold = 5
            end
            if IsControlPressed(0, 38) then
                if hold - 1 >= 0 then
                    hold = hold - 1
                else
                    hold = 0
                end
            end
            if IsControlReleased(0, 38) then
                hold = 5
            end
        end
    end
end ]]
