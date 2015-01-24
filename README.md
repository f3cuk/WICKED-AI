WICKED AI 2.2.0
==============

Since I really like (read love) the Wicked AI missions and support for them has gone in the latest patches, I decided to dust off the old files and start making these 1.0.5+ compatible. Starting with a few minor bugfixes and some custom loadouts, but quickly turning into a proper redo with awesome help of the - very much alive - mod community!

### Release 2.2.0
- Multiple mission support
- Automatic ammo finder (no need to specify ammo in weaponarray - config.sqf)
- Option: Locked vehicles with keys randomly on AI
- Option: Friendly AI
- Added: Bandit Patrol mission
- [And much more](https://github.com/f3cuk/WICKED-AI/blob/master/changelist.md)

### Upcoming in 2.3.0+
- More missions
- Further enhancements

### Version history
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

1. Click ***[Download Zip](https://github.com/f3cuk/WICKED-AI/archive/master.zip)*** on the right sidebar of this Github page.

	> Recommended PBO tool for all "pack", "repack", or "unpack" steps: ***[PBO Manager](http://www.armaholic.com/page.php?id=16369)***

2. Extract the downloaded folder to your desktop and open it
3. Go to your server pbo and unpack it.
4. Navigate to the new ***dayz_server*** folder and copy the WAI folder into this folder.
5. Navigate to the ***system*** folder and open server_monitor.sqf

	Find this code at the bottom of the file:

	~~~~java
	allowConnection = true;	
	~~~~
	
	And past the following code ***above*** it:
	
	~~~~java
	[] ExecVM "\z\addons\dayz_server\WAI\init.sqf";
	~~~~

6. Repack your server pbo.

##### Optional Radio messages
Note: These are on by default, change *wai_radio_announce* in config.sqf to *false* in order to disable them.

1. Go to your mission pbo and unpack it.
2. Open init.sqf

	Find:

	~~~~java
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";	
	~~~~
	
	Add below:
	
	~~~~java
	_nil = [] execVM "custom\remote\remote.sqf";
	~~~~

3. Copy the remote_message folder into your custom folder, if you do not have this one yet simply create it.
4. If you want to be able to switch the radio on or off go to step 5 (note: right click by maca required), else go to step 7 and both remove switch_on_off.sqf and radio.ogg from the remote folder.
5. Open extra_hc.hpp

	Find:
	~~~~java
	class ExtraRc {
	~~~~

	Add below:
	~~~~java
		class ItemRadio {
			class switchOnOff {
				text = "Switch ON/OFF";
				script = "execVM 'custom\remote\switch_on_off.sqf'";
			};
		};
	~~~~

6. Open description.ext

	Find:
	~~~~
	class DayZ_loadingScreen
	~~~~

	Add above
	~~~~java
	class CfgSounds
	{
		sounds[] =
		{
			Radio_Message_Sound
		};
		class Radio_Message_Sound
		{
			name = "Radio_Message_Sound";
			sound[] = {custom\remote\radio.ogg,0.4,1};
			titles[] = {};
		};
	};
	~~~~
7. Repack your mission pbo.



### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, bootstrap is maintained under [the Semantic Versioning guidelines](http://semver.org/). Sometimes we screw up, but we'll adhere to those rules whenever possible.

### Dev team
- Developer **f3cuk**
- Developer **Jossy**
- Helping hand **nerdalertdk**
