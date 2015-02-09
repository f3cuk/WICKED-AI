private["_vehicle","_type"];

_vehicle	= _this select 0;
_type		= _this select 1;

call {

	if(_type == "O_Heli_Light_02_F") exitWith { 
		_vehicle addMagazineTurret ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[0]];
		_vehicle addMagazineTurret ["2000Rnd_65x39_Belt_Tracer_Green_Splash",[1]];
	};
	
	if(_type == "O_Heli_Light_03_F") exitWith { 
		_vehicle addMagazineTurret ["5000Rnd_762x51_Yellow_Belt",[0]];
	};

	if(_type == "O_Heli_Attack_02_black_F") exitWith {
		_vehicle addMagazineTurret ["250Rnd_30mm_HE_shells",[0]];
		_vehicle addMagazineTurret ["250Rnd_30mm_HE_shells",[1]];
	};

	if(_type == "O_MRAP_02_hmg_F") exitWith {
		_vehicle addMagazineTurret ["200Rnd_127x99_mag_Tracer_Green",[0]];
		_vehicle addMagazineTurret ["200Rnd_127x99_mag_Tracer_Green",[1]]; 
	};

	if(_type == "O_G_Offroad_01_armed_F") exitWith { 
		_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Yellow",[0]];
		_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Yellow",[1]];
		_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Yellow",[2]];
		_vehicle addMagazineTurret ["100Rnd_127x99_mag_Tracer_Yellow",[3]];
	};

	
};