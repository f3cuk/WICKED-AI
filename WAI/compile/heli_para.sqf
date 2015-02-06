if (isServer) then {

	private ["_mission_data","_pos_x","_pos_y","_ainum","_missionrunning","_aitype","_helipos1","_geartools","_gearmagazines","_cleanheli","_drop","_helipos","_gunner2","_gunner","_player_present","_skillarray","_aicskill","_aiskin","_aigear","_wp","_helipatrol","_gear","_skin","_backpack","_vest","_mags","_gun","_triggerdis","_startingpos","_aiweapon","_mission","_heli_class","_aipack","_helicopter","_unitGroup","_pilot","_skill","_paranumber","_position","_wp1"];

	_position 		= _this select 0;
	_pos_x			= _position select 0;
	_pos_y			= _position select 1;
	_startingpos 	= _this select 1;
	_triggerdis 	= _this select 2;
	_heli_class 	= _this select 3;
	_paranumber 	= _this select 4;
	_skill 			= _this select 5;
	_gun 			= _this select 6;
	_mags 			= _this select 7;
	_backpack 		= _this select 8;
	_skin 			= _this select 9;
	_gear 			= _this select 10;
	_aitype			= _this select 11;
	_helipatrol 	= _this select 12;
	_vest			= _this select 13;
	_aipack 		= "";
	_aivest			= "";

	if (count _this > 14) then {
		_mission = _this select 14;
	} else {
		_mission = nil;
	};

	_aiweapon 		= [];
	_aigear 		= [];
	_aiskin 		= "";
	_aicskill 		= [];
	_skillarray 	= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	if(debug_mode) then { diag_log "WAI: Paradrop waiting for player"; };

	waitUntil
	{
		sleep 10;

		_player_present = false;

		{
			if((isPlayer _x) && (_x distance [_pos_x,_pos_y,0] <= _triggerdis)) then {
				_player_present = true;
			};
		} count playableUnits;

		(_player_present)
	};

	call {
		if (_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
		if (_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
		if (_skin == "special") exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
		_aiskin = _skin;
	};

	if(typeName _aiskin == "ARRAY") then {
		_aiskin = _aiskin call BIS_fnc_selectRandom;
	};

	if(!isNil "_mission") then {

		_missionrunning = (typeName (wai_mission_data select _mission) == "ARRAY");
			
	} else {

		_missionrunning = true;

	};

	if(!_missionrunning) exitWith { if(debug_mode) then { diag_log format["WAI: Mission at %1 already ended, aborting para drop",_position]; }; };

	if(debug_mode) then { diag_log format ["WAI: Spawning a %1 with %2 units to be para dropped at %3",_heli_class,_paranumber,_position]; };

	_unitGroup	= createGroup RESISTANCE;
	
	ai_air_units = (ai_air_units +1);

	_helicopter = createVehicle [_heli_class,[(_startingpos select 0),(_startingpos select 1),100],[],0,"FLY"];
	_helicopter setFuel 1;
	_helicopter engineOn true;
	_helicopter setVehicleAmmo 1;
	_helicopter flyInHeight 150;
	_helicopter addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
	_helicopter setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_helicopter setVariable["LAST_CHECK",1000000000000]; 	

	_pilot = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
	_pilot setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_pilot setVariable["LAST_CHECK",1000000000000]; 
	_pilot assignAsDriver _helicopter;
	_pilot moveInDriver _helicopter;
	[_pilot] joinSilent _unitGroup;
	

	_gunner = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
	_gunner assignAsGunner _helicopter;
	_gunner moveInTurret [_helicopter,[0]];
	[_gunner] joinSilent _unitGroup;
	_gunner setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_gunner setVariable["LAST_CHECK",1000000000000]; 

	ai_air_units = (ai_air_units +1);

	_gunner2 = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
	_gunner2 assignAsGunner _helicopter;
	_gunner2 moveInTurret [_helicopter,[1]];
	[_gunner2] joinSilent _unitGroup;
	_gunner2 setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_gunner2 setVariable["LAST_CHECK",1000000000000]; 
	
	_unitGroup = objNull; 
		addToRemainsCollector [_helicopter, _pilot, _gunner, _gunner2];

	call {
		if (_aitype == "Bandit") 	exitWith { { _x setVariable ["Bandit",true]; _x setVariable ["humanity", ai_remove_humanity]; } count [_pilot, _gunner, _gunner2]; };
		if (_aitype == "Special") 	exitWith { { _x setVariable ["Special",true]; _x setVariable ["humanity", ai_special_humanity]; } count [_pilot, _gunner, _gunner2]; };
	};
	
	ai_air_units = (ai_air_units +1);

	{
		_pilot setSkill [_x,1]
	} count _skillarray;

	{
		_gunner 	setSkill [_x,0.7];
		_gunner2 	setSkill [_x,0.7];
	} count _skillarray;

	{
		_x addweapon "1911_pistol_epoch";
		_x addmagazine "9Rnd_45ACP_Mag";
		_x addmagazine "9Rnd_45ACP_Mag";
	} count (units _unitgroup);

	
	//[_helicopter] spawn vehicle_monitor;  //this will need changed for A3 Epoch

	_unitGroup allowFleeing 0;
	_unitGroup setBehaviour "CARELESS";
	_unitGroup setSpeedMode "FULL";

		if (!isNil "_mission") then {
			[_unitGroup, _mission] spawn bandit_behaviour;
		} else {
			[_unitGroup] spawn bandit_behaviour;
		};
	

	// Add waypoints to the chopper group.
	_wp = _unitGroup addWaypoint [[(_position select 0), (_position select 1)], 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 100;

	_drop = True;
	_helipos = getpos _helicopter;

	while {(alive _helicopter) && (_drop)} do {

		private ["_magazine","_weapon","_weapon","_chute","_para","_pgroup"];
		sleep 1;
		_helipos = getpos _helicopter;

		if (_helipos distance [(_position select 0),(_position select 1),100] <= 200) then {

			
				_pgroup	= createGroup EAST;
			

			for "_x" from 1 to _paranumber do {

				_helipos = getpos _helicopter;

				call {
					if (typeName(_gun) == "SCALAR") then {
						if(_gun == 0) 			exitWith { _aiweapon = ai_wep_assault; };
						if(_gun == 1) 			exitWith { _aiweapon = ai_wep_machine; };
						if(_gun == 2) 			exitWith { _aiweapon = ai_wep_sniper; };
					} else {
						if(_gun == "random") 	exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
					};
				};

				_weapon 	= _aiweapon call BIS_fnc_selectRandom;
				_magazine 	= _weapon call find_suitable_ammunition;

				call {
					if (typeName(_gear) == "SCALAR") then {
						if(_gear == 0) 			exitWith { _aigear = ai_gear0; };
						if(_gear == 1) 			exitWith { _aigear = ai_gear1; };
					} else {
						if(_gear == "random") 	exitWith { _aigear = ai_gear_random call BIS_fnc_selectRandom; };
					};
				};

				_gearmagazines 		= _aigear select 0;
				_geartools 			= _aigear select 1;
				
				call {
					if(_backpack == "random") 	exitWith { _aipack = ai_packs call BIS_fnc_selectRandom; };
					if(_backpack == "none") 	exitWith { };
					_aipack = _backpack;
				};
					
				call {
					if(_vest == "random") 	exitWith { _aivest = ai_vests call BIS_fnc_selectRandom; };
					if(_vest == "none") 	exitWith { };
					_aivest = _vest;
				};
					
				call {
					if (_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
					if (_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
					if (_skin == "special") exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
					_aiskin = _skin;
				};

				if(typeName _aiskin == "ARRAY") then {
					_aiskin = _aiskin call BIS_fnc_selectRandom;
				};

				_para = _pgroup createUnit [_aiskin,[0,0,0],[],1,"FORM"];
				_para setVariable["LASTLOGOUT_EPOCH",1000000000000];
				_para setVariable["LAST_CHECK",1000000000000]; 
				
				_para enableAI "TARGET";
				_para enableAI "AUTOTARGET";
				_para enableAI "MOVE";
				_para enableAI "ANIM";
				_para enableAI "FSM";

				removeAllWeapons _para;
				removeAllItems _para;
				
				_para addweapon _weapon;
				
				for "_i" from 1 to _mags do {
					_para addMagazine _magazine;
				};
				
				if(_backpack != "none") then {
					_para addBackpack _aipack;
					_para addItemToBackpack _ai_gear_random;
				};
				
				if(_vest != "none") then {
					_para addvest _aivest;
					_para addItemToVest _ai_gear_random;
				};
				
				{
					_para addMagazine _x
				} count _gearmagazines;
				
				{
					_para addweapon _x
				} count _geartools;
				
				if (sunOrMoon != 1) then {
					_para addweapon "NVG_Epoch";
				};
				
				call {
					if(_skill == "easy") 	exitWith { _aicskill = ai_skill_easy; };
					if(_skill == "medium") 	exitWith { _aicskill = ai_skill_medium; };
					if(_skill == "hard") 	exitWith { _aicskill = ai_skill_hard; };
					if(_skill == "extreme") exitWith { _aicskill = ai_skill_extreme; };
					if(_skill == "random") 	exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
					_aicskill = ai_skill_random call BIS_fnc_selectRandom;
				};
				
				{
					_para setSkill [(_x select 0),(_x select 1)]
				} count _aicskill;
				
				ai_ground_units = (ai_ground_units + 1);
				_para addEventHandler ["Killed",{[_this select 0, _this select 1, "ground"] call on_kill;}];
				_chute = createVehicle ["ParachuteEast", [(_helipos select 0), (_helipos select 1), (_helipos select 2)], [], 0, "NONE"];
				_para moveInDriver _chute;
				[_para] joinSilent _pgroup;
				_pGroup setVariable["LASTLOGOUT_EPOCH",99999999];
				_pgroup setVariable["LAST_CHECK",1000000000000]; 
				_pgroup = objNull; 
				addToRemainsCollector [_para];

				sleep 1.5;
				
				if(!isNil "_mission") then {

					_mission_data = (wai_mission_data select _mission);

					if (typeName _mission_data == "ARRAY") then {
						_ainum = _mission_data select 0;
						wai_mission_data select _mission set [0, (_ainum + 1)];
						_para setVariable ["missionclean", "ground"];
						_para setVariable ["mission", _mission, true];
					};

				};
			};

			call {
				if (_aitype == "Bandit") 	exitWith { { _x setVariable ["Bandit",true,true]; } count (units _pgroup); };
				if (_aitype == "Special") 	exitWith { { _x setVariable ["Special",true,true]; } count (units _pgroup); };
			};
			
			_drop = false;
			_pgroup selectLeader ((units _pgroup) select 0);

			if(debug_mode) then { diag_log format ["WAI: Spawned in %1 ai units for paradrop",_paranumber]; };

			[_pgroup,_position,_skill] call group_waypoints;
			
				if (!isNil "_mission") then {
					[_pgroup, _mission] spawn bandit_behaviour;
				} else {
					[_pgroup] spawn bandit_behaviour;
				};
			
		};
	};

	if (_helipatrol) then {
		
		_wp1 = _unitGroup addWaypoint [[(_position select 0),(_position select 1)], 100];
		_wp1 setWaypointType "SAD";
		_wp1 setWaypointCompletionRadius 150;
		_unitGroup setBehaviour "AWARE";
		_unitGroup setSpeedMode "FULL";

		
			if (!isNil "_mission") then {
				[_unitGroup, _mission] spawn bandit_behaviour;
			} else {
				[_unitGroup] spawn bandit_behaviour;
			};
		

		{
			_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill;}];
		} forEach (units _unitgroup);

	} else {

		{
			_x doMove [(_startingpos select 0), (_startingpos select 1), 100]
		} count (units _unitGroup);
		
		_unitGroup setBehaviour "CARELESS";
		_unitGroup setSpeedMode "FULL";

			if (!isNil "_mission") then {
				[_unitGroup, _mission] spawn bandit_behaviour;
			} else {
				[_unitGroup] spawn bandit_behaviour;
			};
		
		
		_cleanheli = true;

		while {_cleanheli} do {

			sleep 5;
			_helipos1 = getpos _helicopter;

			if ((_helipos1 distance [(_startingpos select 0),(_startingpos select 1),100] <= 200) || (!alive _helicopter)) then {
				
				deleteVehicle _helicopter;
				{
					deleteVehicle _x;
					ai_air_units = (ai_air_units -1);
				} count (units _unitgroup);

				deleteGroup _unitGroup;
				if(debug_mode) then { diag_log "WAI: Paradrop helicopter cleaned"; };
				_cleanheli = false;
			};

		};

	};

};
