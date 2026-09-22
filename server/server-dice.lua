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
    end
end

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

--[[ RegisterServerEvent('hdrp-dice:server:Discord')
AddEventHandler('hdrp-dice:server:Discord', function(Ndice, resultdice1, resultdice2, resultdice3, resultdice4, resultdice5)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Ndice == 1 and resultdice1  ~= nil  then
        sendToDiscord(16753920, "Minigame | DICE ",
            "**Citizenid:** "..Player.PlayerData.citizenid..
            "\n**Ingame ID:** "..Player.PlayerData.cid..
            "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..
            "\n**Nº Dice:** $"..Ndice..
            "\n**Result:** ".. " ┊ Dice: "..resultdice1.. " ┊ ",
            "Trader for RSG Framework",
            "dice")

        if Config.Notify == 'rnotify' then
            TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: ".. resultdice1, "generic_textures", "tick", 4000)
        elseif Config.Notify == 'ox_lib' then
            TriggerClientEvent('ox_lib:notify', src, {title = "Result: ".. resultdice1, type = 'inform', duration = 5000 })
        end

    elseif Ndice == 2 and resultdice1  ~= nil and resultdice2  ~= nil then
        sendToDiscord(16753920, "Minigame | DICE ",
            "**Citizenid:** "..Player.PlayerData.citizenid..
            "\n**Ingame ID:** "..Player.PlayerData.cid..
            "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..
            "\n**Nº Dice:** $"..Ndice..
            "\n**Result:** ".. " ┊ Dice: "..resultdice1.. " ┊ Dice: "..resultdice2.. " ┊ ",
            "Trader for RSG Framework",
            "dice")

        if Config.Notify == 'rnotify' then
            TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: ".. resultdice1..' '..resultdice2, "generic_textures", "tick", 4000)
        elseif Config.Notify == 'ox_lib' then
            TriggerClientEvent('ox_lib:notify', src, {title = "Result: ".. resultdice1..' '..resultdice2, type = 'inform', duration = 5000 })
        end
    elseif Ndice == 3 and resultdice1  ~= nil and resultdice2  ~= nil and resultdice3  ~= nil then
        sendToDiscord(16753920, "Minigame | DICE ",
            "**Citizenid:** "..Player.PlayerData.citizenid..
            "\n**Ingame ID:** "..Player.PlayerData.cid..
            "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..
            "\n**Nº Dice:** $"..Ndice..
            "\n**Result:** ".. " ┊ Dice: "..resultdice1.. " ┊ Dice: "..resultdice2.. " ┊ Dice: "..resultdice3..  " ┊ ",
            "Trader for RSG Framework",
            "dice")

        if Config.Notify == 'rnotify' then
            TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: ".. resultdice1 .. ' '..resultdice2 .. ' '..resultdice3  , "generic_textures", "tick", 4000)
        elseif Config.Notify == 'ox_lib' then
            TriggerClientEvent('ox_lib:notify', src, {title = "Result: ".. resultdice1.. ' '..resultdice2 .. ' '..resultdice3, type = 'inform', duration = 5000 })
        end
    elseif Ndice == 4 and resultdice1  ~= nil and resultdice2  ~= nil and resultdice3  ~= nil and resultdice4  ~= nil then
        sendToDiscord(16753920, "Minigame | DICE ",
            "**Citizenid:** "..Player.PlayerData.citizenid..
            "\n**Ingame ID:** "..Player.PlayerData.cid..
            "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..
            "\n**Nº Dice:** $"..Ndice..
            "\n**Result:** ".. " ┊ Dice: "..resultdice1.. " ┊ Dice: "..resultdice2.. " ┊ Dice: "..resultdice3.. " ┊ Dice: "..resultdice4..  " ┊ ",
            "Trader for RSG Framework",
            "dice")

        if Config.Notify == 'rnotify' then
            TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: ".. resultdice1 .. ' '..resultdice2 .. ' '..resultdice3 .. ' '..resultdice4  , "generic_textures", "tick", 4000)
        elseif Config.Notify == 'ox_lib' then
            TriggerClientEvent('ox_lib:notify', src, {title = "Result: ".. resultdice1.. ' '..resultdice2 .. ' '..resultdice3 .. ' '..resultdice4 , type = 'inform', duration = 5000 })
        end
    elseif Ndice == 5 and resultdice1  ~= nil and resultdice2  ~= nil and resultdice3  ~= nil and resultdice4  ~= nil and resultdice5  ~= nil then
        sendToDiscord(16753920, "Minigame | DICE ",
            "**Citizenid:** "..Player.PlayerData.citizenid..
            "\n**Ingame ID:** "..Player.PlayerData.cid..
            "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..
            "\n**Nº Dice:** $"..Ndice..
            "\n**Result:** ".. " ┊ Dice: "..resultdice1.. " ┊ Dice: "..resultdice2.. " ┊ Dice: "..resultdice3.. " ┊ Dice: "..resultdice4.. " ┊ Dice: "..resultdice5.. " ┊ ",
            "Trader for RSG Framework",
            "dice")

        if Config.Notify == 'rnotify' then
            TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: ".. resultdice1 .. ' '..resultdice2 .. ' '..resultdice3 .. ' '..resultdice4 .. ' '..resultdice5 , "generic_textures", "tick", 4000)
        elseif Config.Notify == 'ox_lib' then
            TriggerClientEvent('ox_lib:notify', src, {title = "Result: ".. resultdice1.. ' '..resultdice2 .. ' '..resultdice3 .. ' '..resultdice4 .. ' '..resultdice5, type = 'inform', duration = 5000 })
        end
    else
    end
end) ]]

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
    sendToDiscord(16753920, "Minigame | DICE", discordMessage, "Trader for RSG Framework", "dice")

    -- Notificar al jugador según la configuración
    if Config.Notify == 'rnotify' then
        TriggerClientEvent('rNotify:NotifyLeft', src, 'Tirada', "Result: "..results, "generic_textures", "tick", 4000)
    elseif Config.Notify == 'ox_lib' then
        TriggerClientEvent('ox_lib:notify', src, {title = "Result: "..results, type = 'inform', duration = 5000 })
    end
end)
