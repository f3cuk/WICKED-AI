//Medium Gun Box

_box = _this select 0;
_box setVariable ["ObjectID","1",true];
_box setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_box];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

// RIFLES
_box addWeaponCargoGlobal ["G36C", 1];
_box addWeaponCargoGlobal ["M4A1_AIM", 1];
_box addWeaponCargoGlobal ["AK_47_M", 1];
_box addWeaponCargoGlobal ["RPK_74", 1];
_box addWeaponCargoGlobal ["M4A1_AIM_SD_camo", 1];

// PISTOLS
_box addWeaponCargoGlobal ["M9SD", 1];
_box addWeaponCargoGlobal ["UZI_SD_EP1", 1];

// AMMUNITION
_box addMagazineCargoGlobal ["30Rnd_556x45_G36", 10];
_box addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 10];
_box addMagazineCargoGlobal ["30Rnd_762x39_AK47", 10];
_box addMagazineCargoGlobal ["75Rnd_545x39_RPK", 5];
_box addMagazineCargoGlobal ["30Rnd_556x45_StanagSD", 10];

_box addMagazineCargoGlobal ["15Rnd_9x19_M9SD", 4];
_box addMagazineCargoGlobal ["30Rnd_9x19_UZI_SD", 4];

// CLOTHING
_box addMagazineCargoGlobal ["Skin_Soldier1_DZ", 2];
_box addMagazineCargoGlobal ["Skin_Camo1_DZ", 2];

// BACKPACKS
_box addBackpackCargoGlobal ["DZ_CivilBackpack_EP1", 2];
