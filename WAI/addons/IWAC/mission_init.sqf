// ===========================================================================
// [IWAC] IBEN WAI AUTOCLAIM >> mission_init.sqf
// ===========================================================================
// [last update: 2017-10-22]
// ===========================================================================
// Extended for IWAC by @iben for WAI, DayZ Epoch 1.0.6.2+
// ===========================================================================
// :: Original source: 'dayz_server\WAI\compile\mission_init.sqf'
// ===========================================================================
if (isServer) then {
  private ["_mines","_difficulty","_mission","_type","_color","_dot","_position","_marker","_name","_show_marker"];
  _mission = _this select 0;
  _position = _this select 1;
  _difficulty = _this select 2;
  _name = _this select 3;
  _type = _this select 4;
  _mines = _this select 5;
  if(count _this > 6) then {
    _show_marker = _this select 6;
  } else {
    _show_marker = true;
  };
  if(debug_mode) then { diag_log("WAI: Starting Mission number " + str(_mission)); };
  wai_mission_data select _mission set [1, _type];
  wai_mission_data select _mission set [3, _position];

  if(wai_enable_minefield && _mines) then {
    call {
      if(_difficulty == "easy") exitWith {_mines = [_position,20,37,20] call minefield;};
      if(_difficulty == "medium") exitWith {_mines = [_position,35,52,50] call minefield;};
      if(_difficulty == "hard") exitWith {_mines = [_position,50,75,100] call minefield;};
      if(_difficulty == "extreme") exitWith {_mines = [_position,60,90,150] call minefield;};
    };
    wai_mission_data select _mission set [2, _mines];
  };

  _marker = "";
  _dot = "";
  _color = "";
  // -------------------------------------------------------------------------
  private ["_mrs","_mrb"];
  _mrs = "";
  _mrb = "";
  // -------------------------------------------------------------------------

  call {
    if(_difficulty == "easy") exitWith {_color = "ColorGreen"};
    if(_difficulty == "medium") exitWith {_color = "ColorYellow"};
    if(_difficulty == "hard") exitWith {_color = "ColorRed"};
    if(_difficulty == "extreme") exitWith {_color = "ColorBlack"};
    _color = _difficulty;
  };
  call {
    if(_type == "mainhero") exitWith { _name = "[Bandits] " + _name; };
    if(_type == "mainbandit") exitWith { _name = "[Heroes] " + _name; };
    if(_type == "special") exitWith { _name = "[Special] " + _name; };
  };

  // -------------------------------------------------------------------------
  // :: _show_marker setting is applied on claimer marker
  if(_show_marker) then {
  // -------------------------------------------------------------------------
  #include "defines.hpp"
  // -------------------------------------------------------------------------
    [_position, _color, _name, _mission] spawn {
      private["_position","_color","_name","_running","_mission","_type",
      "_marker","_dot","_text","_airemain","_mar","_car","_cia","_hsc",
      "_cif","_fgp","_mrs","_mrb"];
      _position = _this select 0;
      _color = _this select 1;
      _name = _this select 2;
      _mission = _this select 3;
      _running = true;
      // ---------------------------------------------------------------------
      while {_running} do {
        // -------------------------------------------------------------------
        if (ai_show_remaining) then {
          _airemain = (wai_mission_data select _mission) select 0;
          _text = format["%1 [%2 Remaining]",_name,_airemain];
          } else {_text = _name};
        // -------------------------------------------------------------------
        
        _mar = WMD(_mission); 
        _car = (_mar select 4);
        _cia = (_car select 1);
        // -------------------------------------------------------------------
        _type = (_mar select 1);
        // -------------------------------------------------------------------
        _hsc = (_car select 0);
        if (_hsc) then {
          _cif = (format ["%1%2",(_cia select 0), (_cia select 1)]);
          _fgp = (_car select 2);
        };
        // -------------------------------------------------------------------
        _marker = createMarker [(format["%1%2",_type,_mission]),_position];
        _marker setMarkerColor _color;
        _marker setMarkerShape "ELLIPSE";
        _marker setMarkerBrush "Solid";
        _marker setMarkerSize [300,300];
        _marker setMarkerText _text;

        _dot = createMarker [(format["%1%2dot",_type,_mission]),_position];
        _dot setMarkerColor "ColorBlack";
        _dot setMarkerType "mil_dot";
        _dot setMarkerText _text;

        // -------------------------------------------------------------------
        if (iben_wai_ACzoneActivate) then {
          _mrb = createMarker [(format["%1%2zbr",_type,_mission]),_position];
          _mrb setMarkerShape "ELLIPSE";
          _mrb setMarkerBrush "Border";
          _mrb setMarkerColor iben_wai_ACzoneMarkerColor;
          _mrb setMarkerSize [iben_wai_ACdistance, iben_wai_ACdistance];
        };

        // -------------------------------------------------------------------
        if (_hsc) then {
          _mrs = createMarker [(format["%1%2%3",_type,_mission,(floor random 100000)]),_fgp];
          _mrs setMarkerShape "ICON";
          _mrs setMarkerType iben_wai_ACmarkerType;
          _mrs setMarkerColor iben_wai_ACmarkerColor;
          _mrs setMarkerText _cif;
        };
        // -------------------------------------------------------------------
        uiSleep 1;
        deleteMarker _marker;
        deleteMarker _dot;
        // -------------------------------------------------------------------
        if (!isNil "_mrb") then {deleteMarker _mrb;};
        if (!isNil "_mrs") then {deleteMarker _mrs;};
        // -------------------------------------------------------------------
        _running = (typeName (wai_mission_data select _mission) == "ARRAY");
      };
    };
  };
  if(debug_mode) then { diag_log("WAI: Mission Data: " + str(wai_mission_data)); };
  // -------------------------------------------------------------------------
  if (iben_wai_ACdevmode) then {
    private ["_mic","_mai","_x"];
    _mic = (count wai_mission_data);
    for "_x" from 0 to (_mic - 1) do {
      _mai = (wai_mission_data select _x);
      if ((typeName _mai) == "ARRAY") then {
        DBG("mission_init.sqf",(FSTR2("AUTOCLAIM ARRAY [%1] >> %2",_x,(_mai select 4))));
      };
    };
    DBG("mission_init.sqf",(FSTR1("GLOBAL CLAIMERS ARRAY >> %1",iben_wai_ACclaimers)));
  };
  // -------------------------------------------------------------------------
};

// === :: [IWAC] IBEN WAI AUTOCLAIM >> mission_init.sqf :: END
