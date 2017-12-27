// ===========================================================================
// [IWAC] IBEN WAI AUTOCLAIM >> IBEN_fnc_AC.sqf
// ===========================================================================
// [last update: 2017-10-22]
// ===========================================================================
// created by @iben for WAI, DayZ Epoch 1.0.6.2+
// ===========================================================================

// ---------------------------------------------------------------------------
#include "defines.hpp"

// ---------------------------------------------------------------------------
IBEN_fnc_sortPlrByDist = {
  private ["_ret","_i","_itm","_ixa","_ixx"];
  _ixa = [];
  _ret = [];
  // -------------------------------------------------------------------------
  if ((count _this) < 2) exitWith {
    _ret = [(_this select 0) select 0];
    _ret
  };
  // -------------------------------------------------------------------------
  for "_i" from 0 to ((count _this) - 1) do {
    _itm = (_this select _i);
    _ixa set [count _ixa, (_itm select 1)];
    _ret set [count _ret, 0];
  };
  // -------------------------------------------------------------------------
  _ixa call BIS_fnc_sortNum;
  // -------------------------------------------------------------------------
  {
    _ixx = _ixa find (_x select 1);
    if (_ixx >= 0) then {
      _ret set [_ixx, (_x select 0)];
    };
  } count _this;
  // -------------------------------------------------------------------------
  _ret
};

// ---------------------------------------------------------------------------
IBEN_fnc_clsIndex = {
  private ["_tcl","_ixc","_ret","_i"];
  _tcl = (_this select 0);
  _ixc = (_this select 1);
  // -------------------------------------------------------------------------
  _ret = [];
  // -------------------------------------------------------------------------
  if ((typeName _ixc) != "ARRAY") then {_ixc = [_ixc];};
  // -------------------------------------------------------------------------
  for "_i" from 0 to ((count _tcl) - 1) do {
    if !(_i in _ixc) then {
      _ret set [count _ret, (_tcl select _i)];
    };
  };
  // -------------------------------------------------------------------------
  _ret
};

// ---------------------------------------------------------------------------
IBEN_fnc_clnList = {
  private ["_tcl","_irf","_ixc","_ret","_i","_itm"];
  _tcl = (_this select 0);
  _irf = (_this select 1);
  // -------------------------------------------------------------------------
  _ixc = [];
  _ret = [];
  // -------------------------------------------------------------------------
  if ((count _tcl) == 0) exitWith {_ret};
  // -------------------------------------------------------------------------
  for "_i" from 0 to ((count _tcl) - 1) do {
    _itm = (_tcl select _i);
    if !((_itm select 0) in _irf) then {
      _ixc set [count _ixc, _i];
    };
  };
  // -------------------------------------------------------------------------
  _ret = [_tcl, _ixc] call IBEN_fnc_clsIndex;
  // -------------------------------------------------------------------------
  _ret
};

// ---------------------------------------------------------------------------
IBEN_fnc_checkPlrStatus = {
  private ["_rgc","_ptc","_vtc","_rct","_fnd","_ret","_i","_lst","_lct",
  "_y","_sar","_sei"];
  _rgc = (_this select 0);
  _ptc = (_this select 1);
  _vtc = (_this select 2);
  // -------------------------------------------------------------------------
  if ((typeName _rgc) != "ARRAY") then {_rgc = [_rgc]};
  // -------------------------------------------------------------------------
  _rct = (count _rgc);
  _fnd = false;
  _ret = [-1, []];
  // -------------------------------------------------------------------------
  if (_rct == 0) exitWith {_ret};
  // -------------------------------------------------------------------------
  for "_i" from 0 to (_rct - 1) do {
    if (_fnd) exitWith {_ret};
    _lst = (_rgc select _i);
    _lct = (count _lst);
    // -----------------------------------------------------------------------
    if (_lct > 0) then {
      for "_y" from 0 to (_lct - 1) do {
        _sar = (_lst select _y);
        _sei = (_sar select _vtc);
        if (_ptc == _sei) exitWith {
          _ret = [_i, [_y, _sar]];
          _fnd = true;
        };
      };
    }
  };
  // -------------------------------------------------------------------------
  _ret
};

// ---------------------------------------------------------------------------
IBEN_fnc_createFlag = {
  private ["_cnr","_own","_mss","_nll","_fgp","_fgs","_fgg","_ret"];
  _cnr = (_this select 0);
  _own = (_this select 1);
  _mss = (_this select 2);
  // -------------------------------------------------------------------------
  _nll = [_mss] call IBEN_fnc_deleteFlag;
  // -------------------------------------------------------------------------
  _fgp = [_cnr, 200, iben_wai_ACmarkerRange, 10, 0, 2000, 0] call BIS_fnc_findSafePos;
  _fgs = [];
  _ret = [];
  // -------------------------------------------------------------------------
  if (iben_wai_ACcreateFlagOjb) then {
    _fgg = iben_wai_ACmarkerFlagClass createVehicle [0,0,0];
    dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _fgg];
    _fgg setVariable ["ObjectID", "1", true];
    _fgg setDir 0;
    _fgg setPos _fgp;
    _fgg setVectorUp [0,0,1];
    _fgs set [count _fgs, _fgg];
  };
  // -------------------------------------------------------------------------
  if (iben_wai_ACdevmode && {iben_wai_ACcreateFlagOjb}) then {
    DBG("IBEN_fnc_AC.sqf",FSTR5("Mission ID [%1] was claimed by %2 (%3). Flag created at [%4] >> %5",_mss,(name _own),(getPlayerUID _own),(mapGridPosition _fgp),(str _fgs)));
  };
  // -------------------------------------------------------------------------
  _ret = [_fgp, _fgs];
  _ret
};

// ---------------------------------------------------------------------------
IBEN_fnc_deleteFlag = {
  private ["_mss","_del","_rmv","_i","_fgg"];
  _mss = (_this select 0);
  _del = true;
  // -------------------------------------------------------------------------
  if (!iben_wai_ACcreateFlagOjb) exitWith {_del};
  // -------------------------------------------------------------------------
  _rmv = (((wai_mission_data select _mss) select 4) select 3);
  // -------------------------------------------------------------------------
  if ((count _rmv) == 0) exitWith {_del};

  // -------------------------------------------------------------------------
  for "_i" from 0 to ((count _rmv) - 1) do {
    _fgg = (_rmv select _i);
    call {
      if ((typeName _fgg) == "ARRAY") exitWith {
        {deleteVehicle _x} count _fgg;
      };
      deleteVehicle _fgg;
    };
  };
  // -------------------------------------------------------------------------
  if (iben_wai_ACdevmode) then {
    DBG("IBEN_fnc_AC.sqf",FSTR2("Deleting flag for mission ID [%1]. Flag to delete: [%2]",_mss,(str _rmv)));
  };
  // -------------------------------------------------------------------------
  _del
};

// === :: [IWAC] IBEN WAI AUTOCLAIM >> IBEN_fnc_AC.sqf :: END
