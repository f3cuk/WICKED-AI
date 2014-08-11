WAI-ZOMBIELAND 1.9.1
==============

As i really liked the WAI missions and support for them in the latest epoch patches has gone, i decided to dust off the old files and start making these properly 1.0.5+ compatible. It started with a few minor bugfixes and some custom loadout and decided to share for anyone interested. Now planning on taking this to the next level for everyone to enjoy. 

Todo
- Add more missions
- Fix C130 mission
- Add posibility of multiple missions running at the same time (A redo of markers.sqf, missions.sqf and mission timer should suffice)
- Find a creative way to deal with the vodnik 'abusers' without making making the diffuclty higher for normal player.

Changelog
- 09-08-2014 : Major dynamic update (1.9.0)
- 03-08-2014 : Bugfix MV22 mission (1.8.2)
- 02-08-2014 : Restructured and code cleaned (1.8.1)

Changelog 1.9.1
- Fixed skillset on missions

Changelog 1.9.x
- Added possibility to blacklist certain area's (default set stary);
- Overhaul making missions more dynamic;
- Equipped more missions with dynamic loot;
- Updated the dynamic loot arrays with more items;
- Fixed armed military mission with M2 spawning inside eachoter;
- Fixed crashed blackhawk with loot crate spawning inside helicopter;
- Added difficulty levels to mission titles;
- Re-added custom spawns as per request;
- General code cleanup including removal of unused private vars.

Changelog 1.8.x
- Customized loot;
- Tried to nerve the 50 cals a bit, making them less accurate;
- Improved weapons (removed all the non-sellable);
- Improved vehicles;
- Changed skill settings;
- Randomized clothes;
- Fixed some missions;
- Removed the C130 mission cause i cant seem to fix the glitching;
- Removed EMS cache cause its the same as Weapon cache;
- Dynamic loot on Weapon cache missions;
- Fixed the heli para backpack issue;
- Fixed the heli para spawning in after the mission has already been done.

## Installation Instructions

1.) Add the WAI folder to your dayz_server directory

2.) Add "ExecVM "\z\addons\dayz_server\WAI\init.sqf";" to the bottom of server_functions.sqf
