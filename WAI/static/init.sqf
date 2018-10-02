// Do not change this variable. It is used by the static spawns manager.
wai_static_data = [0,[],[],[]]; // [AI Count, UnitGroups, Vehicles to Monitor, Static gun and AI pair]

if(wai_custom_per_world) then {
	ExecVM format["\z\addons\dayz_server\WAI\static\%1.sqf",toLower(worldName)];
} else {
	ExecVM "\z\addons\dayz_server\WAI\static\default.sqf";
};

// Start the monitoring thread
[] spawn static_spawn_manager;

wai_staticloaded = true;
