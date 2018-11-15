 // For Reference: wai_static_data = [0,[],[],[]]; [AI Count, UnitGroups, Vehicles to Monitor, crates]

private ["_unitGroups","_aiVehicles","_staticArray","_timeStamp","_running","_crates"];

_timeStamp = diag_tickTime;
_running = true;

// The loop has to wait until there are existing groups to monitor
// 10 seconds initial sleep to allow crates array to populate
waitUntil {uiSleep 10; (count (wai_static_data select 1)) > 0};

// Spawn loot in crates
_crates = wai_static_data select 3;
if (count _crates > 0) then {
	{
		[(_x select 0),(_x select 1)] call dynamic_crate;
	} count _crates;
};

diag_log "WAI: Initializing static missions";

while {_running} do {

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
	
	// Static gun glitch fix
	if ((diag_tickTime - _timeStamp) > 180 && (count _aiVehicles) > 0) then {
		{
			if (_x isKindOf "StaticWeapon") then {
				(gunner _x) action ["getout",_x];
			};
		} forEach _aiVehicles;
		
		_timeStamp = diag_tickTime;
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