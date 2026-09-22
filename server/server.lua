local RSGCore = exports['rsg-core']:GetCoreObject()

local function sendToDiscord(color, name, message, footer, type)
    local embed = {
            {
                ["color"] = color,
                ["title"] = "**".. name .."**",
                ["description"] = message,
                ["footer"] = {
                ["text"] = footer
            }
        }
    }
    if type == "dice" then
        PerformHttpRequest(Config['Webhooks']['dice'], function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    elseif type == "roullete" then
        PerformHttpRequest(Config['Webhooks']['roullete'], function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    elseif type == "blackjack" then
        PerformHttpRequest(Config['Webhooks']['blackjack'], function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end

----------------------------
-- GAME  - dice
----------------------------
RSGCore.Functions.CreateUseableItem("dice", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("hdrp-dice:client:OpenDice", source)
        Wait(2000)
    end
end)

RSGCore.Functions.CreateUseableItem("dice2", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("hdrp-dice:client:OpenTwoDice", source)
        Wait(2000)
    end
end)

RSGCore.Functions.CreateUseableItem("dice5", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("hdrp-dice:client:OpenThreeDice", source)
        Wait(2000)
    end
end)

RegisterServerEvent('hdrp-dice:server:Discord')
AddEventHandler('hdrp-dice:server:Discord', function(Ndice, ...)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    -- Crear la cadena de resultados concatenando todos los resultados de los dados
    local results = ""
    for i = 1, Ndice do
        local result = select(i, ...)
        if result then
            results = results .. " ┊ Dice: " .. result
        end
    end

    -- Crear el mensaje para Discord
    local discordMessage = string.format(
        "**Citizenid:** %s\n**Ingame ID:** %s\n**Name:** %s %s\n**Nº Dice:** $%d\n**Result:** %s",
        Player.PlayerData.citizenid,
        Player.PlayerData.cid,
        Player.PlayerData.charinfo.firstname,
        Player.PlayerData.charinfo.lastname,
        Ndice,
        results
    )

    -- Enviar el mensaje a Discord
    sendToDiscord(16753920, "Minigame | DICE", discordMessage, "Dice Roll for RSG Framework", "dice")

    -- Notificar al jugador según la configuración
    if Config.Notify == 'rnotify' then
        TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: "..results, "generic_textures", "tick", 4000)
    elseif Config.Notify == 'ox_lib' then
        TriggerClientEvent('ox_lib:notify', src, {title = "Result: "..results, type = 'inform', duration = 5000 })
    elseif Config.Notify == 'RSG' then
        RSGCore.Functions.Notify(src, "Result: "..results, 'success', 4000) -- client
    end
end)

----------------------------
-- GAME  - Roullete
----------------------------
    -- sendToDiscord(16753920, "Minigame | ROULLETE", discordMessage, "Roullete for RSG Framework", "roullete")