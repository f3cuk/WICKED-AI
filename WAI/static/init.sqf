if(wai_custom_per_world) then {
	ExecVM format["\z\addons\dayz_server\WAI\static\%1.sqf",toLower(worldName)];
} else {
	ExecVM "\z\addons\dayz_server\WAI\static\default.sqf";
};

[] spawn static_spawn_manager;

wai_staticloaded = true;
