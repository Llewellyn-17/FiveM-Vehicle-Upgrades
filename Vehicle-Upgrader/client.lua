RegisterCommand(
    "vehicle",
    function(source, args)
        local category = args[1]
        if category == "spawn" then
            local vehicle = args[2]
            local carPaint = colors.matte["Red"]
            local veh = spawnVeh(vehicle, true)
            print(string.format("Spawned in a(n) %s.", GetLabelText(GetDisplayNameFromVehicleModel(vehicle))))
            SetVehicleColours(veh, carPaint, carPaint)
        elseif category == "custom" then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleModKit(veh, 0)
            for modType = 0, 10, 1 do 
                -- You can do 50 iterations total 
                -- to loop through ALL customizations 
                -- the first 10 iterations will
                -- apply body features
                local bestMod = GetNumVehicleMods(veh, modType)-1 -- we will subtract by one to notice differences easier (imo)
                SetVehicleMod(veh, modType, bestMod, false)
            end
        elseif category == "extras" then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            for id=0, 20 do
                if DoesExtraExist(veh, id) then
                    SetVehicleExtra(veh, id, 1) -- p3 should be 0 for off or 1 for on
                end
            end
        elseif category == "fix" then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleFixed(veh)
            SetVehicleEngineHealth(veh, 1000.0) 
        elseif category == "doors" then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local open = GetVehicleDoorAngleRatio(veh, 0) < 0.1
            if open then
                for i = 0, 7, 1 do
                    SetVehicleDoorOpen(veh, i, false, false)
                end
            else
                SetVehicleDoorsShut(veh, false)
            end
        elseif category == "upgrade" then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local color = colors.matte["Black"]
            local ourSelection = {
                -- These will be the upgrades we want to install
                -- They can be changed by changing the name to same name as upgrades.lua
                ["Armour"] = "Armor Upgrade 100%",
                ["Engine"] = "EMS Upgrade, Level 4",
                ["Transmission"] = "Race Transmission",
                ["Suspension"] = "Competition Suspension",
                ["Horns"] = "Clown Horn",
                ["Brakes"] = "Race Brakes",
                ["Lights"] = "Xenon Lights",
                ["Turbo"] = "Turbo Tuning",
                ["Wheel"] = "Stock"
            }
            SetVehicleModKit(veh, 0)
            for k, v in pairs(ourSelection) do
                local modType = upgrades[k].type
                local mod = upgrades[k].types[v].index
                ApplyVehicleMod(veh, modType, mod)
            end
            SetVehicleColours(veh, color, color)
            ToggleVehicleMod(veh, upgrades["Lights"].type, true)
            SetVehicleXenonLightsColour(veh, upgrades["Lights"].xenonHeadlightColors["Red"].index)
            
        end
    end
)
-- Commands can be changed by changing the name as an example look below
-- elseif category == "custom" then
-- below will be the changed command
-- elseif category == "customize" then
-- Changing the command will need you to do /ensure Vehicle in your chat or by a restart to make the changes

-- changing the colour your car comes out 
-- go to line 7 and in the "Red"
-- change this to whatever colour you want your cars to come out as 
-- look at the paints.lua and make it the same 
-- finishes off the colour
-- same line as the colour (7) colors.matte
-- change this to colour.classic for a classic finish

-- same for changing the xenon colour in the["Red"] can be changed to whatever colour you want
