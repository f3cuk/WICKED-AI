private["_vehilce","_type"]

_vehicle 	= _this select 0;
_type  		= _this select 1;

diag_log format ["DEBUG: VEHICLE: %1 Adding Ammo", _type];

switch (_type) do
{
	case "Mi17_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[1]];
	};
	case "UH1Y_DZE" : {
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[1]];
	};
	case "UH1H_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[1]];
	};
	case "CH_47F_EP1_DZE" : {
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[1]];
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[2]];
		};
	case "UH60M_EP1_DZE" : {
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[1]];
	};
	case "HMMWV_M998A2_SOV_DES_EP1_DZE" : {
		_vehicle addMagazineTurret ["48Rnd_40mm_MK19",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[1]];
		};
	case "HMMWV_M1151_M2_CZ_DES_EP1_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_127x99_M2",[0]];
		};
	case "LandRover_Special_CZ_EP1_DZE" : {
		_vehicle addMagazineTurret ["29Rnd_30mm_AGS30",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[1]];
		};
	case "LandRover_MG_TK_EP1_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_127x99_M2",[0]];
		};
	case "UAZ_MG_TK_EP1_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x51_M240",[0]];
		};
	case "GAZ_Vodnik_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[1]];
		};
	case "ArmoredSUV_PMC_DZE": {
		_vehicle addMagazineTurret ["2000Rnd_762x51_M134",[0]];
		};
	case "Pickup_PK_TK_GUE_EP1_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		};
	case "Pickup_PK_GUE_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		};
	case "Pickup_PK_INS_DZE" : {
		_vehicle addMagazineTurret ["100Rnd_762x54_PK",[0]];
		};
};