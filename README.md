WAI-ZOMBIELAND
==============

Our personalized WAI missions with some bugfixes and customized loot

Changelog
- 02-08-2014 : Restructured and code cleaned

## Installation Instructions

Add the WAI folder to your dayz_server directory

### dayz_server PBO Instructions

Go to server_monitor.sqf located in the system folder in your server.pbo

* search for allowConnection = true; and add the line shown below 

    ExecVM "\z\addons\dayz_server\WAI\init.sqf";
    
    allowConnection = true;
