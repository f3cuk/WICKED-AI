if (isServer) then {

	private ["_pos_x","_pos_y","_pos_z","_ainum","_unarmed","_aicskill","_aitype","_mission","_aipack","_class","_position2","_static","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_gearmagazines","_geartools","_unit"];

	_position 			= _this select 0;
	_class 				= _this select 1;
	_skill 				= _this select 2;
	_aitype				= _this select 3;
	
	if (count _this > 4) then {
		_mission = _this select 4;
	} else {
		_mission = nil;
	};
	
	_position2 		= [];
	_unitnumber 	= count _position;
	
	if(debug_mode) then { diag_log("WAI: Static AI " + str(_class)); };

	_unitGroup	= createGroup EAST;
	_unitGroup setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_unitGroup setVariable["LAST_CHECK",1000000000000]; 
	
	{
		
		_position2 = _x;
		if(debug_mode) then { diag_log("WAI: Static AI POS " + str(_position2)); };
		
		_pos_x 			= _position2 select 0;
		_pos_y 			= _position2 select 1;
		_pos_z 			= _position2 select 2;

		call {
			if (_class == "Random") exitWith { _class = ai_static_weapons call BIS_fnc_selectRandom; };
		};
		
		if (ai_static_skills) then {
			{
				_skill = _skill + [(_x select 0),(_x select 1)];
			} count ai_static_array;
		};
		
		if (ai_static_useweapon) then {
			_unit = [_unitGroup,[_pos_x,_pos_y,_pos_z],0,_skill,_aitype,_mission] call spawn_soldier;
		} else {
			_unit = [_unitGroup,[_pos_x,_pos_y,_pos_z],"unarmed",_skill,_aitype,_mission] call spawn_soldier;
		};

		// Make it an static unit
		_unit setVariable ["missionclean", "static"];
		_unit removeEventHandler ["killed", 0];
		_unit addEventHandler ["Killed",{[_this select 0, _this select 1, "static"] call on_kill;}];
		
		_static = createVehicle [_class, [(_position2 select 0),(_position2 select 1),(_position2 select 2)], [], 10, "FORM"];
		_static setDir round(random 360);
		_static setPos [(_position2 select 0),(_position2 select 1),(_position2 select 2)];
		
		_static setVariable["LASTLOGOUT_EPOCH",1000000000000];
		_static setVariable["LAST_CHECK",1000000000000];
		_static lock true;
			
		// Cleanup
		addToRemainsCollector [_static];
		
		// Disable Thermal
		_static disableTIEquipment true;
		
		// Set Token
		_static call EPOCH_server_setVToken;
		
		// Set Vehicle Slot
		EPOCH_VehicleSlotsLimit = EPOCH_VehicleSlotsLimit + 1;
		EPOCH_VehicleSlots pushBack (str EPOCH_VehicleSlotsLimit);
		_static setVariable ["VEHICLE_SLOT",(EPOCH_VehicleSlots select 0),true];
		EPOCH_VehicleSlots = EPOCH_VehicleSlots - [(EPOCH_VehicleSlots select 0)];
		EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;

		ai_emplacement_units = (ai_emplacement_units + 1);
		_static addEventHandler ["GetOut",{(_this select 0) setDamage 1;}];
		
		_unit moveingunner _static;
		reload _unit;
		
		if (!isNil "_mission") then {
			_ainum = (wai_mission_data select _mission) select 0;
			wai_mission_data select _mission set [0, (_ainum + 1)];
			_static setVariable ["missionclean","static"];
			_static setVariable ["mission",_mission];
		};

		[_static] spawn vehicle_monitor;

	} forEach _position;

	_unitGroup selectLeader ((units _unitGroup) select 0);

	
		if (!isNil "_mission") then {
			[_unitGroup, _mission] spawn bandit_behaviour;
		} else {
			[_unitGroup] spawn bandit_behaviour;
		};
	

	diag_log format ["WAI: Spawned in %1 %2",_unitnumber,_class];

	_unitGroup
};