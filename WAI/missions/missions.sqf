if(isServer) then {

	diag_log "WAI: Starting AI Missions Moniter";

	markerready 			= true;
	missionrunning 			= false;
	_startTime 				= floor(time);
	_result 				= 0;

	while {true} do
	{
		_cnt 		= {alive _x} count playableUnits;
		_currTime 	= floor(time);

		if((_currTime - _startTime >= wai_mission_timer) && (!missionrunning)) then {
			_result = 1
		};
		
		if(missionrunning) then {
			_startTime = floor(time);
		};
		
		if((_result == 1) && (_cnt >= 1) && (markerready)) then {

			clean_running_mission = false;

			_mission 		= wai_missions call BIS_fnc_selectRandom;

			execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_mission];

			missionrunning 	= true;
			_startTime 		= floor(time);
			_result 		= 0;

			diag_log format["WAI: Starting mission %1",_mission];

		} else {

			sleep 60;

		};    
	};
};
