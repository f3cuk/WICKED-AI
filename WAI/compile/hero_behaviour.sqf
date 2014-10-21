private ["_agro","_player","_guarding","_group","_unit","_position"];

_count 			= count _this;
_group			= _this select 0;

_group setCombatMode ai_hero_combatmode;
_group setBehaviour ai_hero_behaviour;

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

			if(debug_mode) then { diag_log format ["Unit:%1 Setting Aggressors:%2", name _unit, _aggressors]; };
		};

		{
			if (((position _x) distance (position _unit)) <= 500) then {
				_aggressors = _x getVariable ["Aggressors", []];
				if !(name _player in _aggressors) then {
					_aggressors set [count _aggressors, name _player];
					_x setVariable ["Aggressors", _aggressors];
					
					if(debug_mode) then { diag_log format ["Shared Unit:%1 Setting Aggressors:%2", name _x, _aggressors]; };
				};
			};
		} count allUnits;				
	}];
} forEach (units _group);

if (ai_friendly_behaviour) then {

	while {({alive _x} count units _group) > 0} do {

		if (!_guarding) then { _position = getPosATL ((units _group) select 0); };
		{
			_player = _x;
			if((isPlayer _player) && ((_player distance _position) <= 1200)) then {

				_agro = name _player in (_x getVariable ["Aggressors", []]);

				if (_player getVariable ["humanity", 0] > player_hero) then {
				
					if ((_player distance _position < 120 && _guarding) || _agro) then {
						_player setCaptive false;
					} else {
						_player setCaptive true;
					};

				};
			};
		} forEach playableUnits;

		sleep 1;
	};
};