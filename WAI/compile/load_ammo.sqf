private["_vehicle","_type"];

_vehicle	= _this select 0;
_type		= _this select 1;

call {

	if(_type == "Mi17_DZE") exitWith { 
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[1]];
	};

	if(_type == "UH1Y_DZE") exitWith {
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[1]]; 
	};

	if(_type == "UH1H_DZE") exitWith { 
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[1]]; 
	};

	if(_type == "CH_47F_EP1_DZE") exitWith { 
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[1]];
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[2]]; 
	};

	if(_type == "UH60M_EP1_DZE") exitWith { 
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[1]];
	};

	if(_type == "HMMWV_M998A2_SOV_DES_EP1_DZE") exitWith {
		_vehicle addMagazineTurret ["48Rnd_40mm_MK19",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[1]]; 
	};

	if(_type == "LandRover_Special_CZ_EP1_DZE") exitWith { 
		_vehicle addMagazineTurret ["29Rnd_30mm_AGS30",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[1]]; 
	};

	if(_type == "GAZ_Vodnik_DZE") exitWith { 
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[1]]; 
	};

	if(_type == "HMMWV_M1151_M2_CZ_DES_EP1_DZE") 	exitWith { _vehicle addMagazineTurret ["100Rnd_127x99_M2",[0]]; };
	if(_type == "LandRover_MG_TK_EP1_DZE") 			exitWith { _vehicle addMagazineTurret ["100Rnd_127x99_M2",[0]]; };
	if(_type == "UAZ_MG_TK_EP1_DZE")				exitWith { _vehicle addMagazineTurret ["100Rnd_762x51_M240",[0]]; };
	if(_type == "ArmoredSUV_PMC_DZE") 				exitWith { _vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]]; };
	if(_type == "Pickup_PK_TK_GUE_EP1_DZE") 		exitWith { _vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]]; };
	if(_type == "Pickup_PK_GUE_DZE") 				exitWith { _vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]]; };
	if(_type == "Pickup_PK_INS_DZE") 				exitWith { _vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]]; };

};