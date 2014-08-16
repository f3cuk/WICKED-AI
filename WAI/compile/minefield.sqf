// =========================================================================================================
//  Mine Field
//  Version: 1.5.0
//  Author: Kronzky (www.kronzky.info / kronzky@gmail.com)
// ---------------------------------------------------------------------------------------------------------
// Required parameter:
//      areamarker        : Name of marker that designates the area to be covered.
// Optional parameters: 
//      trigger:,string   : The class of unit that should activate the trigger. ("Land")
//      side:,string      : Which side the mine should be triggered by. ("ANY")             
//      density:,number   : How densely the area should be filled. (10)                
//      count:,number     : How many mines should be used (alternative to density).
//      grid:,number      : Position mines in a grid.
//      range:,number     : How close a unit has to be to activate the trigger. (.75)               
//      ammo:,string      : What type of ammo to use for the explosion. (Land,Man=G_40mm_HE, LandVehicle=R_Hydra_HE, Tank=Sh_125_HE)
//      mine:,string      : Class of visible mine object. ("Mine")            
//      height:,number    : The height position of the mine. (Mine:0, MineE:0.025)
//      showsigns:,string : Create warning signs at the corners of the mined area.
//      showmarker        : Keep the designation marker visible.
//
// nul=["areamarker", "trigger:","Wheeled_APC","side:","EAST", "ammo:","Sh_120_HE", "mine:","MineE", "density:",30, "range:",3] call "minefield.sqf";
//
// =========================================================================================================

if !(isServer) exitWith {};

// =========================================================================================================

// has the function been initialized yet?
if (isNil("KRON_MF_Tot")) then {
  KRON_MF_Tot=0;
	publicVariable "KRON_MF_Tot";
  KRON_MF_Mines=[];
	KRON_MF_Blowup = {private["_near"]; _near=[_this select 0,_this select 1] nearObjects [_this select 3,_this select 2]; {if ((_x select 0) in _near) then {call compile format["KRON_MT_%1_ON=true",_x select 1]; deleteVehicle (_x select 0)}} forEach KRON_MF_Mines};
	KRON_MF_Clear = {
		private["_n","_t","_l","_m","_t","_a"];
		_n=_this select 0; 
		_j=call compile format["KRON_MF_%1",_n];
		if (_j>0) then {
			{
	      _m=_x select 0;
	      _t=_x select 1;
	      _a=_x select 2;
	      if (_a==_n) then {
					if (("explode" in _this) || ("EXPLODE" in _this)) then {
						call compile format["KRON_MT_%1_ON=true",_t];
					} else {
						call compile format["deleteVehicle KRON_MT_%1",_t];
						deleteVehicle _m;
					};
				};
			} forEach KRON_MF_Mines;
		};
	};
	KRON_MF_Count = [];
	KRON_MF_Areas = [];
};

// shared functions
_rotpoint = {private["_cx","_cy","_rx","_ry","_cd","_sd","_ad","_tx","_ty","_xout","_yout"];_cx=_this select 0; _cy=_this select 1; _rx=_this select 2; _ry=_this select 3; _cd=_this select 4; _sd=_this select 5; _ad=_this select 6; _tx=_this select 7; _ty=_this select 8; _xout=if (_ad!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_ad!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout,0]};
_makeobj = {private["_o","_p","_o1","_x","_y","_z","_d"]; _o=_this select 0; _p=_this select 1; _x=_p select 0; _y=_p select 1; _z=_p select 2; _d=_this select 2; _o1 = _o createVehicle [_x,_y,_z]; _o1 setPos [_x,_y,_z]; _o1 setDir _d; _o1;};
_getArg = {private["_cUC","_arg","_list","_a","_v"]; _cUC=toUpper(_this select 0); _arg=_this select 1; _list=_this select 2; _a=-1; {_a=_a+1; _v=toUpper(format["%1",_list select _a]); if (_v==_cUC) then {_arg=(_list select _a+1)}} foreach _list; _arg};

// read marker definition
_areamarker = _this select 0;
if !(_areamarker in KRON_MF_Areas) then {KRON_MF_Areas=KRON_MF_Areas+[_areamarker]};
call compile format["KRON_MF_%1=1; publicVariable ""KRON_MF_%1""",_areamarker];
_areadir = (markerDir _areamarker);
// trig values
_cosdir=cos(_areadir*-1);
_sindir=sin(_areadir*-1);
// size 
_areasize = getMarkerSize _areamarker;
_sizeX = _areasize select 0;
_sizeY = _areasize select 1;
// position 
_centerpos = getMarkerPos _areamarker;
_centerX = abs(_centerpos select 0);
_centerY = abs(_centerpos select 1);


// trigger class
_trigact = toUpper(["TRIGGER:","Land",_this] call _getArg);
// trigger side 
_trigside = ["SIDE:","ANY",_this] call _getArg;
// density
_density = ["DENSITY:",10,_this] call _getArg;
// count
_defmax=((_sizeX)*(_sizeY))/_density;
_max = ["COUNT:",_defmax,_this] call _getArg;
// range
_trigrange = ["RANGE:",.75,_this] call _getArg;
// ammo
_defammo=switch (_trigact) do {
  case "LANDVEHICLE": {"R_Hydra_HE"};
  case "TANK": {"Sh_125_HE"};
  case "SHIP": {"Sh_125_HE"};
  default {"G_40mm_HE"};
};
_trigobj = ["AMMO:",_defammo,_this] call _getArg;
// mine class
_mineobj=toUpper(["MINE:","MINE",_this] call _getArg);
// height
_defz=switch (_mineobj) do {
  case "MINE": {0};
  case "MINEE": {.025};
  case "KRON_MINEW_INERT": {-.1};
  case "KRON_MINEE_INERT": {-.09};
  default {0};
};
_z=["HEIGHT:",_defz,_this] call _getArg;
// grid
_grid=["GRID:",0,_this] call _getArg;
// hide marker
if (!("SHOWMARKER" in _this) && !("showmarker" in _this)) then {
  _areamarker setMarkerPos [abs(getMarkerPos _areamarker select 0)*-1, abs(getMarkerPos _areamarker select 1)*-1];
};
// show warning signs
/*_showsigns = ["SHOWSIGNS:","",_this] call _getArg;
if (_showsigns!="") then {
  _pos = [_centerX,_centerY,_sizeX,_sizeY,_cosdir,_sindir,_areadir,_sizeX*-1,_sizeY*-1] call _rotpoint;
	[_showsigns,_pos,_areadir] call _makeobj;
  _pos = [_centerX,_centerY,_sizeX,_sizeY,_cosdir,_sindir,_areadir,_sizeX,_sizeY*-1] call _rotpoint;
	[_showsigns,_pos,_areadir] call _makeobj;
	if (_sizeY>=1) then {
	  _pos = [_centerX,_centerY,_sizeX,_sizeY,_cosdir,_sindir,_areadir,_sizeX*-1,_sizeY] call _rotpoint;
		[_showsigns,_pos,_areadir] call _makeobj;
	  _pos = [_centerX,_centerY,_sizeX,_sizeY,_cosdir,_sindir,_areadir,_sizeX,_sizeY] call _rotpoint;
		[_showsigns,_pos,_areadir] call _makeobj;
	};
};*/

// are all the object legit?
_chk=[_mineobj,[0,0,0],0] call _makeobj;
if (isNull _chk) exitWith {hintc format["Mine class ""%1"" (for area ""%2"") does not exist!",_mineobj,_areamarker]};
deleteVehicle _chk;
_chk=[_trigobj,[0,0,200],0] call _makeobj;
if (isNull _chk) exitWith {hintc format["Ammo class ""%1"" (for area ""%2"") does not exist!",_trigobj,_areamarker]};
deleteVehicle _chk;
if (_showsigns!="") then {
	_chk=[_showsigns,[0,0,0],0] call _makeobj;
	if (isNull _chk) exitWith {hintc format["Sign class ""%1"" (for area ""%2"") does not exist!",_showsigns,_areamarker]};
	deleteVehicle _chk;
};
if !(isClass (configFile >> "cfgvehicles" >> _trigact)) exitWith {hintc format["Activator class ""%1"" (for area ""%2"") does not exist!",_trigact,_areamarker]};
_armamine=({_x==_mineobj} count ["Mine","MineE"]>0);


// place the weakest class underground, so it's not always deadly
_tz = if (_trigobj=="G_40mm_HE") then {-5.5} else {0};

// create mines
_x=-_sizeX; _y=-_sizeY;
if (_grid!=0) then {_max=(floor((_sizeX*2)/_grid)+1)*(floor((_sizeY*2)/_grid)+1)};
for [{_i=0}, {_i<_max}, {_i=_i+1}] do {
  KRON_MF_Tot=KRON_MF_Tot+1;
  if (_grid==0) then {
	  _x=random (_sizeX*2)-_sizeX; 
	  _y=random (_sizeY*2)-_sizeY; 
	};
  _pos = [_centerX,_centerY,_sizeX,_sizeY,_cosdir,_sindir,_areadir,_x,_y] call _rotpoint;
 	_x=_x+_grid;
 	if (_x>_sizeX) then {_x=-_sizeX; _y=_y+_grid};
  _tx = _pos select 0; 
  _ty = _pos select 1; 
  _obj=[_mineobj,[_tx,_ty,_z],random 360] call _makeobj;
  KRON_MF_Mines=KRON_MF_Mines+[[_obj,KRON_MF_Tot,_areamarker]];
  _t=createTrigger["EmptyDetector",[_tx,_ty]]; 
  _t setTriggerArea [_trigrange,_trigrange,0,true]; 
  call compile format["_t setTriggerActivation[""%1"",""PRESENT"",false]",_trigside]; 
  call compile format["_t setTriggerStatements[""((this && '%5' countType thislist>0) || !isNil('KRON_MT_%6_ON'))"", ""'%1' createVehicle [%2,%3,%4]; [%2,%3,%7,'%8'] call KRON_MF_Blowup; deleteVehicle KRON_MT_%6; "",""""]", _trigobj,_tx,_ty,_tz,_trigact,KRON_MF_Tot,_trigrange,_mineobj]; 
	_t setVehicleVarName format["KRON_MT_%1",KRON_MF_Tot]; 
  _t call compile format ["KRON_MT_%1=_t",KRON_MF_Tot]; 
};
publicVariable "KRON_MF_Tot";
  
// check for defused or exploded mines
if (isNil("KRON_MineLoop")) then {
  KRON_MineLoop=true;
  while {(count KRON_MF_Mines)>0} do {
	  KRON_MF_Tot=0;
  	{call compile format["KRON_MF_%1=0",_x]}forEach KRON_MF_Areas;
    _active=[];
    {
      _m=_x select 0;
      _t=_x select 1;
      _a=_x select 2;
      if (isNull _m || (_armamine && ((vectorUp _m select 2)!=1))) then {
        call compile format["deleteVehicle KRON_MT_%1",_t];
      } else {
        _active=_active+[_x];
				call compile format["KRON_MF_%1=KRON_MF_%1+1;",_a];
				KRON_MF_Tot=KRON_MF_Tot+1;
      }
    } forEach KRON_MF_Mines;
    KRON_MF_Mines=+_active;
  	{call compile format["publicVariable ""KRON_MF_%1""",_x]}forEach KRON_MF_Areas;
  	publicVariable "KRON_MF_Tot";
    sleep 1;
	  //player sidechat format["%1/%2",kron_mf_active,count kron_mf_mines];
  };
  KRON_MF_Active=[];
};

