private ["_missionType","_messages","_aiType","_mission","_rndnum","_vehname","_position","_vehclass","_plane","_startArray","_startPos","_dropzone","_aigroup","_pilot","_wp","_complete","_timeout","_vehDropped","_vehicle","_parachute","_missionType","_color"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

// Plane
_airClass = ["C130J_US_EP1_DZ","MV22_DZ"] call BIS_fnc_selectRandom;
_airName = getText (configFile >> "CfgVehicles" >> _airClass >> "displayName");

diag_log format["WAI: [Mission:[%3] %1 Vehicle Drop]: Starting... %2",_airName,_position,_missionType];

//Troops
[_position,5,"Medium",["Random","AT"],3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

if(wai_debug_mode) then {
	diag_log format["WAI: [%3] %1 Vehicle Drop spawned a %2",_airName_vehname,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	[["STR_CL_HERO_AIRDROP_ANNOUNCE",_airName,_vehname],["STR_CL_HERO_AIRDROP_CRASH",_airName],["STR_CL_HERO_AIRDROP_DROP",_vehname],["STR_CL_HERO_AIRDROP_WIN",_vehname],["STR_CL_HERO_AIRDROP_FAIL",_vehname]];
} else {
	[["STR_CL_BANDIT_AIRDROP_ANNOUNCE",_airName,_vehname],["STR_CL_BANDIT_AIRDROP_CRASH",_airName],["STR_CL_BANDIT_AIRDROP_DROP",_vehname],["STR_CL_BANDIT_AIRDROP_WIN",_vehname],["STR_CL_BANDIT_AIRDROP_FAIL",_vehname]];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["%1 Air Drop",_airName], // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_airClass, // Class of plane to deliver the vehicle
	_vehclass, // Class of vehicle to air drop
	_messages
] call wai_air_drop;