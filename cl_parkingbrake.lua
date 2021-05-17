engaged = false

local function setPB(engaged)
    ped, veh = PlayerPedId(), GetVehiclePedIsIn(ped, false)
    SetVehicleHandbrake(veh, engaged)
    SetVehicleBrake(veh, engaged)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent("Super:PBrake:GetPB")
AddEventHandler("Super:PBrake:GetPB", function(eng)
    engaged = eng
    setPB(engaged)
end)

local function dispPark(eng)
    ped = PlayerPedId()
    if eng and IsPedInAnyVehicle(ped, true) then
        drawTxt(0.580, 1.240, 1.0, 1.0, 0.45, "(PARK)", 255, 0, 0, 200)
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        DisableControlAction(0, 76)
        dispPark(engaged)
        if IsControlJustReleased(0, 76) or IsDisabledControlJustPressed(0, 76) then
            engaged = not engaged
            engVeh  = GetVehiclePedIsIn(ped, false)
            setPB(engaged)
            TriggerServerEvent("Super:PBrake:SetPB", engaged)
        end
    end
end)



--[[
Citizen.CreateThread(function()
    local oldEngaged = true
    while true do
        ped, veh = PlayerPedId(), GetVehiclePedIsIn(ped, false)       
        Wait(5)
        dispPark(engaged)
        SetVehicleHandbrake(veh, engaged)
        SetVehicleBrake(veh, engaged)
        
    end
end)]]