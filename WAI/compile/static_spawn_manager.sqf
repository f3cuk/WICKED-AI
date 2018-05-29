 // For Reference: wai_static_data = [0,[],[],[]]; [AI Count, UnitGroups, Vehicles to Monitor, Static gun and AI pair]

private ["_unitGroups","_aiVehicles","_staticArray","_timeStamp","_running"];

_timeStamp = diag_tickTime;
_running = true;

// The loop has to wait until there are existing groups to monitor
waitUntil {uiSleep 1; (count (wai_static_data select 1)) > 0};

diag_log "WAI: Initializing static missions";

while {_running} do {
	
	// Invisible Static Gun Glitch Fix - Runs every 3 minutes - "GetOut" EventHandler forces the AI back onto the static gun immediately.
	_staticArray = wai_static_data select 3;
	if ((diag_tickTime - _timeStamp) > 180 && (count _staticArray) > 0) then {
		{
			if (typeName _x == "ARRAY") then {
				private ["_unit","_gun"];
				_unit = _x select 0;
				_gun = _x select 1;
				{
					_unit action ["getOut", _gun];
				} count _x;
			};
		} forEach _staticArray;
		_timeStamp = diag_tickTime;
	};

	// Refuel and Rearm the AI vehicles until they are destroyed
	_aiVehicles = wai_static_data select 2;
	if(count _aiVehicles > 0) then {
		{
			if (alive _x && ({alive _x} count crew _x > 0)) then {
				_x setVehicleAmmo 1;
				_x setFuel 1;
			} else {_x setDamage 1;};
		} count _aiVehicles;
	};
	
	_unitGroups = wai_static_data select 1;
	{
		// delete empty groups
		if (count units _x == 0) then {
			deleteGroup _x
		};
		// remove null groups from the array
		if (isNull _x) then {
			_unitGroups = _unitGroups - [_x];
		};
		} forEach _unitGroups;
	
	//diag_log _unitGroups; // Used for testing
	
	// When all null groups have been removed from the array, shut the loop down
	if (count _unitGroups == 0) then {_running = false;};
	
	uiSleep 5;
};

diag_log "WAI: All Static Spawns have been killed.";