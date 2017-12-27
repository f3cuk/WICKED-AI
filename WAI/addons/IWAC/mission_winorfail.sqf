// ===========================================================================
// [IWAC] IBEN WAI AUTOCLAIM >> mission_winorfail.sqf
// ===========================================================================
// [last update: 2017-10-22]
// ===========================================================================
// Extended for IWAC by @iben for WAI, DayZ Epoch 1.0.6.2+
// ===========================================================================
// :: Original source: 'dayz_server\WAI\compile\mission_winorfail.sqf'
// ===========================================================================
if (isServer) then {
  // -------------------------------------------------------------------------
  private ["_player_near","_map_marker","_node","_max_ai","_timeout_time",
  "_currenttime","_starttime","_msglose","_msgwin","_msgstart","_objectives",
  "_crate","_marker","_in_range","_objectivetarget","_position","_type",
  "_complete","_timeout","_mission","_killpercent","_delete_mines","_cleanunits",
  "_clearmission","_baseclean"];
  // -------------------------------------------------------------------------
  _mission = (_this select 0) select 0;
  _crate = (_this select 0) select 1;
  _type = (_this select 1) select 0;
  _baseclean = _this select 2;
  _msgstart = _this select 3;
  _msgwin = _this select 4;
  _msglose = _this select 5;
  // -------------------------------------------------------------------------
  _position = position _crate;
  _timeout = false;
  _player_near = false;
  _complete = false;
  _starttime = time;
  _start = false;
  _timeout_time = ((wai_mission_timeout select 0) + random((wai_mission_timeout select 1) - (wai_mission_timeout select 0)));
  _max_ai = (wai_mission_data select _mission) select 0;
  _killpercent = _max_ai - (_max_ai * (wai_kill_percent / 100));
  _mission_units = [];
  // -------------------------------------------------------------------------
  if(_type == "patrol") then {
    _start = true
  };
  // -------------------------------------------------------------------------
  {
    if (_x getVariable ["mission", nil] == _mission) then {
      _mission_units set [count _mission_units, _x];
    };
  } count allUnits;
  // -------------------------------------------------------------------------
  if (wai_mission_announce == "Radio") then {
	RemoteMessage = ["radio","[RADIO] " + _msgstart];
	publicVariable "RemoteMessage";
  };
  if (wai_mission_announce == "DynamicText") then {
	RemoteMessage = ["dynamic_text", ["Mission Announcement",_msgstart]];
	publicVariable "RemoteMessage";
  };
  if (wai_mission_announce == "titleText") then {
	[nil,nil,rTitleText,_msgstart,"PLAIN",10] call RE;
  };
  // -------------------------------------------------------------------------
  markerready = true;
  // -------------------------------------------------------------------------
  while {!_start && !_timeout} do {
    uiSleep 1;
    _currenttime = time;
    // -----------------------------------------------------------------------
    {
      if((isPlayer _x) && (_x distance _position <= 1500)) then {
        _start = true
      };
    } count playableUnits;
    // -----------------------------------------------------------------------
    if (_currenttime - _starttime >= _timeout_time) then {
      _timeout = true;
    };
    // -----------------------------------------------------------------------
  };
  // -------------------------------------------------------------------------
  {
    _x enableAI "TARGET";
    _x enableAI "AUTOTARGET";
    _x enableAI "MOVE";
    _x enableAI "ANIM";
    _x enableAI "FSM";
  } count _mission_units;

  // -------------------------------------------------------------------------
  #include "defines.hpp"
  private ["_cls","_wls","_rls","_msc","_ciz","_ito","_ctv","_adm","_poa",
  "_pua","_pas","_nbe","_v","_cmb", "_i",  "_idx","_plp","_dst","_cnt",
  "_rmv","_pst","_fnd",  "_pia","_pid","_cts","_mrd","_ccl","_psc",
  "_iex","_hsc","_ilw"];

  // -------------------------------------------------------------------------
  _cls = [];
  _wls = [];
  _rls = [];
  _msc = false;
  _ciz = false;
  _ito = false;
  _ctv = 0;
  _adm = [[],iben_wai_ACadmins] select (iben_wai_ACexcludeAdmins);
  _iex = (_type in iben_wai_ACexcludedTypes);

  while {!_timeout && !_complete} do {
    uiSleep 1;
    _currenttime = time;

    // -------------------------------------------------------------------------
    if (!_iex) then {
      // -----------------------------------------------------------------------
      _poa = [];
      _pua = [];
      _pas = [];

      // -----------------------------------------------------------------------
      _nbe = _position nearEntities ["AllVehicles", iben_wai_ACdistance];
      {
        if (!isNull _x) then {
          if ((getPlayerUID _x) != "") then {
            _v = _x;
            if (isPlayer _v) then {
              _crw = (crew _v);
              for "_i" from 0 to ((count _crw) - 1) do {
                _cmb = (_crw select _i);
                _idx = (getPlayerUID _cmb);
                _hsc = (iben_wai_ACclaimers find _idx);
                _ilw = ((_hsc == -1) || (_hsc == _mission));
                if ((isPlayer _cmb) && {!(_idx in _adm)} && {_ilw} && {!(_idx in _pua)}) then {
                  _plp = (ASLToATL (getPosASL _cmb));
                  if (iben_wai_ACplotRestriction && {(count (_plp nearEntities ["Plastic_Pole_EP1_DZ", iben_wai_ACplotRange])) > 0}) exitwith {};
                  _dst = ((_plp distance _position) + _i);
                  if (_dst <= wai_timeout_distance) then {_player_near = true;};
                  _pua set [count _pua, _idx];
                  _poa set [count _poa, [_cmb, _dst]];
                };
              };
            };
          };
        };
      } count _nbe;

      // -----------------------------------------------------------------------
      if (_msc) then {
        // ---------------------------------------------------------------------
        if (!_ito && {!(CML(_cls,1) in _pua)}) then {
          _ctv = diag_tickTime;
          _ciz = false;
          RMSG(CML(_cls,1),FSTR3(STRLO("STR_IWAC_TIMEOUT_START"),ACSTR,CMNAME(_mission),(ceil (_ctv - (diag_tickTime - iben_wai_ACtimeout)))));
        };
        // ---------------------------------------------------------------------  
        _ito = ((_ctv != 0) && {(diag_tickTime - iben_wai_ACtimeout) < _ctv});
        // ---------------------------------------------------------------------
        if (_ito) then {
          _cnt = FSTR1(STRLO("STR_IWAC_MARKER_TIMEOUT"),(ceil (_ctv - (diag_tickTime - iben_wai_ACtimeout))));
          WMDSST(_mission,1,1,_cnt);
          if (CML(_cls,1) in _pua) then {
            _ctv = 0;
            _ciz = true;
            WMDSST(_mission,1,1,STRLO("STR_IWAC_MARKER_ACTIVE"));
            RMSG(CML(_cls,1),FSTR2(STRLO("STR_IWAC_TIMEOUT_INTERRUPT"),ACSTR,CMNAME(_mission)));
          };
        };
        // ---------------------------------------------------------------------  
        if (!_ito && {!_ciz}) then {
          _ctv = 0;
          _ciz = false;
          _cls = [];
          IWACS(_mission,0);
          _msc = false;
          _rmv = [_mission] call IBEN_fnc_deleteFlag;
          if (_rmv) then {
            WMDACD(_mission);
          };
        };
      };

      // -----------------------------------------------------------------------
      call {
        // ---------------------------------------------------------------------
        if ((count _poa) == 0) exitWith {
          _wls = [];
          _rls = [];
        };
        // ---------------------------------------------------------------------
        _pas = (_poa call IBEN_fnc_sortPlrByDist);
        _wls = [_wls, _pas] call IBEN_fnc_clnList;
        _rls = [_rls, _pas] call IBEN_fnc_clnList;
      };

      // -----------------------------------------------------------------------
      {
        if (1 == 1) then {
          // --------------------------------------------------------------------
          _pst = [];
          _fnd = -1;
          _pia = [];
          _pid = (getPlayerUID _x);
          _cts = diag_tickTime;
          // --------------------------------------------------------------------
          _pst = [[_cls,_wls,_rls], _pid, 1] call IBEN_fnc_checkPlrStatus;
  
          _fnd = (_pst select 0);
          _pia = (_pst select 1);
          // --------------------------------------------------------------------
          if (_fnd == 0) exitWith {};
          // --------------------------------------------------------------------
          if (_fnd == 1) exitWith {
            // ------------------------------------------------------------------
            if ((!_msc) && {(_pia select 0) == 0}) exitWith {
              _cls = [_pia select 1];
              _wls = [_wls, (_pia select 0)] call IBEN_fnc_clsIndex;
              _mrd = [];
              _ccl = CML(_cls,0);
              _mrd = ([_position, _ccl, _mission] call IBEN_fnc_createFlag);
              _psc = [STRLO("STR_IWAC_MARKER_UNKNOWN"), (name _ccl)] select (iben_wai_ACshowNames);
              WMD(_mission) set [4, [true,[_psc,STRLO("STR_IWAC_MARKER_ACTIVE")],(_mrd select 0),(_mrd select 1)]];
              IWACS(_mission,CML(_cls,1));
              _ciz = true;
              _msc = true;
              RMSG(CML(_cls,1),FSTR2(STRLO("STR_IWAC_CLAIMED"),ACSTR,CMNAME(_mission)));
            };
          };
          // --------------------------------------------------------------------
          if (_fnd == 2) exitWith {
            if (_cts > (((_pia select 1) select 2) + iben_wai_ACsafeClaimDelay)) exitWith {
              _wls set [count _wls, (_pia select 1)];
              _rls = [_rls, (_pia select 0)] call IBEN_fnc_clsIndex;
            };
          };
          // --------------------------------------------------------------------
          if (_fnd == -1) exitWith {
            _rls set [count _rls, [_x, _pid, _cts]];
            RMSG(_pid,FSTR3(STRLO("STR_IWAC_LEAVE_OR_CLAIM"),ACSTR,(name _x),(ceil ((_cts + iben_wai_ACsafeClaimDelay) - diag_tickTime))));
          };
        };
      } count _pas;
    };

    // -----------------------------------------------------------------------
    if (_iex) then {
      {
        if ((isPlayer _x) && {(_x distance _position) <= wai_timeout_distance}) then {
          _player_near = true;
        };
      } count playableUnits;
    };
    // -----------------------------------------------------------------------
    if (_currenttime - _starttime >= _timeout_time && !_player_near) then {
      _timeout = true;
    };
    // -----------------------------------------------------------------------
    call {
      // ---------------------------------------------------------------------
      if (_type == "crate") exitWith {
        if(wai_kill_percent == 0) then {
          {
            if((isPlayer _x) && (_x distance _position <= 20)) then {
              _complete = true;
            };
          } count playableUnits;
        } else {
          if(((wai_mission_data select _mission) select 0) <= _killpercent) then {
            {
              if((isPlayer _x) && (_x distance _position <= 20)) then {
                _complete = true;
              };
            } count playableUnits;
          };
        };
      };
      // ---------------------------------------------------------------------
      if (_type == "kill") exitWith {
        if(((wai_mission_data select _mission) select 0) == 0) then {
          _complete = true;
        };
      };
      // ---------------------------------------------------------------------
      if (_type == "patrol") exitWith {
        if(((wai_mission_data select _mission) select 0) == 0) then {
          _complete = true;
        };
      };
      // ---------------------------------------------------------------------
      if (_type == "assassinate") exitWith {
        _objectivetarget = (_this select 1) select 1;
        {
          _complete = true;
          if (alive _x) exitWith {_complete = false;};
        } count units _objectivetarget;
      };
      // ---------------------------------------------------------------------
      if (_type == "resource") exitWith {
        _node = (_this select 1) select 1;
        _resource = _node getVariable ["Resource", 0];
        if (_resource == 0) then {
          {
            if((isPlayer _x) && (_x distance _position <= 80)) then {
              _complete = true;
            } else {
              _timeout = true;
            };
          } count playableUnits;
        };
      };
    };
  };

  // -------------------------------------------------------------------------
  if (!_iex) then {
    private "_nll";
    _nll = [_mission] call IBEN_fnc_deleteFlag;
    IWACS(_mission,0);
  };

  // -------------------------------------------------------------------------
  if (_complete) then {
    // -----------------------------------------------------------------------
    if (typeOf(_crate) in (crates_large + crates_medium + crates_small)) then {
      if (wai_crates_smoke && sunOrMoon == 1) then {
        _marker = "smokeShellPurple" createVehicle getPosATL _crate;
        _marker setPosATL (getPosATL _crate);
        _marker attachTo [_crate,[0,0,0]];
      };
      // ---------------------------------------------------------------------
      if (wai_crates_flares && sunOrMoon != 1) then {
        _marker = "RoadFlare" createVehicle getPosATL _crate;
        _marker setPosATL (getPosATL _crate);
        _marker attachTo [_crate, [0,0,0]];
        PVDZ_obj_RoadFlare = [_marker,0];
        publicVariable "PVDZ_obj_RoadFlare";
      };
    };
    // -----------------------------------------------------------------------
    _delete_mines = ((wai_mission_data select _mission) select 2);
    if(count _delete_mines > 0) then {
      {
        if(typeName _x == "ARRAY") then {
          {
            deleteVehicle _x;
          } count _x;
        } else {
          deleteVehicle _x;
        };
      } forEach _delete_mines;
    };
    // -----------------------------------------------------------------------
    if (wai_mission_announce == "Radio") then {
		RemoteMessage = ["radio","[RADIO] " + _msgwin];
		publicVariable "RemoteMessage";
	};
	if (wai_mission_announce == "DynamicText") then {
		RemoteMessage = ["dynamic_text", ["Mission Announcement", _msgwin]];
		publicVariable "RemoteMessage";
	};
	if (wai_mission_announce == "titleText") then {
		[nil,nil,rTitleText,_msgwin,"PLAIN",10] call RE;
	};
    // -----------------------------------------------------------------------
    if (wai_clean_mission) then {
      [_position,_baseclean] spawn {
        private ["_pos","_clean","_finish_time","_cleaned","_playernear","_currenttime"];
        _pos = _this select 0;
        _clean = _this select 1;
        _finish_time = time;
        _cleaned = false;
        while {!_cleaned} do {
          _playernear = false;
          {
            if ((isPlayer _x) && (_x distance _pos < 400)) exitWith { _playernear = true };
          } count playableUnits;
          _currenttime = time;
          if ((_currenttime - _finish_time >= wai_clean_mission_time) && !_playernear) then {
            {
              if (typeName _x == "ARRAY") then {
                {
                  if !(_x isKindOf "AllVehicles") then {deleteVehicle _x;};
                } count _x;
              } else {
                if !(_x isKindOf "AllVehicles") then {deleteVehicle _x;};
              };
            } forEach _clean;
            _cleaned = true;
          };
          uiSleep 1;
        };
      };
    };
  };
  // -------------------------------------------------------------------------
  if (_timeout) then {
    {
      if (_x getVariable ["mission", nil] == _mission) then {
        if (alive _x) then {
          _cleanunits = _x getVariable ["missionclean",nil];
          if (!isNil "_cleanunits") then {
            call {
              if(_cleanunits == "ground")exitWith { ai_ground_units = (ai_ground_units -1); };
              if(_cleanunits == "air") exitWith { ai_air_units = (ai_air_units -1); };
              if(_cleanunits == "vehicle") exitWith { ai_vehicle_units = (ai_vehicle_units -1); };
              if(_cleanunits == "static") exitWith { ai_emplacement_units = (ai_emplacement_units -1); };
            };
          };
        };
        deleteVehicle _x;
      };
    } count allUnits + vehicles + allDead;
    // -----------------------------------------------------------------------
    {
      if(typeName _x == "ARRAY") then {
        {
          deleteVehicle _x;
        } count _x;
      } else {
        deleteVehicle _x;
      };
    } forEach _baseclean + ((wai_mission_data select _mission) select 2) + [_crate];
    // -----------------------------------------------------------------------
    if (wai_mission_announce == "Radio") then {
		RemoteMessage = ["radio","[RADIO] " + _msglose];
		publicVariable "RemoteMessage";
	};
	if (wai_mission_announce == "DynamicText") then {
		RemoteMessage = ["dynamic_text", ["Mission Announcement", _msglose]];
		publicVariable "RemoteMessage";
	};
	if (wai_mission_announce == "titleText") then {
		[nil,nil,rTitleText,_msglose,"PLAIN",10] call RE;
	};
  };
  // -------------------------------------------------------------------------
  _map_marker = (wai_mission_data select _mission) select 1;
  wai_mission_markers = wai_mission_markers - [(_map_marker + str(_mission))];
  wai_mission_data set [_mission, -1];
  _complete

};

// === :: [IWAC] IBEN WAI AUTOCLAIM >> mission_winorfail.sqf :: END
