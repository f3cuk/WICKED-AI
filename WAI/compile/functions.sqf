// Finds suitable ammunition from weapon configs during ai and crate weapon spawning
find_suitable_ammunition = {

	private["_weapon","_result","_ammoArray"];

	_result 	= false;
	_weapon 	= _this;
	_ammoArray 	= getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
		call {
			if(_result == "20Rnd_556x45_Stanag") 	exitWith { _result = "30Rnd_556x45_Stanag"; };
		};
	};
	_result
};

// Clears crate contents and general crate setup
wai_crate_setup = {
	private "_crate";
	
	_crate = _this;
	_crate setVariable ["ObjectID","1",true];
	_crate setVariable ["permaLoot",true];
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_crate];
	_crate addEventHandler ["HandleDamage", {}];
};

// Sends mission announcements to all clients
wai_server_message = {
	private "_message";
	_message = _this;

	call
	{
		if (wai_mission_announce == "Radio") exitWith {
			RemoteMessage = ["radio","[RADIO] " + _message];
			publicVariable "RemoteMessage";
		};
		if (wai_mission_announce == "DynamicText") exitWith {
			RemoteMessage = ["dynamic_text", ["Mission Announcement",_message]];
			publicVariable "RemoteMessage";
		};
		if (wai_mission_announce == "titleText") exitWith {
			[nil,nil,rTitleText,_message,"PLAIN",10] call RE;
		};
	};
};

// Sends an early warning to players approaching a minefield in a vehicle
wai_minefield_warning = {
	private "_owner";
	_owner = (owner _this);
	diag_log format["WAI: Minefield Warning Owner %1",_owner];
	
	//RemoteMessage = ["titleCut","WARNING: You are approaching a minefield! Stop and continue on foot."];
	//(_owner) publicVariableClient "RemoteMessage";
	RemoteMessage = ["dynamic_text2","WARNING: You are approaching a minefield! Stop and continue on foot."];
	(_owner) publicVariableClient "RemoteMessage";
};

// Removes mines from mission
wai_remove_mines = {
	private "_delete_mines";
	_delete_mines = (wai_mission_data select _this) select 2;

	if(count _delete_mines > 0) then {
		{
			deleteVehicle _x;
		} count _delete_mines;
	};
};

// Auto-Claim alert messages
wai_AutoClaimAlert = {
	private ["_unit","_owner","_missionName","_messageType","_message","_name"];
	_unit = _this select 0;
	_missionName = _this select 1;
	_messageType = _this select 2;
	if (typeName _unit == "ARRAY") then {
		_name = _unit select 1;
	} else {
		_owner = owner _unit;
		_name = name _unit;
	};
	
	call
	{
		if (_messageType == "Start") exitWith {_message = format["AutoClaim: If you want to claim %1, then do not leave the mission area for %2 seconds!",_missionName,ac_delay_time];};
		if (_messageType == "Stop") exitWith {_message = format["AutoClaim: You did not claim %1",_missionName];};
		if (_messageType == "Return") exitWith {_message = format["You have left the mission area, you have %1 seconds to return!",ac_timeout];};
		if (_messageType == "Reclaim") exitWith {_message = "You are back in the mission area.";};
		if (_messageType == "Claimed") exitWith {_message = format["AutoClaim: %1 has claimed %2! A marker has been placed.", _name, _missionName];};
		if (_messageType == "Unclaim") exitWith {_message = format["AutoClaim: %1 has abandoned %2! The marker has been removed.", _name, _missionName];};
	};
	
	if (_messageType == "Claimed" || _messageType == "Unclaim" || _messageType == "Abandoned") exitWith {
		RemoteMessage = ["IWAC",_message];
		publicVariable "RemoteMessage";
	};
	
	RemoteMessage = ["IWAC",_message];
	(_owner) publicVariableClient "RemoteMessage";
};

// Called continuously from the mission loop to monitor the AI vehicles
wai_monitor_ai_vehicles = {
	private "_aiVehicles";
	
	_aiVehicles = (wai_mission_data select _this) select 4;
	if(count _aiVehicles > 0) then {
		{
			if (alive _x && ({alive _x} count crew _x > 0)) then {
				_x setVehicleAmmo 1;
				_x setFuel 1;
			} else {_x setDamage 1;};
		} count _aiVehicles;
	};
};

// Removes alive AI vehicles from the mission
wai_remove_ai_vehicles = {
	private "_aiVehicles";
	_aiVehicles = (wai_mission_data select _this) select 4;
	if(count _aiVehicles > 0) then {
		{
			if (alive _x) then {
				deleteVehicle _x;
			}
		} count _aiVehicles;
	};
};

// Removes AI and mission vehicles that are alive or not destroyed
wai_remove_alive = {

	{

		if (_x getVariable ["mission", nil] == _this) then {
		
			if (alive _x) then {

				_cleanunits = _x getVariable ["missionclean",nil];

				if (!isNil "_cleanunits") then {
			
					call {
						if(_cleanunits == "ground") 	exitWith { ai_ground_units = (ai_ground_units -1); };
						if(_cleanunits == "air") 		exitWith { ai_air_units = (ai_air_units -1); };
						if(_cleanunits == "vehicle") 	exitWith { ai_vehicle_units = (ai_vehicle_units -1); };
						if(_cleanunits == "static") 	exitWith { ai_emplacement_units = (ai_emplacement_units -1); };
					};
				};
			};
			
			deleteVehicle _x;
		};

	} count allUnits + vehicles;
};

// Removes buildings from mission - excludes mission vehicles
wai_remove_buildings = {
	{
		if (typeName _x == "ARRAY") then {
			{
				if !(_x isKindOf "AllVehicles") then {deleteVehicle _x;};
			} count _x;
		} else {
			if !(_x isKindOf "AllVehicles") then {deleteVehicle _x;};
		};
	} forEach _this;
};

// Generates the keys for mission vehicles
wai_generate_vehicle_key = {
	private ["_keyColor","_keyNumber","_vehicle","_crate","_keySelected","_mission","_unit","_ailist","_characterID"];
	
	_vehicle = _this select 0;
	_mission = _this select 1;
	_crate = _this select 2;
	
	if (wai_vehicle_keys == "NoVehicleKey") then {
		_vehicle setVariable ["CharacterID","0",true];
	
	} else {
	
		// First select key color
		_keyColor = DZE_keyColors call BIS_fnc_selectRandom;

		// then select number from 1 - 2500
		_keyNumber = (floor(random 2500)) + 1;

		// Combine to key (eg.ItemKeyYellow2494) classname
		_keySelected = format["ItemKey%1%2",_keyColor,_keyNumber];
		
		_isKeyOK = isClass(configFile >> "CfgWeapons" >> _keySelected);
		
		_characterID = str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));
		
		if (_isKeyOK) then {
			if (wai_vehicle_keys == "KeyinVehicle") then {
				_vehicle addWeaponCargoGlobal [_keySelected,1];
				_vehicle setVariable ["CharacterID",_characterID,true];
			};		
			if (wai_vehicle_keys == "KeyinCrate") then {
				_vehicle setVehicleLock "locked";
				_vehicle setVariable ["CharacterID", _characterID, true];
				_crate addWeaponCargoGlobal [_keySelected, 1];
			};			
			if (wai_vehicle_keys == "KeyonAI") then {
				_ailist = [];
				
				{
					if (_x getVariable ["mission",nil] == _mission) then {_ailist set [count _ailist, _x];};
				} count allUnits;
				
				_unit = _ailist call BIS_fnc_selectRandom;
				_unit addWeapon _keySelected;
				
				if(wai_debug_mode) then {
					diag_log format["There are %1 AI for mission %2 vehicle key",_ailist,_mission];
					diag_log format["Key added to %1 for vehicle %2",_unit,_vehicle];
				};
			
				_vehicle setVehicleLock "locked";
				_vehicle setVariable ["CharacterID",_characterID,true];
			};
		} else {
			_vehicle setVariable ["CharacterID","0",true];
			diag_log format["There was a problem generating a key for vehicle %1 at mission %2",_vehicle,_mission];
		};
	};
};

// Checks to see if the mission completion criteria has been met. Returns true or false.
wai_completion_check = {
	private ["_completionType","_complete","_position","_mission","_killpercent","_objectivetarget"];
	
	_mission = _this select 0;
	_completionType = _this select 1;
	_killpercent = _this select 2;
	_position = _this select 3;
	_complete = false;
	
	call
	{
		// If you have killed enough AI, then the mission will complete when you get within 20 meters of the mission center
		if (_completionType select 0 == "crate") exitWith {

			if(wai_kill_percent == 0) then {
				_complete = [_position,20] call isNearPlayer;
			} else {
				if(((wai_mission_data select _mission) select 0) <= _killpercent) then {
					_complete = [_position,20] call isNearPlayer;
				};
			};
		};
		
		// If all AI are killed, then the mission is complete
		if (_completionType select 0 == "kill") exitWith {
			if(((wai_mission_data select _mission) select 0) == 0) then {
				_complete = true;
			};
		};
		
		// If you assassinate the target designated in the mission, then the mission will complete
		if (_completionType select 0 == "assassinate") exitWith {
			_objectivetarget = _completionType select 1;
			{
				_complete = true;
				if (alive _x) exitWith {_complete = false;};
			} count units _objectivetarget;
		};

		/* no missions are using this function at the moment
		if (_completionType == "resource") exitWith {
			_node 		= _completionType select 1;
			_resource 	= _node getVariable ["Resource", 0];
			if (_resource == 0) then {
				if ([_position,80] call isNearPlayer) then {
					_complete = true;
				} else {
					_timeout = true;
				};
			};
		}; */
	};
	_complete
};

/* nothing is using this function at the moment
hero_warning = {

	private ["_warned"];
	_position = _this select 0;
	_mission = _this select 1;
	_running = (typeName (wai_mission_data select _mission) == "ARRAY");

	while {_running} do {
		{
			_warning_one = _x getVariable ["warning_one", false];
			_warning_two = _x getVariable ["warning_two", false];
			_warning_bandit = _x getVariable ["warning_bandit", false];
			if((isPlayer _x) && ((_x distance _position) <= 1200) && (_x getVariable ["humanity", 0] > player_bandit)) then {

				if (_x distance _position > ai_hero_engage_range) then {

					if (!_warning_one && (_x distance _position <= 150)) then {

						_msg = format ["Warning! This is a restricted area! Come closer and we will engage!"];
						[nil,_x,rTitleText,_msg,"PLAIN",10] call RE;
						_x setVariable ["warning_one", true];
					};

				} else {

					if (!_warning_two) then {
						_msg = format ["You were warned %1.", name _x];
						[nil,_x,rTitleText,_msg,"PLAIN",10] call RE;
						_x setVariable ["warning_two", true];
					};

				};
			};
		} forEach playableUnits;
	_running = (typeName (wai_mission_data select _mission) == "ARRAY");
	};
};
*/
