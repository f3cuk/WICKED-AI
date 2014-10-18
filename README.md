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

1. Extract the downloaded folder to your desktop and open it
1. Go to your server pbo and unpack it.
1. Navigate to the new ***dayz_server*** folder and copy the WAI folder into this folder.
1. Navigate to the ***system*** folder and open server_monitor.sqf

	Find this code at the bottom of the file:

	~~~~java
	allowConnection = true;	
	~~~~
	
	And past the following code ***above*** it:
	
	~~~~java
	[] ExecVM "\z\addons\dayz_server\WAI\init.sqf";
	~~~~

1. Repack your server pbo.

### Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, bootstrap is maintained under [the Semantic Versioning guidelines](http://semver.org/). Sometimes we screw up, but we'll adhere to those rules whenever possible.

### Dev team
- Developer **f3cuk**
- Developer **Jossy**
- Helping hand **nerdalertdk**
