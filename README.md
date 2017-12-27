WICKED AI 2.2.2
==============

Since I really like (read love) the Wicked AI missions and support for them has gone in the latest patches, I decided to dust off the old files and start making these 1.0.6+ compatible. Starting with a few minor bugfixes and some custom loadouts, but quickly turning into a proper redo with awesome help of the - very much alive - mod community!

### Updates for DayZ Epoch 1.0.6.2 (worldwidesorrow)
- Streatman's new attachment system L85 and SVD models.
- Optional dynamic text mission announcements.
- ZSC compatible remote message system using a modified version of Salival's remote_message.sqf
- iBen's mission auto claim addon.
- Two new options for mission vehicle keys: key in crate & key in vehicle gear.
- Minor bug fixes with missions.

### Release 2.2.2 (worldwidesorrow)
- Integrated Caveman's mission pack.
- Optional AI counter in mission marker loops.
- ZSC check wallet option.
- Optional mission static spawn points.
- Updated with 1.0.6+ classnames in weapon arrays and vehicles.
- Pistol spawning in crates.

### Version history
- 04-12-2017 : Release 2.2.2
- 11-07-2017 : Release 2.2.1
- 06-06-2015 : Release 2.2.0
- 11-11-2014 : BETA release v3 (2.2.0)
- 11-11-2014 : BETA release v2 (2.2.0)
- 16-10-2014 : BETA release (2.2.0)
- 03-09-2014 : Minor bugfixes (2.1.4)
- 03-09-2014 : Minor bugfixes (2.1.3)
- 02-09-2014 : Minor bugfixes and improvements (2.1.2)
- 01-09-2014 : Minor bugfixes (2.1.1)
- 31-08-2014 : Release (2.1.0)
- 26-08-2014 : BETA release (2.1.0)
- 24-08-2014 : Minor bugfixes (2.0.5)
- 20-08-2014 : Minor bugfixes (2.0.4)
- 20-08-2014 : Minor bugfixes (2.0.3)
- 19-08-2014 : Minor bugfixes (2.0.2)
- 17-08-2014 : Minor bugfixes (2.0.1)
- 17-08-2014 : Major update to (2.0.0)
- 13-08-2014 : Added anti abuse options (1.9.3)
- 12-08-2014 : Normalization update (1.9.2)
- 12-08-2014 : Bugfix medi camp (1.9.1)
- 09-08-2014 : Major dynamic update (1.9.0)
- 03-08-2014 : Bugfix MV22 mission (1.8.2)
- 02-08-2014 : Restructured and code cleaned (1.8.1)

### Installation Instructions

1. Click ***[Clone or Download](https://github.com/f3cuk/WICKED-AI/archive/master.zip)*** the green button on the right side of the Github page.

	> Recommended PBO tool for all "pack", "repack", or "unpack" steps: ***[PBO Manager](http://www.armaholic.com/page.php?id=16369)***

2. Extract the downloaded folder to your desktop and open it
3. Go to your server pbo and unpack it.
4. Navigate to the new ***dayz_server*** folder and copy the WAI folder into this folder.
5. Navigate to the ***system*** folder and open server_monitor.sqf

	Find this code at the bottom of the file:

	```sqf
	allowConnection = true;	
	```
	
	And add the following line ***above*** it:
	
	```sqf
	[] ExecVM "\z\addons\dayz_server\WAI\init.sqf";
	```

6. Repack your server pbo.

### Mission Folder

Note: This version of WAI uses files which are adapted from ZSC for radio and dynamic text mission announcements. If you already have ZSC installed then some of the lines of code and files will already exist. Read the instructions carefully.

 To enable radio or dynamic text mission announcements, change *wai_mission_announce* in WAI\config.sqf to *"Radio"* or *"DynamicText"*.

1. Go to your mission pbo and unpack it.
2. Open init.sqf

	Find:

	```sqf
	waitUntil {scriptDone progress_monitor};	
	```
	
	And add the following line ***above*** it: 
	
	```sqf
	[] execVM "dayz_code\compile\remote_message.sqf";
	```
	If you already have ZSC installed then just verify that this line is already there.
	
3. Open description.ext

	Find:
	
	```sqf
	#include "\z\addons\dayz_code\gui\description.hpp"
	```
	
	And add the following code block ***above*** it:
	
	```sqf
	class CfgSounds
	{
		sounds[] =
		{
			Radio_Message_Sound
			,IWAC_Message_Sound
		};
		class Radio_Message_Sound
		{
			name="Radio_Message_Sound";
			sound[] = {scripts\radio\radio.ogg,0.4,1};
			titles[] = {};
		};
		class IWAC_Message_Sound
		{
			name="IWAC_Message_Sound";
			sound[] = {scripts\radio\IWACsound.ogg,0.4,1};
			titles[] = {};
		};
	};
	```
	
	If you already have ZSC installed, then overwrite the following code with the code above.
	
	```sqf
	class CfgSounds
	{
		sounds[] =
		{
			Radio_Message_Sound
		};
		class Radio_Message_Sound
		{
			name = "Radio_Message_Sound";
			sound[] = {scripts\radio\radio.ogg,0.4,1};
			titles[] = {};
		};
	};
	```
Note: In order for players to receive radio announcements, they must have ItemRadio in a toolbelt inventory slot, so you might want to adjust your default loadout in init.sqf if you have this feature enabled.

4. Open mission.sqm

	Find:
	
	```sqf
	"chernarus",
	```
	
	And add the following line ***below*** it:
	
	```sqf
	"aif_arma1buildings",
	```
	
5. Copy the ***dayz_code*** folder into your mission folder. If you already have this folder, then overwrite remote_message.sqf and verify that IWACsound.ogg and switch_on_off.sqf are in the ***scripts\radio*** directory.

6. Copy the ***scripts*** folder over to your mission folder. If you already have this folder from ZSC install or another mod, then transfer the appropriate files over to the radio folder.

7. Copy ***stringtable.xml*** to your mission folder.

#### Option to turn the radio on and off with extra_rc or deploy anything to disable radio mission announcements.
	
1. Extra_Rc - I could not find a public repository of an updated version of extra_rc by maca134, so I made one: ***[Download Here](https://github.com/worldwidesorrow/Extra-Rc/archive/master.zip)*** Here are the install instructions ***[Install Instructions](https://github.com/worldwidesorrow/Extra-Rc/blob/master/README.md)***

	By default, in DayZ Epoch, right click actions are disabled for ItemRadio when the group system is disabled. If you want to use right click actions on ItemRadio without enabling the group system...
	Find:
	
2. Open dayz_code\compile\ui_selectSlot.sqf

	Find:
	
	```sqf
	or (!dayz_groupSystem && _item == "ItemRadio")
	```
	Comment this line out so it looks like this
	
	```sqf
	//or (!dayz_groupSystem && _item == "ItemRadio")
	```
	
	Find:
	
	```sqf
	//if (_item == "ItemRadio") exitWith {_numActions = 0;};
	```
	
	Uncomment this line so it looks like this
	
	```sqf
	if (_item == "ItemRadio") exitWith {_numActions = 0;};
	```

3. If you have Deploy Anything (also called DayZEpochDeployableBike) installed, then open overwrites\click_actions\config.sqf

	Add the following line to the bottom of your DZE_CLICK_ACTIONS array.
	
	```sqf
	["ItemRadio","Toggle Power","execVM 'scripts\radio\switch_on_off.sqf';","true"]
	```
	
	If you want to enable right click actions without having the group system enabled then find overwrites\click_actions\ui_selectSlot.sqf and apply the same changes as in the extra_rc option. Note: you will have to move the word 'or' front line 17 to line 18 in from of (!dayz_groupSystem && _item == "ItemRadio").

#### Repack your mission pbo.

#### Additional Config Options

1. Mission Vehicle Keys

	You can now choose among 4 options for mission vehicle keys. The options can be adjusted by changing the value on the following variable in WAI\config.sqf
	
	```sqf
	wai_mission_vehicles = "KeyinVehicle"; // Options: "KeyonAI", "KeyinVehicle", "KeyinCrate", "NoVehicleKey".
	```
	
	Just change the value after the equal sign.
	
2. You can now enable dynamic text messages that run near the top of the screen by adjusting the value of the following variable in config.sqf ***[Screenshot](https://github.com/worldwidesorrow/RandomDayZ/blob/master/dynamictext.jpg)*** of dynamic text message.

	```sqf
	wai_mission_announce = "DynamicText"; // Options: "Radio", "DynamicText", "titleText".
	```
	
3. iBen's Auto Mission Claim system can be activated by adjusting the following variable in WAI\customsettings.sqf

	```sqf
	iben_wai_ACuseAddon = true;
	```
	
	Visit ***[This Thread](https://epochmod.com/forum/topic/44646-release-iwac-autoclaim-addon-for-wai-v11/)*** for complete information on how to use the Auto Mission Claim addon.



### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, bootstrap is maintained under [the Semantic Versioning guidelines](http://semver.org/). Sometimes we screw up, but we'll adhere to those rules whenever possible.

### Dev team
- None active
