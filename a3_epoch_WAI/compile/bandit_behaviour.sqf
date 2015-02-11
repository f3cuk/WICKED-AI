private ["_agro","_player","_guarding","_group","_unit","_position"];

_count 			= count _this;
_group			= _this select 0;

_group setCombatMode ai_bandit_combatmode;
_group setBehaviour ai_bandit_behaviour;

_guarding = false;

if (count _this > 1) then {
	_guarding = true;	
	_mission = _this select 1;
	_position = wai_mission_data select _mission select 3;
};

{
	_x setVariable ["Aggressors", []];
	_x addEventHandler ["Hit", {
		private ["_unit","_player","_aggressors"];
		_unit 		= _this select 0;
		_player 	= _this select 1;
		_aggressors = _unit getVariable ["Aggressors", []];

		if !(name _player in _aggressors) then {
			_aggressors set [count _aggressors, name _player];
			_unit setVariable ["Aggressors", _aggressors];

			if(debug_mode) then { diag_log format ["WAI: Unit:%1 Setting Aggressors:%2", name _unit, _aggressors]; };
		};

		{
			if (((position _x) distance (position _unit)) <= 500) then {
				_aggressors = _x getVariable ["Aggressors", []];
				if !(name _player in _aggressors) then {
					_aggressors set [count _aggressors, name _player];
					_x setVariable ["Aggressors", _aggressors];
					
					if(debug_mode) then { diag_log format ["WAI: Shared Unit:%1 Setting Aggressors:%2", name _x, _aggressors]; };
				};
			};
		} count allUnits;				
	}];
} forEach (units _group);