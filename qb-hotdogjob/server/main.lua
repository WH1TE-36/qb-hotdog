ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Code

local Bail = {}

ESX.RegisterServerCallback('qb-hotdogjob:server:HasMoney', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getMoney() >= Config.Bail then
       xPlayer.removeMoney(Config.Bail)
        Bail[xPlayer.identifier] = true
        cb(true)
    elseif xPlayer.getAccount('bank').money >= Config.Bail then
        xPlayer.removeAccountMoney('bank', Config.Bail)
        Bail[xPlayer.identifier] = true
        cb(true)
    else
        Bail[xPlayer.identifier] = false
        cb(false)
    end
end)

ESX.RegisterServerCallback('qb-hotdogjob:server:BringBack', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if Bail[xPlayer.identifier] then
        xPlayer.addMoney(Config.Bail)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('qb-hotdogjob:server:Sell')
AddEventHandler('qb-hotdogjob:server:Sell', function(Amount, Price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addInventoryItem("cash", math.random(250, 300))
    TriggerClientEvent('inventory:client:ItemBox', src, ESX.GetItems()['cash'], "add",math.random(250, 300))
--xPlayer.addMoney(math.random(250, 300))
    --xPlayer.addMoney(tonumber(Amount * Price))
end)










































--EXTRA LEAKS ! --EXTRA LEAKS ! --EXTRA LEAKS !