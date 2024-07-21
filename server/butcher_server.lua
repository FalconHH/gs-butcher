local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type


--notification function
local function SendNotify(src, msg, type, time, title)
    if not title then title = "Buthcer" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    end
end





-------------------------------< CALLBACKS >---------------------



--plucked chicken callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:PluckedChicken', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bird = Player.Functions.GetItemByName("pluckedchicken")
    if bird  then
        cb(true)
    else
        cb(false)
    end
end)


--processed chicken callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:ProcessedChicken', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bird = Player.Functions.GetItemByName("processedchicken")
    local knife = Player.Functions.GetItemByName("butcherknife")
    if bird  and knife  then
        cb(true)
    else
        cb(false)
    end
end)


--chicken breast & packaging callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:ChickenBreast', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local breast = Player.Functions.GetItemByName("chickenbreast")
    local packaging = Player.Functions.GetItemByName("foodpackaging")
    if breast  and packaging  then
        cb(true)
    else
        cb(false)
    end
end)


--chicken thighs & packaging callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:ChickenThighs', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local thigh = Player.Functions.GetItemByName("chickenthighs")
    local packaging = Player.Functions.GetItemByName("foodpackaging")
    if thigh  and packaging  then
        cb(true)
    else
        cb(false)
    end
end)


--chicken drumsticks & packaging callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:ChickenDrumsticks', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local drumsticks = Player.Functions.GetItemByName("chickendrumsticks")
    local packaging = Player.Functions.GetItemByName("foodpackaging")
    if drumsticks  and packaging  then
        cb(true)
    else
        cb(false)
    end
end)


--chicken wings & packaging callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:ChickenWings', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local wings = Player.Functions.GetItemByName("chickenwings")
    local packaging = Player.Functions.GetItemByName("foodpackaging")
    if wings  and packaging  then
        cb(true)
    else
        cb(false)
    end
end)


--chicken legs & packaging callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:ChickenLegs', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local legs = Player.Functions.GetItemByName("chickenlegs")
    local packaging = Player.Functions.GetItemByName("foodpackaging")
    if legs  and packaging  then
        cb(true)
    else
        cb(false)
    end
end)


--selling items callback
QBCore.Functions.CreateCallback('lusty94_butcher:get:SellingItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item1 = Player.Functions.GetItemByName('chickenbreastpack')
    local item2 = Player.Functions.GetItemByName('chickenthighspack')
    local item3 = Player.Functions.GetItemByName('chickenwingspack')
    local item4 = Player.Functions.GetItemByName('chickendrumstickspack')
    local item5 = Player.Functions.GetItemByName('chickenlegspack')
    if item1 or item2 or item3 or item4 or item5 then
        cb(true)
    else
        cb(false)
    end
end)




--------------------------------< EVENTS >-------------------------



--give items
RegisterNetEvent('lusty94_butcher:server:GiveItems', function(args, amount)
    local args = tonumber(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if args == 1 then
        if InvType == 'codem' then        
            exports['codem-inventory']:AddItem(src, "butcherknife", 1)
            -- Add any additional client-side notifications here if necessary
        elseif InvType == 'ox' then
            if exports.ox_inventory:CanCarryItem(src, "butcherknife", 1) then
                exports.ox_inventory:AddItem(src, "butcherknife", 1)
            else
                SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
            end
        end
    elseif args == 2 then
        if InvType == 'codem' then        
            exports['codem-inventory']:AddItem(src, "foodpackaging", amount)
            -- Add any additional client-side notifications here if necessary
        elseif InvType == 'ox' then
            if exports.ox_inventory:CanCarryItem(src, "foodpackaging", amount) then
                exports.ox_inventory:AddItem(src, "foodpackaging", amount)
            else
                SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
            end
        end
    end
end)


--pluck chicken
RegisterNetEvent('lusty94_butcher:server:PluckChicken', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then        
        exports['codem-inventory']:AddItem(src, "pluckedchicken", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "pluckedchicken", 1) then
            exports.ox_inventory:AddItem(src, "pluckedchicken", 1)
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end  
end)




--process chicken
RegisterNetEvent('lusty94_butcher:server:ProcessChicken', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "pluckedchicken", 1)
        exports['codem-inventory']:AddItem(src, "processedchicken", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "processedchicken", 1) then
             if exports.ox_inventory:RemoveItem(src, "pluckedchicken", 1) then
                exports.ox_inventory:AddItem(src, "processedchicken", 1)
             end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken breast
RegisterNetEvent('lusty94_butcher:server:ProcessChickenBreast', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then        
        exports['codem-inventory']:RemoveItem(src, "processedchicken", 1)
        exports['codem-inventory']:AddItem(src, "chickenbreast", 2)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenbreast", 2) then
            if exports.ox_inventory:RemoveItem(src, "processedchicken", 1) then
                exports.ox_inventory:AddItem(src, "chickenbreast", 2)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken thighs
RegisterNetEvent('lusty94_butcher:server:ProcessChickenThighs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "processedchicken", 1)
        exports['codem-inventory']:AddItem(src, "chickenthighs", 2)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenthighs", 2) then
            if exports.ox_inventory:RemoveItem(src, "processedchicken", 1) then
                exports.ox_inventory:AddItem(src, "chickenthighs", 2)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken wings
RegisterNetEvent('lusty94_butcher:server:ProcessChickenWings', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "processedchicken", 1)
        exports['codem-inventory']:AddItem(src, "chickenwings", 2)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenwings", 2) then
            if exports.ox_inventory:RemoveItem(src, "processedchicken", 1) then
                exports.ox_inventory:AddItem(src, "chickenwings", 2)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)


--chicken drumsticks
RegisterNetEvent('lusty94_butcher:server:ProcessChickenDrumSticks', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "processedchicken", 1)
        exports['codem-inventory']:AddItem(src, "chickendrumsticks", 2)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickendrumsticks", 2) then
            if exports.ox_inventory:RemoveItem(src, "processedchicken", 1) then
                exports.ox_inventory:AddItem(src, "chickendrumsticks", 2)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken legs
RegisterNetEvent('lusty94_butcher:server:ProcessChickenLegs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then 
        exports['codem-inventory']:RemoveItem(src, "processedchicken", 1)
        exports['codem-inventory']:AddItem(src, "chickenlegs", 2)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenlegs", 2) then
            if exports.ox_inventory:RemoveItem(src, "processedchicken", 1) then
                exports.ox_inventory:AddItem(src, "chickenlegs", 2)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken breast pack
RegisterNetEvent('lusty94_butcher:server:PackChickenBreast', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then 
        exports['codem-inventory']:RemoveItem(src, "chickenbreast", 1)
        exports['codem-inventory']:RemoveItem(src, "foodpackaging", 1)
        exports['codem-inventory']:AddItem(src, "chickenbreastpack", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenbreastpack", 1) then
            if exports.ox_inventory:RemoveItem(src, "chickenbreast", 1) then
                exports.ox_inventory:RemoveItem(src, "foodpackaging", 1)
                exports.ox_inventory:AddItem(src, "chickenbreastpack", 1)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken thighs pack
RegisterNetEvent('lusty94_butcher:server:PackChickenThighs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "chickenthighs", 1)
        exports['codem-inventory']:RemoveItem(src, "foodpackaging", 1)
        exports['codem-inventory']:AddItem(src, "chickenthighspack", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenthighspack", 1) then
            if exports.ox_inventory:RemoveItem(src, "chickenthighs", 1) then
                exports.ox_inventory:RemoveItem(src, "foodpackaging", 1)
                exports.ox_inventory:AddItem(src, "chickenthighspack", 1)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)


--chicken wings pack
RegisterNetEvent('lusty94_butcher:server:PackChickenWings', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "chickenwings", 1)
        exports['codem-inventory']:RemoveItem(src, "foodpackaging", 1)
        exports['codem-inventory']:AddItem(src, "chickenwingspack", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenwingspack", 1) then
            if exports.ox_inventory:RemoveItem(src, "chickenwings", 1) then
                exports.ox_inventory:RemoveItem(src, "foodpackaging", 1)
                exports.ox_inventory:AddItem(src, "chickenwingspack", 1)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken drumsticks pack
RegisterNetEvent('lusty94_butcher:server:PackChickenDrumSticks', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "chickendrumsticks", 1)
        exports['codem-inventory']:RemoveItem(src, "foodpackaging", 1)
        exports['codem-inventory']:AddItem(src, "chickendrumstickspack", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickendrumstickspack", 1) then
            if exports.ox_inventory:RemoveItem(src, "chickendrumsticks", 1) then
                exports.ox_inventory:RemoveItem(src, "foodpackaging", 1)
                exports.ox_inventory:AddItem(src, "chickendrumstickspack", 1)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)

--chicken legs pack
RegisterNetEvent('lusty94_butcher:server:PackChickenLegs', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'codem' then
        exports['codem-inventory']:RemoveItem(src, "chickenlegs", 1)
        exports['codem-inventory']:RemoveItem(src, "foodpackaging", 1)
        exports['codem-inventory']:AddItem(src, "chickenlegspack", 1)
        -- Add any additional client-side notifications here if necessary
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "chickenlegspack", 1) then
            if exports.ox_inventory:RemoveItem(src, "chickenlegs", 1) then
                exports.ox_inventory:RemoveItem(src, "foodpackaging", 1)
                exports.ox_inventory:AddItem(src, "chickenlegspack", 1)
            end
        else
            SendNotify(src, "You Can't Carry Anymore of This Item!", 'error', 2000)
        end
    end 
end)




---------------------------< SELLING >-------------------



--Sell chicken
RegisterNetEvent('lusty94_butcher:server:SellItems', function(args)
    local args = tonumber(args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local itemMap = {
        [1] = {itemName = 'chickenbreastpack', price = Config.Selling.Items.ChickenBreast.Price},
        [2] = {itemName = 'chickenthighspack', price = Config.Selling.Items.ChickenThighs.Price},
        [3] = {itemName = 'chickenwingspack', price = Config.Selling.Items.ChickenWings.Price},
        [4] = {itemName = 'chickendrumstickspack', price = Config.Selling.Items.ChickenDrumsticks.Price},
        [5] = {itemName = 'chickenlegspack', price = Config.Selling.Items.ChickenLegs.Price}
    }

    local selectedItem = itemMap[args]
    if selectedItem then
        local price = selectedItem.price
        local itemName = Player.Functions.GetItemByName(selectedItem.itemName)
        if itemName then
            local itemCount = itemName.amount
            exports['codem-inventory']:RemoveItem(src, selectedItem.itemName, itemCount)
            exports['codem-inventory']:AddItem(src, "cash", price * itemCount)
        else
            SendNotify(src, "You Don't Have Anything To Sell!", 'error', 2000)
        end
    end
end)


