if (isServer) then {

    private ["_muzzle","_unitType","_aisoldier","_hat","_rocket","_count","_launcher","_pos_x","_pos_y","_pos_z","_aiskin","_unarmed","_current_time","_gain","_mission","_ainum","_aitype","_mission","_aipack","_aicskill","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_vest","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_gearmagazines","_geartools","_unit"];
	
	/*[
		_position,		[_position select 0,_position select 1,0]
		_unitnumber,	3
		_skill,			Medium
		_aisoldier,		Random
		_aitype,		Bandit
		_mission
	] call spawn_group;*/
	
	_position 			= _this select 0;
		_pos_x 			= _position select 0;
		_pos_y 			= _position select 1;
		_pos_z 			= _position select 2;
	_unitnumber 		= _this select 1;
	_skill 				= _this select 2;
	_aisoldier 			= _this select 3;
	_aitype				= _this select 4;

	if (count _this > 5) then {
		_mission = _this select 5;
	} else {
		_mission = nil;
	};
	
	
	if(debug_mode) then { diag_log("WAI: Spawning AI " + str(_aitype)); };
	
	// if soldier have AT/AA weapons
	if (typeName _aisoldier == "ARRAY") then {
		_launcher		= _aisoldier select 1;
		_aisoldier		= _aisoldier select 0;
	};
	
	// Create AI group	
	_unitGroup	= createGroup RESISTANCE;
	_unitGroup setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_unitGroup setVariable["LAST_CHECK",1000000000000]; 
		
	// Find position
	if(_pos_z == 0) then {
		if(floor(random 2) == 1) then { 
			_pos_x = _pos_x - (5 + random(25));
		} else {
			_pos_x = _pos_x + (5 + random(25));
		};			

		if(floor(random 2) == 1) then { 
			_pos_y = _pos_y - (5 + random(25));
		} else {
			_pos_y = _pos_y + (5 + random(25));
		};
	};

	// spawn X numvbers of AI in the group
	for "_x" from 1 to _unitnumber do {
		_unit = [_unitGroup,[_pos_x,_pos_y,_pos_z],_aisoldier,_skill,_aitype,_mission] call spawn_soldier;
		ai_ground_units = (ai_ground_units + 1);
	};

	if (!isNil "_launcher" && wai_use_launchers) then {
		call {
			if (_launcher == "at") exitWith { _launcher = ai_wep_launchers_AT call BIS_fnc_selectRandom; };
			if (_launcher == "aa") exitWith { _launcher = ai_wep_launchers_AA call BIS_fnc_selectRandom; };
		};
		_rocket = _launcher call find_suitable_ammunition;
		_unit addMagazine _rocket;
		_unit addMagazine _rocket;
		_unit addWeapon _launcher;
		_unit addBackpack "B_Carryall_mcamo";
		
		if(debug_mode) then { diag_log("WAI: AI "+str(_unit) + " have " + str(_rocket)); };
	};

	_unitGroup setFormation "ECH LEFT";
	_unitGroup selectLeader ((units _unitGroup) select 0);

	if (!isNil "_mission") then {
		if(debug_mode) then { diag_log("WAI: mission nr " + str(_mission)); };
		[_unitGroup, _mission] spawn bandit_behaviour;
	} else {
		[_unitGroup] spawn bandit_behaviour;
	};
	
	if(_pos_z == 0) then {
		[_unitGroup,[_pos_x,_pos_y,_pos_z],_skill] spawn group_waypoints;
	};

	diag_log format ["WAI: Spawned a group of %1 AI at %2",_unitnumber,_position];
	_unitGroup
};