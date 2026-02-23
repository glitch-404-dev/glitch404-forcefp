CreateThread(function()
    local forced = false
    local lastCam = nil

    while true do
        Wait(0) -- every frame

        local ped = PlayerPedId()
        local inVehicle = IsPedInAnyVehicle(ped, false)
        local aiming = IsPlayerFreeAiming(PlayerId())

        -- 🚗 INSIDE VEHICLE + RIGHT CLICK → FIRST PERSON
        if inVehicle and aiming then
            if not forced then
                lastCam = GetFollowVehicleCamViewMode()
                forced = true
            end

            SetFollowVehicleCamViewMode(4) -- First person

            -- block scroll so GTA can't override
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)
        end

        -- 🔓 RELEASE (aim chharle OR vehicle theke namle)
        if forced and (not aiming or not inVehicle) then
            if lastCam then
                SetFollowVehicleCamViewMode(lastCam)
            end
            forced = false
            lastCam = nil
        end
    end
end)