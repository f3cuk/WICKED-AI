private ["_rocket","_unarmed","_launcher","_starttodrop","_timebtwdrops","_flyinheight","_distance","_heliStartDir","_start_position","_diag_distance","_rndnum","_mission_data","_pos_x","_pos_y","_ainum","_missionrunning","_aitype","_helipos1","_geartools","_gearmagazines","_cleanheli","_drop","_helipos","_gunner2","_gunner","_player_present","_skillarray","_aicskill","_aiskin","_aigear","_wp","_helipatrol","_gear","_skin","_backpack","_mags","_gun","_triggerdis","_startingpos","_aiweapon","_mission","_heli_class","_aipack","_helicopter","_unitGroup","_pilot","_skill","_paranumber","_position","_wp1"];

if (!wai_enable_paradrops) exitWith {};

_position 		= _this select 0;
_pos_x			= _position select 0;
_pos_y			= _position select 1;
_triggerdis 	= _this select 1;
_heli_class 	= _this select 2;
_heliStartDir	= _this select 3;
_distance		= _this select 4;
_flyinheight	= _this select 5;
_timebtwdrops	= _this select 6;
_starttodrop	= _this select 7;
_paranumber 	= _this select 8;
_skill 			= _this select 9;
_gun 			= _this select 10;
_mags 			= _this select 11;
_backpack 		= _this select 12;
_skin 			= _this select 13;
_gear 			= _this select 14;
_aitype			= _this select 15;
_helipatrol 	= _this select 16;
_aipack 		= "";
_player_present = false;

if (count _this > 17) then {
	_mission = _this select 17;
} else {
	_mission = nil;
};

if (typeName _gun == "ARRAY") then {
	_launcher = _gun select 1;
	_gun = _gun select 0;
};

_aiweapon = [];
_aigear = [];
_aiskin = "";
_aicskill = [];
_skillarray = ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
_unarmed = false;

if(wai_debug_mode) then {diag_log "WAI: Paradrop waiting for player";};


// Wait until a player is within the trigger distance
while {!_player_present} do {
	_player_present = [[_pos_x,_pos_y,0],_triggerdis] call isNearPlayer;
	uiSleep 5;
};

_aiskin = call {
	if (_skin == "random") 	exitWith {ai_all_skin select (floor (random (count ai_all_skin)));};
	if (_skin == "hero") 	exitWith {ai_hero_skin select (floor (random (count ai_hero_skin)));};
	if (_skin == "bandit") 	exitWith {ai_bandit_skin select (floor (random (count ai_bandit_skin)));};
	if (_skin == "special") exitWith {ai_special_skin select (floor (random (count ai_special_skin)));};
	_skin;
};

if(typeName _aiskin == "ARRAY") then {
	_aiskin = _aiskin select (floor (random (count _aiskin)));
};

if(!isNil "_mission") then {
	_missionrunning = (typeName (wai_mission_data select _mission) == "ARRAY");
} else {
	_missionrunning = true;
};

if(!_missionrunning) exitWith {if (wai_debug_mode) then {diag_log format["WAI: Mission at %1 already ended, aborting para drop",_position];};};

if(wai_debug_mode) then {diag_log format ["WAI: Spawning a %1 with %2 units to be para dropped at %3",_heli_class,_paranumber,_position];};

if(_aitype == "Hero") then {
	_unitGroup = createGroup RESISTANCE;
} else {
	_unitGroup = createGroup EAST;
};

_pilot = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
[_pilot] joinSilent _unitGroup;

// This random number is used to start the helicopter a random distance from the mission
_rndnum = (random ((_distance select 1) - (_distance select 0)) + (_distance select 0));

call
{
	if (_heliStartDir == "North") exitWith {_helicopter = createVehicle [_heli_class,[(_position select 0),(_position select 1) + _rndnum,100],[],0,"FLY"];};
	if (_heliStartDir == "South") exitWith {_helicopter = createVehicle [_heli_class,[(_position select 0),(_position select 1) - _rndnum,100],[],0,"FLY"];};
	if (_heliStartDir == "East") exitWith {_helicopter = createVehicle [_heli_class,[(_position select 0) + _rndnum,(_position select 1),100],[],0,"FLY"];};
	if (_heliStartDir == "West") exitWith {_helicopter = createVehicle [_heli_class,[(_position select 0) - _rndnum,(_position select 1),100],[],0,"FLY"];};
};

_start_position = position _helicopter;

if (wai_debug_mode) then {
	_diag_distance = _helicopter distance _position;
	diag_log format["WAI: the Paratrooper Drop has started %1 from the mission",_diag_distance];
};

//_helicopter setFuel 1;
_helicopter engineOn true;
//_helicopter setVehicleAmmo 1;
_helicopter flyInHeight _flyinheight;
_helicopter addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

_pilot assignAsDriver _helicopter;
_pilot moveInDriver _helicopter;

_gunner = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
_gunner assignAsGunner _helicopter;
_gunner moveInTurret [_helicopter,[0]];
[_gunner] joinSilent _unitGroup;

_gunner2 = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
_gunner2 assignAsGunner _helicopter;
_gunner2 moveInTurret [_helicopter,[1]];
[_gunner2] joinSilent _unitGroup;

call {
	if (_aitype == "Hero") 		exitWith {{ _x setVariable ["Hero",true]; _x setVariable ["humanity", ai_add_humanity]; } count [_pilot, _gunner, _gunner2];};
	if (_aitype == "Bandit") 	exitWith {{ _x setVariable ["Bandit",true]; _x setVariable ["humanity", ai_remove_humanity]; } count [_pilot, _gunner, _gunner2];};
	if (_aitype == "Special") 	exitWith {{ _x setVariable ["Special",true]; _x setVariable ["humanity", ai_special_humanity]; } count [_pilot, _gunner, _gunner2];};
};

{
	_pilot setSkill [_x,1]
} count _skillarray;

{
	_gunner 	setSkill [_x,0.7];
	_gunner2 	setSkill [_x,0.7];
} count _skillarray;


{
	_x addWeapon "Makarov_DZ";
	_x addMagazine "8Rnd_9x18_Makarov";
	_x addMagazine "8Rnd_9x18_Makarov";
} count (units _unitgroup);

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_helicopter];

if (!isNil "_mission") then {
	((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _unitGroup];
	((wai_mission_data select _mission) select 4) set [count ((wai_mission_data select _mission) select 4), _helicopter];
} else {
	(wai_static_data select 1) set [count (wai_static_data select 1), _unitGroup];
	(wai_static_data select 2) set [count (wai_static_data select 2), _helicopter];
};

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "CARELESS";
_unitGroup setSpeedMode "FULL";

if(_aitype == "Hero") then {
	_unitGroup setCombatMode ai_hero_combatmode;
	_unitGroup setBehaviour ai_hero_behaviour;
} else {
	_unitGroup setCombatMode ai_bandit_combatmode;
	_unitGroup setBehaviour ai_bandit_behaviour;
};

// Add waypoints to the chopper group.
_wp = _unitGroup addWaypoint [[(_position select 0), (_position select 1)], 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 100;

_drop = true;
//_helipos = getPos _helicopter;

while {(alive _helicopter) && (_drop)} do {
	private ["_magazine","_weapon","_weapon","_chute","_para","_pgroup"];
	uiSleep 1;
	_helipos = getPos _helicopter;

	if (_helipos distance [(_position select 0),(_position select 1),100] <= _starttodrop) then {

		if(_aitype == "Hero") then {
			_pgroup	= createGroup RESISTANCE;
		} else {
			_pgroup	= createGroup EAST;
		};
		
		if (!isNil "_mission") then {
			((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _pgroup];
		} else {
			(wai_static_data select 1) set [count (wai_static_data select 1), _pgroup];
		};

		for "_x" from 1 to _paranumber do {

			_helipos = getPos _helicopter;

			call {
				if(typeName(_gun) == "SCALAR") then {
					if(_gun == 0) exitWith {_aiweapon = ai_wep_random select (floor (random (count ai_wep_random)));};
					if(_gun == 1) exitWith {_aiweapon = ai_wep_machine;};
					if(_gun == 2) exitWith {_aiweapon = ai_wep_sniper;};
				} else {
					if(_gun == "random") exitWith {_aiweapon = ai_wep_random select (floor (random (count ai_wep_random)));};
					if(_gun == "unarmed") exitWith {_unarmed = true;};
					_aiweapon = _gun;
				};
			};

			if (!_unarmed) then {
				_weapon = if (typeName (_aiweapon) == "ARRAY") then {_aiweapon select (floor (random (count _aiweapon)))} else {_aiweapon};
				_magazine = _weapon call find_suitable_ammunition;
			};
			
			_aigear = call {
				if (typeName(_gear) == "SCALAR") then {
					if(_gear == 0) exitWith {ai_gear0;};
					if(_gear == 1) exitWith {ai_gear1;};
					if(_gear == 2) exitWith {ai_gear2;};
					if(_gear == 3) exitWith {ai_gear3;};
					if(_gear == 4) exitWith {ai_gear4;};
				} else {
					if(_gear == "random") exitWith {ai_gear_random select (floor (random (count ai_gear_random)));};
				};
			};

			_gearmagazines = _aigear select 0;
			_geartools = _aigear select 1;
			
			call {
				if(_backpack == "random") exitWith {_aipack = ai_packs select (floor (random (count ai_packs)));};
				if(_backpack == "none") exitWith {};
				_aipack = _backpack;
			};
				
			_aiskin = call {
				if (_skin == "random") 	exitWith {ai_all_skin select (floor (random (count ai_all_skin)));};
				if (_skin == "hero") 	exitWith {ai_hero_skin select (floor (random (count ai_hero_skin)));};
				if (_skin == "bandit") 	exitWith {ai_bandit_skin select (floor (random (count ai_bandit_skin)));};
				if (_skin == "special") exitWith {ai_special_skin select (floor (random (count ai_special_skin)));};
				_skin;
			};

			//if(typeName _aiskin == "ARRAY") then {
				//_aiskin = _aiskin select (floor (random (count _aiskin)));
			//};

			_para = _pgroup createUnit [_aiskin,[0,0,0],[],1,"FORM"];
			
			_para enableAI "TARGET";
			_para enableAI "AUTOTARGET";
			_para enableAI "MOVE";
			_para enableAI "ANIM";
			_para enableAI "FSM";

			removeAllWeapons _para;
			removeAllItems _para;
			
			_para addWeapon _weapon;
			
			for "_i" from 1 to _mags do {
				_para addMagazine _magazine;
			};
			
			if(_backpack != "none") then {
				_para addBackpack _aipack;
			};
			
			{
				_para addMagazine _x
			} count _gearmagazines;
			
			{
				_para addWeapon _x
			} count _geartools;
			
			if (sunOrMoon != 1) then {
				_para addWeapon "NVGoggles";
			};
			
			_aicskill = call {
				if(_skill == "easy") exitWith {ai_skill_easy;};
				if(_skill == "medium") exitWith {ai_skill_medium;};
				if(_skill == "hard") exitWith {ai_skill_hard;};
				if(_skill == "extreme") exitWith {ai_skill_extreme;};
				if(_skill == "random") exitWith {ai_skill_random select (floor (random (count ai_skill_random)));};
				ai_skill_random select (floor (random (count ai_skill_random)));
			};
			
			{
				_para setSkill [(_x select 0),(_x select 1)]
			} count _aicskill;
			
			_para addEventHandler ["Killed",{[_this select 0, _this select 1] call on_kill;}];
			_chute = createVehicle ["ParachuteWest", [(_helipos select 0), (_helipos select 1), (_helipos select 2)], [], 0, "NONE"];
			_para moveInDriver _chute;
			[_para] joinSilent _pgroup;
			
			// Adjusting this number changes the spread of the AI para drops
			uiSleep _timebtwdrops;
			
			if(!isNil "_mission") then {
				_mission_data = (wai_mission_data select _mission);

				if (typeName _mission_data == "ARRAY") then {
					_ainum = _mission_data select 0;
					wai_mission_data select _mission set [0, (_ainum + 1)];
					_para setVariable ["mission", _mission, true];
				};
			} else {
				wai_static_data set [0, ((wai_static_data select 0) + 1)];
			};
		};
		
		if (!isNil "_launcher" && wai_use_launchers) then {
			call {
				//if (_launcher == "Random") exitWith { _launcher = (ai_launchers_AT + ai_launchers_AA) call BIS_fnc_selectRandom; };
				if (_launcher == "at") exitWith {_launcher = ai_wep_launchers_AT select (floor (random (count ai_wep_launchers_AT)));};
				if (_launcher == "aa") exitWith {_launcher = ai_wep_launchers_AA select (floor (random (count ai_wep_launchers_AA)));};
			};
			_rocket = _launcher call find_suitable_ammunition;
			_para addMagazine _rocket;
			_para addMagazine _rocket;
			_para addWeapon _launcher;
		};

		call {
			if (_aitype == "Hero") exitWith {{_x setVariable ["Hero",true,true];} count (units _pgroup);};
			if (_aitype == "Bandit") exitWith {{_x setVariable ["Bandit",true,true];} count (units _pgroup);};
			if (_aitype == "Special") exitWith {{_x setVariable ["Special",true,true];} count (units _pgroup);};
		};
		
		_drop = false;
		_pgroup selectLeader ((units _pgroup) select 0);

		if(wai_debug_mode) then {diag_log format ["WAI: Spawned in %1 ai units for paradrop",_paranumber];};

		[_pgroup,_position,_skill] call group_waypoints;
		
		if(_aitype == "Hero") then {
			_pgroup setCombatMode ai_hero_combatmode;
			_pgroup setBehaviour ai_hero_behaviour;
		} else {
			_pgroup setCombatMode ai_bandit_combatmode;
			_pgroup setBehaviour ai_bandit_behaviour;
		};
	};
};

if (_helipatrol) then { 
	
	_wp1 = _unitGroup addWaypoint [[(_position select 0),(_position select 1)], 100];
	_wp1 setWaypointType "SAD";
	_wp1 setWaypointCompletionRadius 150;
	_unitGroup setBehaviour "AWARE";
	_unitGroup setSpeedMode "FULL";
	
	{
		_x addEventHandler ["Killed",{[_this select 0, _this select 1] call on_kill;}];
	} forEach (units _unitgroup);

} else {

	{
		_x doMove [(_start_position select 0), (_start_position select 1), 100]
	} count (units _unitGroup);
	
	_unitGroup setBehaviour "CARELESS";
	_unitGroup setSpeedMode "FULL";

	_cleanheli = true;
	
	while {_cleanheli} do {

		uiSleep 5;
		_helipos1 = getPos _helicopter;
		
		if ((_helipos1 distance [(_start_position select 0),(_start_position select 1),100] <= 2000) || (!alive _helicopter)) then {
			
			deleteVehicle _helicopter;
			{
				deleteVehicle _x;
			} count (units _unitgroup);

			deleteGroup _unitGroup;
			if(wai_debug_mode) then { diag_log "WAI: Paradrop helicopter cleaned"; };
			_cleanheli = false;
		};

	};
	
};
