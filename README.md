WickedAI_A3_Epoch
=================

WAI for A3 Epoch is currently under development.  Many features and functions in this development build
may not work properly, if at all.  If you make any additions or changes please be sure to give credit
to the original authors and include your own name as well.  


WICKED AI 1.0.0
AI Missions for ARMA 3 Epoch. If you liked the ones on A2 Epoch, you are definately gonna love these!

Release 1.0.0

List of features (?)
Upcoming in 1.1.0

Version history

16-12-2014 - Initiated first build based on Wicked AI 2.2.0 for Arma 2
Installation Instructions

Click Download Zip on the right sidebar of this Github page.

Recommended PBO tool for all "pack", "repack", or "unpack" steps: PBO Manager
Extract the downloaded folder to your desktop and open it

Go to your server pbo and unpack it.
Navigate to the new dayz_server folder and copy the WAI folder into this folder.
Navigate to the system folder and open server_monitor.sqf

Find this code at the bottom of the file:

allowConnection = true; 
And past the following code above it:

[] ExecVM "\z\addons\dayz_server\WAI\init.sqf";
Repack your server pbo.

Optional Radio messages

Note: These are on by default, change wai_radio_announce in config.sqf to false in order to disable them.

Go to your mission pbo and unpack it.
Open init.sqf

Find:

//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";    
Add below:

_nil = [] execVM "custom\remote_message\remote_message.sqf";
Copy the remote_message folder into your custom folder, if you do not have this one yet simply create it.

Repack your mission pbo.
Versioning

For transparency into our release cycle and in striving to maintain backward compatibility, bootstrap is maintained under the Semantic Versioning guidelines. Sometimes we screw up, but we'll adhere to those rules whenever possible.

Dev team

Developer f3cuk
Developer Darth_Rogue
Helping hand nerdalertdk
