# Current version 2.0.0

Type | Description
------------: | -------------
`enhancement` | Major code overhaul and folder structure change
`feature` | Added possibility of rotating static mission per map
`feature` | Added possibility of tanktrapping missions @f3cuk / @nerdalertdk
`feature` | Added nightvision to AI at night @nerdalertdk
`enhancement` | Randomized the type of static weapon to spawn @nerdalertdk
`enhancement` | Added option to clean gear on roadkilled ai @nerdalertdk
`enhancement` | Added option to spawn smoke/flare (daytime/nighttime) on mission complete @nerdalertdk
`enhancement` | Added option in % chance to destruct weapons on roadkill @nerdalertdk
`enhancement` | Started with merge of weird double folder structure
`enhancement` | Added option to not save vehicles to database
`enhancement` | Make ai hostile to zombies
`bug` | Fixed some incorrect varnames @osuapoc / @nerdalertdk
 | 
Version | **1.9.3**
 | 
`enhancement` | Normalized the use of Random throughout, when you want something random, use "Random" and not "Random" or ""
`enhancement` | Implemented custom_ai_skill throughout. In the future use either "easy", "medium", "hard", "extreme" or "Random" to define a skillset. Numeric skillsets will fallback on "Random".
`enhancement` | Added IsServer checks on all files that could possibly be used in a harmfull manner (will probably roll this out on more files)
`enhancement` | Changed the custom_spawns.sqf file with some new descriptions
`enhancement` | the missions to make proper use of "Random"
`enhancement` | Changed weapon array names to logical ones
`enhancement` | Changed heli and vehicle patrol with possibility of random skill
`bug` | Fixed mayors mansion typo
`bug` | Fixed added _aicskill private var vehicle_patrol.sqf
 | 
Version | **1.9.2**
 | 
`bug` | Fixed box on medi camp missions
 | 
Version | **1.9.1**
 | 
`bug` | Fixed skillset on missions
 | 
Version | **1.9.0**
 | 
`new feature` | Added possibility to blacklist certain area's (default set stary)
`enhancement` | General code cleanup including removal of unused private vars
`enhancement` | Overhaul making missions more dynamic
`enhancement` | Equipped more missions with dynamic loot
`enhancement` | Updated the dynamic loot arrays with more items
`enhancement` | Added difficulty levels to mission titles
`enhancement` | Re-added custom spawns as per request
`bug` | Fixed armed military mission with M2 spawning inside eachoter
`bug` | Fixed crashed blackhawk with loot crate spawning inside helicopter
 | 
Version | **1.8.0**
 | 
`new feature` | Randomized clothes;
`enhancement` | Customized loot;
`enhancement` | Tried to nerve the 50 cals a bit, making them less accurate;
`enhancement` | Changed weapons;
`enhancement` | Improved vehicles;
`enhancement` | Changed skill settings;
`enhancement` | Added dynamic loot on Weapon cache missions;
`bug` | Fixed some missions;
`bug` | Fixed the heli para backpack issue;
`bug` | Fixed the heli para spawning in after the mission has already been done.
`removal` | Removed the C130 mission cause i cant seem to fix the glitching;
`removal` | Removed EMS cache cause its practically the same as Weapon cache;
