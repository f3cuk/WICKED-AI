WICKED AI 1.0.0
==============

AI Missions for ARMA 3 Epoch. If you liked the ones on A2 Epoch, you are definately gonna love these!

### Release 1.0.0
- List of features (?)

### Upcoming in 1.1.0
- 

### Version history
- 16-12-2014 - Initiated first build based on Wicked AI 2.2.0 for Arma 2

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
	_nil = [] execVM "custom\remote_message\remote_message.sqf";
	~~~~

3. Copy the remote_message folder into your custom folder, if you do not have this one yet simply create it.
4. Repack your mission pbo.

### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, bootstrap is maintained under [the Semantic Versioning guidelines](http://semver.org/). Sometimes we screw up, but we'll adhere to those rules whenever possible.

### Dev team
- Developer **f3cuk**
- Developer **Darth_Rogue**
- Helping hand **nerdalertdk**
