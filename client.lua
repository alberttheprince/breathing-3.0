local realismEnabled = not Config.CommandMode

RegisterNetEvent('Breathing3.0:ToggleRealism', function(enabled)
    if not Config.CommandMode then return end

    realismEnabled = enabled

    if enabled then
        SetPlayerStamina(PlayerId(), 100)
    else
        SetPlayerStamina(PlayerId(), 100)
    end
end)

CreateThread(function()
    while true do
        if realismEnabled then
            local breath = (GetPlayerStamina(PlayerId()))
            SetPlayerStamina(PlayerId(), (breath - Config.Exhale))

            if breath <= Config.Suffocation then
                ApplyDamageToPed(PlayerPedId(), Config.SuffocationDamage, false)
                TriggerServerEvent('Breathing3.0:Player_Suffocating')
            end
        end

        Wait(Config.BreathLossTick)
    end
end)

local isBreathing = false
RegisterCommand('Breathe', function()
    if not realismEnabled then return end
    if isBreathing then return end
    isBreathing = true

    if IsPedStill(PlayerPedId()) or IsPedWalking(PlayerPedId()) then
        Wait(Config.OxygenDelivery)
        RestorePlayerStamina(PlayerId(), Config.StaminaStandingWalking)
        --local PlayerCoords = GetEntityCoords(PlayerPedId())
        --PlayAmbientSpeechFromPositionNative("JOGGING_BREATH", "WAVELOAD_PAIN_FRANKLIN", PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, "SPEECH_PARAMS_FORCE_NORMAL")
        TriggerServerEvent('Breathing3.0:Player_Breathing')
    elseif (IsPedSprinting(PlayerPedId()) or IsPedRunning(PlayerPedId())) then
        Wait(Config.OxygenDelivery)
        RestorePlayerStamina(PlayerId(), Config.StaminaRunning)
        -- local PlayerCoords = GetEntityCoords(PlayerPedId())
        --PlayAmbientSpeechFromPositionNative("JOGGING_BREATH", "WAVELOAD_PAIN_FRANKLIN", PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, "SPEECH_PARAMS_FORCE_NORMAL")
        TriggerServerEvent('Breathing3.0:Player_Breathing')
    end
    isBreathing = false
end, false)

RegisterKeyMapping('Breathe', 'Breathe', 'keyboard', 'F')

TriggerEvent('chat:removeSuggestion', '/Breathe')