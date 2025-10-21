local realismPlayers = {}

RegisterNetEvent('Breathing3.0:Player_Suffocating', function ()
    exports.mana_audio:PlaySoundFromEntity({
        audioBank = 'DLC_BREATHE\\BREATHE',
        audioName = 'jogging_breath_01',
        audioRef = 'breathe_soundset',
        entity = GetPlayerPed(source)
    })
end)

RegisterNetEvent('Breathing3.0:Player_Breathing', function ()
    exports.mana_audio:PlaySoundFromEntity({
        audioBank = 'DLC_BREATHE\\BREATHE',
        audioName = 'exhausted_02',
        audioRef = 'breathe_soundset',
        entity = GetPlayerPed(source)
    })
end)

RegisterCommand('realism', function(source, args, rawCommand)
    if not Config.CommandMode then
        TriggerClientEvent('chat:addMessage', source, {
            args = { "^1[Realism]", "Command mode is disabled. Realism is always enabled for everyone!" }
        })
        return
    end

    local targetId = tonumber(args[1])

    if not targetId then
        TriggerClientEvent('chat:addMessage', source, {
            args = { "^1[Realism]", "Usage: /realism [player id]" }
        })
        return
    end

    local targetPlayer = GetPlayerName(targetId)
    if not targetPlayer then
        TriggerClientEvent('chat:addMessage', source, {
            args = { "^1[Realism]", "Player not found!" }
        })
        return
    end

    if realismPlayers[targetId] then
        realismPlayers[targetId] = nil
        TriggerClientEvent('Breathing3.0:ToggleRealism', targetId, false)
        TriggerClientEvent('chat:addMessage', source, {
            args = { "^2[Realism]", "Realism mode ^1DISABLED^7 for " .. targetPlayer }
        })
        TriggerClientEvent('chat:addMessage', targetId, {
            args = { "^2[Realism]", "You can stop breathing now. The nightmare is over." }
        })
    else
        realismPlayers[targetId] = true
        TriggerClientEvent('Breathing3.0:ToggleRealism', targetId, true)
        TriggerClientEvent('chat:addMessage', source, {
            args = { "^2[Realism]", "Realism mode ^2ENABLED^7 for " .. targetPlayer .. ". They must now press F to breathe!" }
        })
        TriggerClientEvent('chat:addMessage', targetId, {
            args = { "^1[REALISM MODE ACTIVATED]", "You must now press ^3F^7 to breathe or you will suffocate! Welcome to IMMERSION!" }
        })
    end
end, true)

AddEventHandler('playerDropped', function()
    local playerId = source
    if realismPlayers[playerId] then
        realismPlayers[playerId] = nil
    end
end)