![image](https://github.com/alberttheprince/breathing-2.0/assets/85725579/8a853f73-7950-4566-a5bb-5254e32b597e)


# breathing ~~2.0~~ 3.0

Tired of unrealistic roleplay servers? Tired of hearing players complaining about how unrealistic your server is? **You've come to the right Repo!**

Breathing ~~2.0~~ 3.0 **fundamentally changes** the way you roleplay, giving you and your players **total control** over their player's stamina consumption, taking back what was unjustly taken from you when Rockstar implemented auto-regenerating stamina.

By introducing realistic breathing functionality to your hardcore ultra-realistic no-pixel-inspired server, you will effectively solve any complaints about realism. Your community will gasp and then breathe sighs of relief as a new dawn of total immersion washes over them.

A new era of Roleplay has been unlocked, as we march forward into a post-casual roleplay reality. 

Despite hundreds of hours of man hours, dozens of consumer surveys, and industry experts advising not to, we have released this resource for everyone to use for free!

# Features
- Press F to breath
- Hear your character breathe
- Hear your character suffer as they suffocate to death
- Hear other players breathe and suffocate
- Finally, make your server a R E A L I S T I C roleplay server!
- Use a command to apply realism to specific players

# Dependencies

- Ability to press or engage keyboard inputs (Audio based breathing recognition a WIP)
- [mana_audio](https://github.com/Manason/mana_audio) (for syncing audio between players, if you don't care you can uncomment the code that does it for your local client only)




https://github.com/alberttheprince/breathing-2.0/assets/85725579/72f35a7f-5580-49df-9a8b-08cad40abf28



# Reflections of a Scholar

Thank you to [Demi-Automatic](https://github.com/Demigod916), [Manason](https://github.com/Manason), [sqrl](https://github.com/Sqrl34/s), and junction (on the CFX scripting discord), and [Disquse](https://github.com/disquse) for their help with bug fixes, formatting, and coding. Without you, this resource wouldn't have been able to bless the roleplay community with total realism.

Thanks to [DurtyFree](https://forge.plebmasters.de/) and others in the Plebmasters discord for discussions and info on ambient audio and sound files.

---

**Notes for FiveM Development:**

This resource makes use of PlayAmbientSpeechFromPositionNative to play audio files typically used by Rockstar to play audio from peds including speech, ambient speech (duh), pain sounds, and thousands of other instances of audio that you would have audio in relation to characters or peds. 

However, as far as I've found through research and discussion with other users, you **cannot** use PlayPedAmbientSpeechNative or PlayPedAmbientSpeechWithVoiceNative to make the ped controlled by a player to speak. Additionally, setting the MP_ models PVG does not work (via natives or through streaming of meta files) and when setting it and attempting to use it in this way it will not produce any audio. You also cannot use these with PlaySoundFrontend or PlaySound, as those seem to handle other audio files, usually cut environmental, or cutscene audio.

The obvious weakness of PlayAmbientSpeechFromPositionNative is that despite having a wide library of audio you can use, you must play it on a coordinate, meaning if a user is moving quickly (say in one of your shitty de-badged vehicles at 300 mph) you may not hear the file being played. Additionally, as PlayAmbientSpeechFromPositionNative is client side only, use of Manason's [tool name link here] must be used to have the audio also play for other clients nearby.

Most audio files that can be used with this native can be found in the GTA files under SFX, and you can find a list by exploring DurtyFree's various collections/lists of audio files. 

12/20/2023 - Update

Following a lot of testing with [Manason](https://github.com/Manason), we encountered quite a few issues with using PlayAmbientSpeechFromPositionNative. It turns out to be client side only, this is solved by creating a tool to take advantage of PlayAmbientSpeechFromPositionNative and sync it between players, but Manason felt that it would be better to convert (or use custom audio) audio to audio libraries you can call via that uses PlaySoundFromEntity and other natives to play native audio. This tool is [mana_audio](https://github.com/Manason/mana_audio).

We encountered a couple of issues, one of which was the audio refusing to play despite proper setup. This turned out to be an issue with how [LVCv3](https://forum.cfx.re/t/luxart-vehicle-control-v3/4436673) (or at least our setup) was loading audio banks. Depending on your artifact version, you can only ever have 7 - 10 audio banks loaded. With custom sirens, this set us at 6 audio banks due to us using Server Sided Siren Integration, it ended up conflicting (as well as other resources not unloading audio banks) which allowed us to use mana_audio to play sounds directly on the entity and sync it with other players.

As far as we can tell, this will still run into the 10 audio bank limit that exists. Whether this exists for PlayAmbientSpeechFromPositionNative, we're not sure, but the ability for this audio to be played directly from the ped is important for uses like this resource, or others that might want to play sounds from entities.

20/02/2024 - Update

Following a fix of the [GetPlayerStamina Native](https://github.com/citizenfx/fivem/issues/2341) work on this has continued, although I've gone ahead and remade the add-on audio of this resource. I'm not sure why, but the original logic of how I was setting stamina was not acting like it was before the fix. If that was an error on my part or something else, the math.floor was removed, and the resource is working.

22/02/2024 - Final Update

Initially working on this resource, I didn't have much knowledge of GTA 5 Audio, and I had to reach out to a couple people/sources of information, looking at the audio research of [Monkeypolice188](https://github.com/Monkeypolice188/Monkys-Audio-Research/tree/main), digging through discussions about creating native audio on LSPDFR and other forums, and using BJDubb's [SirenSharp tool](https://github.com/BJDubb/SirenSharp) to package the AWC and make the associated files. Due to the original intended use of SirenSharp being for well, vehicle Sirens, this required some editing of the files XML information in Codewalker.

Namely, the most important thing was to edit the distance the audio was played at, and if it was looping or not. Within the AWC is a line ```<LoopPoint value="0"/>```, which should be ```<LoopPoint value="-1"/>``` for non-looping audio. In this case, someone breathing wouldn't be looped, but in the case of a siren, you would want it to be looped. Additionally, more info can be found by opening up the AWC and dat files in codewalker to see what I changed vs what is produced by sirensharp.

I've created a handy example for streaming add-on sounds [here](https://github.com/alberttheprince/AddonCarSounds) but this can be loaded per resource. I can't find the original discussion, but as I understand there is roughly a limit of 190 additional sounds (or at least within that range) that's been run into by people who create libraries of add-on audio files, mainly when adding custom car audio.

You'll see quite a bit of discussion of Native Audio in the FiveM community and other similar tools, and while it may seem new, much of this has already been researched and looked into deeply by people on LSPDFR and a lot of the emergency services RP communities and vehicle modders as they have a big incentive/reason to get custom audio working. Unfortunately, as with many things in the GTA 5 community, this info is spread out online, gatekept, or held as "tribal knowledge" but some googling will give you results. 
