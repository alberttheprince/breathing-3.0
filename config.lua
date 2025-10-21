Config = {}

Config.CommandMode = true -- If false, realism is always on for everyone. If true, use /realism [id] command to enable per player
Config.StaminaStandingWalking = 0.25 -- How much stamina a player regains back when standing still or walking (out of 1)
Config.StaminaRunning = 0.15 -- How much stamina a player regains while running (out of 1)
Config.BreathLoss = 10 -- How much stamina a player loses each Tick (out of 100)
Config.BreathLossTick = 1000 -- 1000 ms = 1 second, how often player loses stamina
Config.Suffocation = 10 -- Below what oxygen level does someone's character starts to suffocate and take damage (out of 100)
Config.SuffocationDamage = 10 -- how much damage a player takes each tick
Config.OxygenDelivery = 100 -- in MS (100 ms = .1 second), how long it takes for stamina to be restored
Config.Exhale = 10 -- How much stamina you lose every tick (out of 100)