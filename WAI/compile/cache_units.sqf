/**
Please take my Special Thanks,
- RimBlock ( http://epochmod.com/...12612-rimblock/) ***
- MGM ( http://epochmod.com/...user/16852-mgm/ )
- Gr8 ( http://epochmod.com/...user/15884-gr8/ )
- halvhjearne ( http://epochmod.com/...11-halvhjearne/) PS: God sake, that name is hard to write!
Author: Martin ( http://epochmod.com/...30755-ukmartin/ )
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 1 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/
private ["_unitGroup","_state","_stateFroze","_timeFroze","_matchingObjectsArray","_numberOfMatchingObjectsNumber","_playerPresent","_playerName"];
_unitGroup = _this select 0;
/**
fnc_freeze: Used to Freeze the Units of the Group
Parameters: Unit Group (Type: Object / Group)
Behaviour: For Each Unit of the given Group the AI will be disabled (force them to freeze)
Addition: Set's a Variable with the time the AI is frozen and the state
**/
fnc_freeze = {
private ["_unitGroup","_nic"];
_unitGroup = _this select 0;

if (ai_cache_units_freeze_log) then {
  diag_log(format["[DEBUG] Freezing Units of Group: %1", _unitGroup]);
};

{
  if(alive _x) then {
   _x disableAI "TARGET";
   sleep 0.05;
   _x disableAI "AUTOTARGET";
   sleep 0.05;
   _x disableAI "MOVE";
   sleep 0.05;
   _x disableAI "ANIM";
   sleep 0.05;
   if (ai_cache_units_unassign_waypoints) then {
    _x disableAI "FSM";
    sleep 0.05;
   };

   if (ai_cache_unites_hide_ai) then {
    //_x hideObjectGlobal true;
    _nic = [nil, _x, "per", rHideObject, true ] call RE;
   };
  };

} foreach units _unitGroup;

_unitGroup setVariable["FrozenState",[time,true],true];
};
/**
fnc_unfreeze: Used to Unfreeze the Units of the Group
Parameters: Unit Group (Type: Object / Group)
Behaviour: For Each Unit of the given Group the AI will be enabled
Addition: Set's a Variable with the time the AI is Unfrozen and the state
**/
fnc_unfreeze = {
private ["_unitGroup","_posX","_posY","_posZ","_pos","_nic"];
_unitGroup = _this select 0;

if (ai_cache_units_freeze_log) then {
  diag_log(format["[DEBUG] Un-Freezing Units of Group: %1", _unitGroup]);
};

{
  _x enableAI "TARGET";
  sleep 0.05;
  _x enableAI "AUTOTARGET";
  sleep 0.05;
  _x enableAI "MOVE";
  sleep 0.05;
  _x enableAI "ANIM";
  sleep 0.05;

  if (ai_cache_units_unassign_waypoints) then {
   _x enableAI "FSM";
   sleep 0.05;
  };

  if (ai_cache_units_randomize_position) then {
   _pos = getPos _x;
   _posX = _pos select 0;
   _posY = _pos select 1;
   _posZ = _pos select 2;
   _posX = _posX + round(random ai_cache_units_randomize_distance);
   _posY = _posY + round(random ai_cache_units_randomize_distance);
   sleep 0.05;
   _x setPos [_posX,_posY,_posZ];
   sleep 0.05;
  };

  if (ai_cache_unites_hide_ai) then {
   //_x hideObjectGlobal false;
   _nic = [nil, _x, "per", rHideObject, false ] call RE;
  };

} foreach units _unitGroup;

_unitGroup setVariable["FrozenState",[time,false],true];
};
//Call the Freeze Function, in Order to make the Units freeze
[_unitGroup] spawn fnc_freeze;
/**
While {true}: Infinite Loop, that runs every 15 Seconds
Parameters: None
Behaviour: Counts nearby Units, if it found a Unit it will check if the Unit is a Player
Behaviour: If the Unit is a Player, the Frozen Group will be defrosted.
Behaviour: If there is no Player near that Group for ai_cache_units_refreeze the AI will be frozen again
Addition: None
**/
while {true} do {
_matchingObjectsArray = ((units _unitGroup) select 0) nearEntities ["CAManBase",ai_cache_units_reactivation_range];
if(!isnil "_matchingObjectsArray") then {
  _numberOfMatchingObjectsNumber = (count _matchingObjectsArray);
  if (_numberOfMatchingObjectsNumber >= 1) then {
   _state = _unitGroup getVariable["FrozenState",[time,true]];
   _timeFroze = _state select 0;
   _stateFroze = _state select 1;
   _playerPresent = false;
   _playerName = "";
   {
    if(isPlayer _x) exitWith {
     _playerPresent = true;
     _playerName = _x;
    };
   } foreach _matchingObjectsArray;
   if (_stateFroze) then {
    if (_playerPresent) then {
     if (ai_cache_units_freeze_log) then {
      diag_log(format["[DEBUG] %1 Triggered Un-Freezing of Group: %2", _playerName, _unitGroup]);
     };
     [_unitGroup] spawn fnc_unfreeze;
    };
   } else {
    if (!_playerPresent && ((time - _timeFroze) > ai_cache_units_refreeze)) then {
     if (ai_cache_units_freeze_log) then {
      diag_log(format["[DEBUG] Re-Freezing Group: %1", _unitGroup]);
     };
     [_unitGroup] spawn fnc_freeze;
    };
   };
  };
};
sleep 15;
};
