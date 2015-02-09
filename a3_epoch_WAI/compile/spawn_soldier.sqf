if (isServer) then {
    private [
	"_unitType","_aisoldier","_hat","_rocket","_count","_launcher",
	"_pos_x","_pos_y","_pos_z","_aiskin","_aivest","_unarmed","_current_time","_gain",
	"_mission","_ainum","_aitype","_mission","_aipack","_aicskill","_position",
	"_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_vest",
	"_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine",
	"_gearmagazines","_geartools","_unit","_muzzle"];

	// from group
	_unitGroup 			= _this select 0;

	_position 			= _this select 1;
		_pos_x 				= _position select 0;
		_pos_y 				= _position select 1;
		_pos_z 				= _position select 2;
		
	_aisoldier 			= _this select 2;
	_skill 				= _this select 3;
	_aitype				= _this select 4;
	_mission 			= _this select 5;
	
	// custom krypto amount
	if (typeName _aitype == "ARRAY") then {
		_gain 			= _aitype select 1;
		_aitype 		= _aitype select 0;
	};
	
	_aigear 			= [];
	_aiskin 			= "";
	_aicskill 			= [];
	_aipack 			= "none";
	_aivest				= "none";
	_current_time		= time;
	_unarmed			= false;
	
	call {
		if(typeName(_aisoldier) == "SCALAR") then {
			if(_aisoldier == 0) 			exitWith { _unitType = ai_assault; };
			if(_aisoldier == 1) 			exitWith { _unitType = ai_machine; };
			if(_aisoldier == 2) 			exitWith { _unitType = ai_sniper; };
		} else {
			if(_aisoldier == "random") 		exitWith { _unitType = ai_random call BIS_fnc_selectRandom; };
			if(_aisoldier == "unarmed") 	exitWith { _unitType = ai_assault;_unarmed = true; };
		};
	};
		
	//if(debug_mode) then { diag_log("WAI: AI Type " + str(_unitType)); };
	// AI items and weapons
	_aiweapon 			= (_unitType select 0) call BIS_fnc_selectRandom;
	//if(debug_mode) then { diag_log("WAI: AI GEAR WEP " + str(_aiweapon)); };
	_aiweaponscope		= (_unitType select 1) call BIS_fnc_selectRandom;
	//if(debug_mode) then { diag_log("WAI: AI GEAR SCOPE " + str(_aiweaponscope)); };
	
	_aigear 			= _unitType select 2;
	
	if(count _aigear > 1) then {
		_aiGearWep  = _aigear select 0;
		_aiGearItem = _aigear select 1;
	};
	
	//if(debug_mode) then { diag_log("WAI: AI GEAR item " + str(_aigear)); };
	_aiskin 			= (_unitType select 3) call BIS_fnc_selectRandom;
	//if(debug_mode) then { diag_log("WAI: AI GEAR SKIN " + str(_aiskin)); };	
	_aipack 			= (_unitType select 4) call BIS_fnc_selectRandom;
	//if(debug_mode) then { diag_log("WAI: AI GEAR back " + str(_aipack)); };
	_aivest				= (_unitType select 5) call BIS_fnc_selectRandom;
	//if(debug_mode) then { diag_log("WAI: AI GEAR vest " + str(_aivest)); };
	
	_unit = _unitGroup createUnit["I_Soldier_EPOCH", [_pos_x,_pos_y,_pos_z], [], 0,"FORM"];
	[_unit] joinSilent _unitGroup;
	_unit allowFleeing 0;

	call {
		if(_aitype == "bandit") 	exitWith { _unit setVariable ["Bandit",true]; _unit setVariable ["krypto", ai_add_krypto]; };
		if(_aitype == "special") 	exitWith { _unit setVariable ["Special",true]; _unit setVariable ["krypto", ai_special_krypto]; };
	};

	if (!isNil "_gain") then {
		_unit setVariable ["krypto", _gain];
	};
	
	if (isNil "_mission") then {
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";

	};

	// "Remove existing items";
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit; 
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	//if(debug_mode) then { diag_log("WAI: AI removed default items"); };
	
	// Unit name
	_unit setName "[WAI]" + str(floor(random 999) + 1);
	
	// "Must have items";
	_unit linkItem "ItemMap";
	_unit linkItem "ItemRadio";
	
	// uniform
	_unit forceAddUniform _aiskin;
	_unit addHeadgear Format ["H_%1_EPOCH", floor(random 91) + 1];
	
	// Vest
	if(_aivest != "") then {
		_unit addvest _aivest;
	} else {
		_unit addvest Format ["V_%1_EPOCH", floor(random 39) + 1];
	};
	
	// Fill vest
	/*{
		_unit addItemToVest _x;
	} count _aiGearItem;*/
	
	
	// So AI can at night
	if (sunOrMoon != 1) then {
		_unit linkItem "NVG_Epoch";
	};

	// GUNS GUNS GUNS
	if (!_unarmed) then {
		_muzzle = [_unit, _aiweapon, (floor(random 5) + 1)] call BIS_fnc_addWeapon;
		_unit selectWeapon _aiweapon;
		
		// 40% chance for scope
		if(floor(random 100) < 40) then {
			_unit addPrimaryWeaponItem _aiweaponscope;
		};
		
		// 20% chance for accessories
		if(floor(random 100) < 20) then {
			_unit addPrimaryWeaponItem (ai_wep_item call BIS_fnc_selectRandom);
		};
		
		// 10% chance for suppressor
		if(floor(random 100) < 10) then {
			_suppressor = _aiweapon call find_suitable_suppressor;
			if(_suppressor != "") then {
				_unit addPrimaryWeaponItem _suppressor;
			};
			
		};
		
	};
	
	// give them unlimited ammo!
	if (!_unarmed) then {
		_unit addeventhandler ["fired", {(_this select 0) setvehicleammo 1;}];
	};

	// For now backpack spawn in the crates
	/*if(count _aipack != 0) then {
		_unit addBackpack _aipack;
	};
	// Fill backpack
	{
		_unit addItemToBackpack _x;
	} count _aiGearWep;*/
	
	//Hipster
	/*if(debug_mode) then {
		_unit addHeadgear "H_78_EPOCH";
		_unit addGoggles "G_Spectacles_Tinted";
	};*/
	
	// if AI spawns on water make them ready for it
	if (surfaceIsWater (position _unit)) then {
		removeHeadgear _unit;
		_unit forceAddUniform "U_O_Wetsuit" ;
		_unit addVest "V_20_EPOCH";
		_unit addGoggles "G_Diving";
		_muzzle = [_unit, "arifle_SDAR_F", 3, "20Rnd_556x45_UW_mag"] call BIS_fnc_addWeapon;

	};
	
	//if(debug_mode) then { diag_log("WAI: AI gear done"); };
	
	call {
		if(_skill == "easy") 		exitWith { _aicskill = ai_skill_easy; };
		if(_skill == "medium") 		exitWith { _aicskill = ai_skill_medium; };
		if(_skill == "hard") 		exitWith { _aicskill = ai_skill_hard; };
		if(_skill == "extreme") 	exitWith { _aicskill = ai_skill_extreme; };
		if(_skill == "random") 		exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
		_aicskill = ai_skill_random call BIS_fnc_selectRandom;
	};

	{
		_unit setSkill [(_x select 0),(_x select 1)]
	} count _aicskill;

	// Ground unit
	_unit addEventHandler ["Killed",{[_this select 0, _this select 1, "ground"] call on_kill;}];

	if (!isNil "_mission") then {
		wai_mission_data select _mission set [0, (((wai_mission_data select _mission) select 0) + 1)];
		_unit setVariable ["missionclean", "ground"];
		_unit setVariable ["mission", _mission, true];
	};
	
	// return solider
	_unit
};