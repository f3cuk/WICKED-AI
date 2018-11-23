private["_vehicle","_type","_inGear"];
#define GEAR(mag) if !(isNil "_inGear") then {_vehicle addMagazineCargoGlobal [mag,_inGear];};
#define TURRET(mag,num) _vehicle addMagazineTurret [mag,[num]];

_vehicle = _this select 0;
_type = _this select 1;

if (count _this > 2) then {
	_inGear = _this select 2;
};

call {

	if(_type == "Mi17_DZE") exitWith { 
		TURRET("100Rnd_762x54_PK",0)
		TURRET("100Rnd_762x54_PK",1)
		GEAR("100Rnd_762x54_PK")
	};

	if(_type == "UH1Y_DZE") exitWith {
		TURRET("2000Rnd_762x51_M134",0)
		TURRET("2000Rnd_762x51_M134",1)
		GEAR("2000Rnd_762x51_M134")
	};

	if(_type == "UH1H_DZE") exitWith {
		TURRET("100Rnd_762x51_M240",0)
		TURRET("100Rnd_762x51_M240",1)
		GEAR("100Rnd_762x51_M240")
	};

	if(_type == "CH_47F_EP1_DZE") exitWith {
		TURRET("2000Rnd_762x51_M134",0)
		TURRET("2000Rnd_762x51_M134",1)
		TURRET("100Rnd_762x51_M240",2)
		GEAR("2000Rnd_762x51_M134")
	};

	if(_type == "UH60M_EP1_DZE") exitWith {
		TURRET("2000Rnd_762x51_M134",0)
		TURRET("2000Rnd_762x51_M134",1)
		GEAR("2000Rnd_762x51_M134")
	};

	if(_type == "HMMWV_M998A2_SOV_DES_EP1_DZE") exitWith {
		TURRET("48Rnd_40mm_MK19",0)
		TURRET("100Rnd_762x51_M240",1)
		GEAR("48Rnd_40mm_MK19")
	};

	if(_type == "LandRover_Special_CZ_EP1_DZE") exitWith {
		TURRET("29Rnd_30mm_AGS30",0)
		TURRET("100Rnd_762x54_PK",1)
		GEAR("29Rnd_30mm_AGS30")
	};

	if(_type == "GAZ_Vodnik_DZE") exitWith {
		TURRET("100Rnd_762x54_PK",0)
		TURRET("100Rnd_762x54_PK",1)
		GEAR("100Rnd_762x54_PK")
	};

	if(_type == "HMMWV_M1151_M2_CZ_DES_EP1_DZE") exitWith {
		TURRET("100Rnd_127x99_M2",0)
		GEAR("100Rnd_127x99_M2")
	};
	
	if(_type == "LandRover_MG_TK_EP1_DZE") exitWith {
		TURRET("100Rnd_127x99_M2",0)
		GEAR("100Rnd_127x99_M2")
	};
	
	if(_type == "UAZ_MG_TK_EP1_DZE") exitWith {
		TURRET("150Rnd_127x107_DSHKM",0)
		GEAR("150Rnd_127x107_DSHKM")
	};
	
	if(_type == "ArmoredSUV_PMC_DZE") exitWith {
		TURRET("2000Rnd_762x51_M134",0)
		GEAR("2000Rnd_762x51_M134")
	};
	
	if(_type == "Offroad_DSHKM_Gue_DZE") exitWith {
		TURRET("150Rnd_127x107_DSHKM",0)
		GEAR("150Rnd_127x107_DSHKM")
	};
	
	if(_type == "Pickup_PK_TK_GUE_EP1_DZE") exitWith {
		TURRET("100Rnd_762x54_PK",0)
		GEAR("100Rnd_762x54_PK")
	};
	
	if(_type == "Pickup_PK_GUE_DZE") exitWith {
		TURRET("100Rnd_762x54_PK",0)
		GEAR("100Rnd_762x54_PK")
	};
	
	if(_type == "Pickup_PK_INS_DZE") exitWith {
		TURRET("100Rnd_762x54_PK",0)
		GEAR("100Rnd_762x54_PK")
	};

};