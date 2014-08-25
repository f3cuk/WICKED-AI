//****************Bunny Ranch*****************
//*********Created by HollowAddiction*********
//**********http://www.craftdoge.com**********
//Credit to the Creator of WAI http://epochmod.com/forum/index.php?/topic/4427-wicked-aimission-system/
//Credit to MattL for help http://opendayz.net/members/matt-l.7134/

_box = _this select 0;
_box setVariable ["ObjectID","1",true];
_box setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_box];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;


// Loot
_box addMagazineCargoGlobal ["ItemEmerald", 1];
_box addMagazineCargoGlobal ["ItemTopaz", 1];
_box addMagazineCargoGlobal ["ItemBriefcase100oz", 4];
_box addMagazineCargoGlobal ["ItemGoldBar10oz", 2];
_box addMagazineCargoGlobal ["ItemGoldBar", 10];
