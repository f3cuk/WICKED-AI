if (isServer) then {

	private ["_Safeposition","_driver","_ainum","_vehicle","_aiskin","_skin","_mission","_aitype","_aicskill", "_gunner", "_wpnum","_radius","_skillarray","_startingpos","_veh_class","_veh","_unitGroup","_pilot","_skill","_position","_wp"];

	_position 				= _this select 0;
	_startingpos 			= _this select 1;
	_radius 				= _this select 2;
	_wpnum 					= _this select 3;
	_veh_class 				= _this select 4;
	_skill 					= _this select 5;
	_aisoldier				= _this select 6;
	_aitype					= _this select 7;

	if (count _this > 8) then {
		_mission 			= _this select 8;
	} else {
		_mission 			= nil;
	};
	if(debug_mode) then { diag_log("WAI: Vehicle mission " + str(_mission)); };

	_skillarray 			= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	_unitGroup				= createGroup RESISTANCE;
	_unitGroup 				setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_unitGroup 				setVariable["LAST_CHECK",1000000000000]; 
	_unitGroup 				allowFleeing 0;
	
	if(debug_mode) then { diag_log("WAI: Spawning vehicle patrol at " + str(mapGridPosition(_startingpos))); };
	if(debug_mode) then { diag_log("WAI: Driving to " + str(mapGridPosition(_position))); };
	
	_Safeposition 			= [_startingpos,0,50,20,0,15,0] call BIS_fnc_findSafePos;
	_vehicle 				= createVehicle [_veh_class, [(_Safeposition select 0),(_Safeposition select 1), 0], [], 0, "CAN_COLLIDE"];
	_vehicle 				setFuel 1;
	_vehicle 				engineOn true;
	_vehicle 				setVehicleAmmo 1;
	_vehicle 				addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
	//_vehicle 				allowCrewInImmobile true; 
	_vehicle 				lock true;
	_vehicle 				= _vehicle call wai_vehicle_protect;
	
	if (!isNil "_mission") then {
		_ainum = (wai_mission_data select _mission) select 0;
		wai_mission_data select _mission set [0, (_ainum + 1)];
		//_vehicle setVariable ["missionclean","vehicle"];
		_vehicle setVariable ["mission",_mission];;
	};
	
	/* CREW START */	
	_driver 			= [_unitGroup,_position,_aisoldier,_skill,_aitype,_mission] call spawn_soldier;
	_driver 			assignAsDriver _vehicle;
	_driver 			moveInDriver _vehicle;
	if(debug_mode) then { diag_log("WAI: Spawning vehicle driver " + str(_driver)); };
	
	_gunner 			= [_unitGroup,_position,_aisoldier,_skill,_aitype,_mission] call spawn_soldier;
	_gunner 			assignAsGunner _vehicle;
	_gunner 			moveInTurret [_vehicle,[0]];
	if(debug_mode) then { diag_log("WAI: Spawning vehicle gunner 1 " + str(_gunner)); };

	[_driver,_gunner] 	joinSilent _unitGroup;
	//Driver is leader
	_unitGroup 			selectLeader _driver;
	
	{
		_driver setSkill [_x,1]
	} count _skillarray;

	{
		// Make it an vehicle unit
		_x removeEventHandler ["killed", 0];
		_x setVariable ["missionclean", "vehicle"];
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];
		ai_vehicle_units = (ai_vehicle_units + 1);		
	} count (units _unitgroup);
	
	if (!isNil "_mission") then {
		[_unitGroup, _mission] spawn bandit_behaviour;
	} else {
		[_unitGroup] spawn bandit_behaviour;
	};
	
	// See https://community.bistudio.com/wiki/AIBehaviour
	// "AWARE" Units try to stay mostly on roads
	_unitGroup setBehaviour "AWARE";
	
	/* CREW END */

	if(_wpnum > 0) then {

		for "_x" from 1 to _wpnum do
		{		
			_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
			_wp setWaypointType "SAD";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointCompletionRadius 50;
			_wp setWaypointSpeed "NORMAL";
			_wp setWaypointStatements ["true",
			"
				if(debug_mode) then {diag_log('WAI: Vehicle speed ' + str(speed this)); };
			"];
			//if(debug_mode) then { diag_log("WAI: Vehicle WP" + str(_x) + " / " + str(_wp)); };
		};

	};

	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 50;
	
	_unitGroup
};
