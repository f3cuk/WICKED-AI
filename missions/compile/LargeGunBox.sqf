//Large Gun Box

_box = _this select 0;
_box setVariable ["ObjectID","1",true];
_box setVariable ["permaLoot",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_box];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

// RIFLES
_box addWeaponCargoGlobal ["G36A_camo", 1];
_box addWeaponCargoGlobal ["DMR", 1];
_box addWeaponCargoGlobal ["M14_EP1", 1];
_box addWeaponCargoGlobal ["M249_EP1_DZ", 1];
_box addWeaponCargoGlobal ["M24", 1];
_box addWeaponCargoGlobal ["M40A3", 1];
_box addWeaponCargoGlobal ["M4SPR", 1];

// PISTOLS
_box addWeaponCargoGlobal ["M9SD", 1];
_box addWeaponCargoGlobal ["UZI_SD_EP1", 1];

// AMMUNITION
_box addMagazineCargoGlobal ["30Rnd_556x45_G36", 10];
_box addMagazineCargoGlobal ["20Rnd_762x51_DMR", 10];
_box addMagazineCargoGlobal ["200Rnd_556x45_M249", 10];
_box addMagazineCargoGlobal ["5Rnd_762x51_M24", 4];
_box addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 10];

_box addMagazineCargoGlobal ["15Rnd_9x19_M9SD", 4];
_box addMagazineCargoGlobal ["30Rnd_9x19_UZI_SD", 4];

// CLOTHING
_box addMagazineCargoGlobal ["Skin_Soldier1_DZ", 2];
_box addMagazineCargoGlobal ["Skin_GUE_Commander_DZ", 2];

// BACKPACKS
_box addBackpackCargoGlobal ["DZ_Backpack_EP1", 2];