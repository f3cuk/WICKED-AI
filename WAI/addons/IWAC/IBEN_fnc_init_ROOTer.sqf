// ===========================================================================
// [IWAC] IBEN WAI AUTOCLAIM >> IBEN_fnc_init_ROOTer.sqf
// ===========================================================================
// [last update: 2017-10-22]
// ===========================================================================
// created by @iben for WAI, DayZ Epoch 1.0.6.2+
// ===========================================================================
// ...
// ===========================================================================
// FUNCTIONS LIBRARY >> PATH MANIPULATION >> IBEN_fnc_init_ROOTer.sqf
// ===========================================================================
// @Function name: IBEN_fnc_init_ROOTer
// ===========================================================================
// @Info:
//  - Created by @iben for DayzEpoch 1.0.6.2+
//  - Version: 1.1, Last Update [2017-09-07]
//  - Credits:
//   * DayZ Epoch developers, collaborators and contributors
//     (thank you guys for your excellent work!)
//   * @Karel Moricky from Bohemia Interactive for his idea how to extract
//     mission root.
// @Remarks:
//  - This is 'init' version of ROOTer with no dependecies. It's desing
//    to be used during lib init phase only. For your plugins use standard
//    fnc call: 'IBEN_fnc_base_ROOTer'
//  - For whole description what fnc can do see 'fnc_base_ROOTer'
// @Parameters:
//  All paramters are mandatory!
//  - _ID (caller ID): Custom string to help identify script
//    calling 'IBEN_fnc_paramCheck' in RPT log                       | string
//  - current file (use __FILE__ macro)                              | string
//  - used on server (isServer : true/false)                         | boolean
//  - zero based (true == "\", false == "" at the end of path)       | boolean
// @Prerequisities:
//  - none
// @Example:
//  - Using in lib 'init.sqf' file:
//    _IBEN_fnc_base_ROOTer = { #include "paths\fnc_init_ROOTer.sqf" };
//    _root = ["Lib init",__FILE__,false,false] call _IBEN_fnc_init_ROOTer;
// @Returns:
//  - string
// ===========================================================================

IBEN_fnc_init_ROOTer = {

  // -------------------------------------------------------------------------
  #include "defines.hpp"

  // -------------------------------------------------------------------------
  private ["_cid","_msg","_ret"];
  _cid = (_this select 0);
  _msg = "";
  _ret = "";

  // -------------------------------------------------------------------------
  call {
    // -----------------------------------------------------------------------
    if ((count _this) != 4) exitWith {
      _msg = FSTR1("Expected 4 params ['STRING','STRING','BOOL','BOOL'], received >> [%1] params",(count _this));
      _ret = nil;
    };

    // -----------------------------------------------------------------------
    if (((typeName (_this select 0)) != "STRING") && {(typeName (_this select 1)) != "STRING"}) exitWith {
      _msg = FSTR2("The first and second parameter is expected to be a ['STRING','STRING'], received >> [%1,%2]",(typeName (_this select 0)),(typeName (_this select 1)));
      _ret = nil;
    };

    // -----------------------------------------------------------------------
    if (((typeName (_this select 2) != "BOOL")) || {(typeName (_this select 3)) != "BOOL"}) exitWith {
       _msg = FSTR2("The second and third parameter are expected to be a [BOOL,BOOL], received >> [%1,%2]",(typeName (_this select 2)),(typeName (_this select 3)));
      _ret = nil;
    };

    // -----------------------------------------------------------------------
    if ((_this select 2) && {!isServer}) exitWith {
      _msg = "Your third parameter 'isServer' was set to true, but you're calling fnc from client! Compile this function in your 'dayz_server' folder and call it from that space...";
      _ret = nil;
    };

    // -----------------------------------------------------------------------
    _ret
  };

  // -------------------------------------------------------------------------
  if (isNil "_ret") exitWith {
    DBG(_cid,FSTR1("ERROR! >> [%1]",_msg));
  };

  // -------------------------------------------------------------------------
  private ["_fil","_far","_end"];
  _fil = toArray (_this select 1);
  _far = [];
  _end = ((count _fil) - 1);

  call {
    if (_this select 2) exitWith {
      private "_i";
      for "_i" from _end to 0 step -1 do {
        _far set [count _far, (toString [_fil select _i])];
      };
    };

    private "_vpc";
    _vpc = ((count (toArray (str missionConfigFile))) - (count (toArray "description.ext")));

    private "_x";
    for "_x" from _end to _vpc step -1 do {
      _far set [count _far, (toString [_fil select _x])];
    };
  };

  // -------------------------------------------------------------------------
  private "_bsp";
  _bsp = _far find "\";
  if (_bsp < 0) exitWith {
    #ifdef __ROOTDBG__
      DBG(_cid,FSTR1("Path export refused! You are already loading file >> [%1] from root >> you don't need to use this function...",(_this select 1)));
    #endif
    _ret = nil;
    _ret
  };

  // -------------------------------------------------------------------------
  _bsp = [_bsp + 1,_bsp] select (_this select 3);

  // -------------------------------------------------------------------------
  private ["_osp","_y"];
  _osp = ((count _far) - 1);
  for "_y" from _osp to _bsp step -1 do {
    _ret = format ["%1%2",_ret,(_far select _y)];
  };

  // -------------------------------------------------------------------------
  #ifdef __ROOTDBG__
    DBG(_cid,FSTR1("Addon relative root >> [%1]",_ret));
  #endif

  // -------------------------------------------------------------------------
  _ret

};

// === :: FUNCTIONS LIBRARY >> PATH MANIPULATION >> IBEN_fnc_init_ROOTer.sqf :: END
