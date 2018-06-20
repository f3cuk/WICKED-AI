private ["_mission","_vehname","_vehicle","_position","_vehclass","_pos_location"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_pos_location = [
	["Novy Sobor",[7241.4976,7648.4932,0]],
	["Stary",[5895.0854,7570.7578,0]],
	["Kabanino",[5453.7563,8662.6357,0]],
	["NW Airfield",[3987.6572,10942.339,0]],
	["Vybor",[3583.8069,9078.5537,0]],
	["Lopatino",[2682.1799,10123.949,0]],
	["Grishino",[5966.9585,10444.942,0]],
	["Gorka",[9807.5322,8840.7422,0]],
	["Dubrovka",[10449.702,9976.0967,0]],
	["Gvozdno",[8788.3896,11907.063,0]],
	["Krasnostav",[11184.59,12500.909,0]],
	["NE Airfield",[12376.249,12952.411,0]],
	["Khelm",[12240.857,10797.532,0]],
	["Berezino",[12769.499,10301.438,0]],
	["Solnichy",[13400.513,5934.5991,0]],
	["Kamyshovo",[11840.537,3483.9954,0]],
	["Elektro",[10425.579,1966.2021,0]],
	["Cherno",[6341.3887,2232.4539,0]],
	["Komarovo",[3749.9807,2467.9385,0]],
	["Kamenka",[1785.4771,2290.7263,0]],
	["Pavlovo",[1767.4417,3914.0159,0]],
	["Bor",[3426.9836,4016.2637,0]],
	["Kozlovka",[4567.1548,4740.3633,0]],
	["Vyshnoye",[6587.3208,5951.8965,0]],
	["Guglovo",[8355.2842,6836.0762,0]],
	["Shakhovka",[9616.1328,6627.564,0]],
	["Dolina",[11443.381,6603.4316,0]],
	["Orlovets",[12311.448,7406.1934,0]],
	["Petrovka",[4980.1709,12585.573,0]],
	["Devil's Castle",[6935.2354,11316.347,0]],
	["Zelenogorsk",[2494.5994,5502.605,0]],
	["Staroye",[10172.027,5234.0571,0]],
	["Pogorevka",[4436.9727,6231.6567,0]],
	["Pustoshska",[3019.0378,8079.4951,0]]
];

_location = _pos_location call BIS_fnc_selectRandom;
_position = (_location select 1);

diag_log format["WAI: [Mission:[Bandit] Patrol]: Starting... %1",_position];

//Spawn units
_units = [[_position select 0,_position select 1,0.1],3,"Hard","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;

uiSleep 3; // Let the AI list populate

//Spawn vehicles - since there is no crate, the vehicle is used for the first element in the array for key generation.
_vehicle = [_vehclass,_vehclass,_position,_mission] call custom_publish;

// load the guns
[_vehicle,_vehclass] call load_ammo;

//Setup patrol
[_vehicle,_position,_units,_pos_location,3] call patrol;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] patrol spawned a %1",_vehname];
};

// Array of mission variables to send
[
	_mission,
	_position, // Position of mission
	"Medium", // Difficulty
	format["Patrol %1",_vehname], // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	false, // show mission marker?
	false, // make minefields available for this mission
	_vehicle, // the loot will be spawned in the vehicle
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[], // cleanup objects
	format["STR_BANDIT_PATROL_ANNOUNCE",(_location select 0)], // mission announcement
	"STR_BANDIT_PATROL_WIN", // mission success
	"STR_BANDIT_PATROL_FAIL", // mission fail
	[3,0,[2,crate_items_high_value],0,2] // Dynamic crate array
] call mission_winorfail;