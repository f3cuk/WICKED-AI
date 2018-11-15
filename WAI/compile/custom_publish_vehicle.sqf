private ["_unit","_ailist","_hit","_count","_vehpos","_max_distance","_vehicle","_position_fixed","_position","_dir","_class","_dam","_damage","_hitpoints","_selection","_fuel","_key","_inventory"];

_count = count _this;
_class = _this select 0;
_position = _this select 1;
_mission = _this select 2;
_max_distance = 17;
_position_fixed = false;
_dir = floor(round(random 360));

if (typeName _class == "ARRAY") then {
	_class = _class call BIS_fnc_selectRandom;
};

if (_count > 3) then {
	_position_fixed = _this select 3;
};

if (_count > 4) then {
	_dir = _this select 4;
};

if (!_position_fixed) then {
	_vehpos = [0,0,0];
	while {count _vehpos > 2} do { 
		_vehpos = [_position,12,_max_distance,10,0,0.7,0] call BIS_fnc_findSafePos; // Works better
		//_vehpos = _position findEmptyPosition[20,_max_distance,_class]; 
		_max_distance = (_max_distance + 10);
	};
} else {
	_vehpos = _position;
};

_vehicle = _class createVehicle _vehpos;
_vehicle setDir _dir;
_vehicle setPos _vehpos;
_vehicle setVectorUp surfaceNormal position _vehicle;
_vehicle setVariable ["ObjectID","1",true];
_vehicle setVariable ["CharacterID","1",true]; // Set character ID to non-zero number so players see the red "Vehicle Locked" message
_vehicle setVariable ["mission",_mission];
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
_vehicle setVehicleLock "locked";

((wai_mission_data select _mission) select 5) set [count ((wai_mission_data select _mission) select 5), _vehicle];

if (wai_debug_mode) then {diag_log format["WAI: Spawned %1 at %2",_class,_vehpos];};

if (getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {
	_hitpoints = _vehicle call vehicle_getHitpoints;
	{
		_dam = (random((wai_vehicle_damage select 1) - (wai_vehicle_damage select 0)) + (wai_vehicle_damage select 0)) / 100;
		_selection = getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");

		if ((_selection in dayZ_explosiveParts) && _dam > 0.8) then {
			_dam = 0.8
		};

		_isglass = ["glass", _selection] call fnc_inString;

		if(!_isglass && _dam > 0.1) then {
			_strH = "hit_" + (_selection);
			_vehicle setHit[_selection,_dam];
			_vehicle setVariable [_strH,_dam,true];
			if (wai_debug_mode) then {diag_log format["WAI: Calculated damage for %1 is %2",_selection,_dam];};
		};
	} count _hitpoints;
	
	_fuel = (random((wai_mission_fuel select 1) - (wai_mission_fuel select 0)) + (wai_mission_fuel select 0)) / 100;
	_vehicle setFuel _fuel;
	if (wai_debug_mode) then {diag_log format["WAI: Added %1 percent fuel to vehicle",_fuel];};
};

if (wai_godmode_vehicles) then {
	_vehicle addEventHandler ["HandleDamage",{0}];
} else {
	_vehicle addEventHandler ["HandleDamage",{_this call fnc_veh_handleDam}];
};

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_vehicle];

if (wai_keep_vehicles) then {
	
	_vehicle addEventHandler ["GetIn", {
		_vehicle = _this select 0;
		_unit = _this select 2;
		_vehicle setVariable ["mission", nil];
		
		if !(isPlayer _unit) exitWith {};
		
		if (wai_debug_mode) then {diag_log "PUBLISH: Attempt " + str(_vehicle);};

		_class = typeOf _vehicle;
		_characterID = _vehicle getVariable ["CharacterID", "0"];
		_worldspace	= [getDir _vehicle, getPosATL _vehicle];
		_hitpoints = _vehicle call vehicle_getHitpoints;
		_damage = damage _vehicle;
		_fuel = fuel _vehicle;
		_uid = _worldspace call dayz_objectUID2;
		_array = [];
		
		{
			_hit = [_vehicle,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
			if (wai_debug_mode) then {diag_log format ["Section Part: %1, Dmg: %2",_selection,_hit];};
		} count _hitpoints;

		_inventory = [getWeaponCargo _vehicle, getMagazineCargo _vehicle, getBackpackCargo _vehicle];

		_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,_damage,_characterID,_worldspace,_inventory,_array,_fuel,_uid];
		_key call server_hiveWrite;
		_key = format["CHILD:388:%1:",_uid];
		_result = _key call server_hiveReadWrite;
		_outcome = _result select 0;
		
		if (wai_debug_mode) then {diag_log "HIVE: WRITE: "+ (str _key);};
		
		if (_outcome != "PASS") then {
			deleteVehicle _vehicle;
			diag_log "CUSTOM: failed to get id for : " + (str _uid);
		} else {
			_oid = _result select 1;
			_vehicle setVariable ["ObjectID", _oid, true];

			if (wai_debug_mode) then {diag_log "CUSTOM: Selected " + (str _oid);};

			_vehicle setVariable ["lastUpdate",diag_tickTime];
			_vehicle call fnc_veh_ResetEH;
			PVDZE_veh_Init = _vehicle;
			publicVariable "PVDZE_veh_Init";

			diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));
			
			if (wai_vehicle_message) then {
				[nil,(_this select 2),"loc",rTitleText,"This vehicle is saved to the database.","PLAIN",5] call RE;
			};
		};
	}];

} else {
	_vehicle addEventHandler ["GetIn", {
		_vehicle = _this select 0;
		
		if (wai_vehicle_message) then {
			[nil,(_this select 2),"loc",rTitleText,"WARNING: This vehicle will be deleted at restart!","PLAIN",5] call RE;
		};
		
		if (_vehicle getVariable ["claimed",nil] == "yes") exitWith {};
		
		_vehicle setVariable ["mission", nil];
		_vehicle setVariable ["claimed","yes",false];
		_vehicle removeAllEventHandlers "HandleDamage";
		_vehicle addEventHandler ["HandleDamage",{_this call fnc_veh_handleDam}];
		
	}];
};

_vehicle
