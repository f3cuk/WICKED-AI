private ["_rockets","_launcher","_type","_skin","_gain","_mission","_ainum","_unit","_player","_humanity","_banditkills","_humankills","_humanitygain","_cash"];

_unit 		= _this select 0;
_player 	= _this select 1;
//_type 		= _this select 2;
_launcher 	= secondaryWeapon _unit;

_mission = _unit getVariable ["mission", nil];
	
if (!isNil "_mission") then {
	if (typeName(wai_mission_data select _mission) == "ARRAY") then {
		wai_mission_data select _mission set [0, ((wai_mission_data select _mission) select 0) - 1];
	};
} else {
	wai_static_data set [0, ((wai_static_data select 0) - 1)];
};

_unit setVariable ["bodyName","mission_ai",false]; //Only needed on server to prevent immediate cleanup in sched_corpses.sqf

if (ai_hasMoney && Z_singleCurrency) then {
	_cash = round(random ai_moneyMultiplier) * 50;
	_unit setVariable[Z_MoneyVariable,_cash ,true];
};

if(ai_add_skin) then {
	_skin = (typeOf _unit);
	_skin = "Skin_" + _skin;

	if (isClass (configFile >> "CfgMagazines" >> _skin)) then {
		[_unit,_skin] call BIS_fnc_invAdd;
	};
};

if (isPlayer _player) then {

	private ["_banditkills","_humanity","_humankills"];
	
	if (ai_reward_veh_gunner) then {
		_player = (effectiveCommander vehicle _player);
	};
	
	if (ai_killfeed && ai_humanity_gain) then {
		_aitype = if (_unit getVariable ["Hero", false]) then {"Hero";} else {"Bandit";};
		_humanityReward = if (_aitype == "Hero") then {format["-%1 Humanity",ai_remove_humanity];} else {format["+%1 Humanity",ai_add_humanity];};
		_aiColor = if (_aitype == "Hero") then {"#3333ff";} else {"#ff0000";};
		_params = [_aiColor,"0.50","#FFFFFF",-.4,.2,2,0.5];
		
		RemoteMessage = ["ai_killfeed", [_aitype," AI Kill",_humanityReward],_params];
		(owner _player) publicVariableClient "RemoteMessage";
	};

	_humanity 		= _player getVariable["humanity",0];
	_banditkills 	= _player getVariable["banditKills",0];
	_humankills 	= _player getVariable["humanKills",0];

	if (ai_humanity_gain) then {
		_gain = _unit getVariable ["humanity", 0];
		call {
			if (_unit getVariable ["Hero", false]) exitWith { _player setVariable ["humanity",(_humanity - _gain),true]; };
			if (_unit getVariable ["Bandit", false]) exitWith { _player setVariable ["humanity",(_humanity + _gain),true]; };					
			if (_unit getVariable ["Special", false]) exitWith { if (_humanity < 0) then { _player setVariable ["humanity",(_humanity - _gain),true]; } else { _player setVariable ["humanity",(_humanity + _gain),true]; }; };
		};
	};

	if (ai_kills_gain) then {
		if (_unit getVariable ["Hero", false]) then {
			_player setVariable ["humanKills",(_humankills + 1),true];
		} else {
			_player setVariable ["banditKills",(_banditkills + 1),true];
		};
	};

	if (ai_clear_body) then {
		{_unit removeMagazine _x;} count (magazines _unit);
		{_unit removeWeapon _x;} count (weapons _unit);
	};

	if (ai_share_info) then {
		{
			if (((position _x) distance (position _unit)) <= ai_share_distance) then {
				_x reveal [_player, 4.0];
			};
		} count allUnits;
	};

} else {

	if (ai_clean_roadkill) then {

		removeBackpack _unit;
		removeAllWeapons _unit;

		{
			_unit removeMagazine _x
		} count magazines _unit;

	} else {

		if ((random 100) <= ai_rk_damageweapon) then {

			removeAllWeapons _unit;
			
		};

	};

};

if(wai_remove_launcher && _launcher != "") then {

	_rockets = _launcher call find_suitable_ammunition;
	_unit removeWeapon _launcher;
	
	{
		if(_x == _rockets) then {
			_unit removeMagazine _x;
		};
	} count magazines _unit;
	
};

if(_unit hasWeapon "NVGoggles" && floor(random 100) < 20) then {
	_unit removeWeapon "NVGoggles";
};
