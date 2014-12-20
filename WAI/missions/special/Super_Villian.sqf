if(isServer) then {

    private         ["_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13","_baserunover14","_baserunover15","_baserunover16","_baserunover17","_baserunover18","_baserunover19","_baserunover20","_baserunover21","_baserunover22","_baserunover23","_baserunover24","_baserunover25","_baserunover26","_baserunover27","_baserunover28","_baserunover29","_baserunover30","_baserunover31","_baserunover32","_baserunover33","_baserunover34","_baserunover35","_baserunover36","_baserunover37","_baserunover38","_baserunover39","_baserunover40","_baserunover41","_baserunover42","_baserunover43","_baserunover44","_baserunover45","_baserunover46","_baserunover47","_baserunover48","_baserunover49","_baserunover50","_baserunover51","_baserunover52","_baserunover53","_baserunover54","_baserunover55","_baserunover56","_baserunover57","_baserunover58","_baserunover59","_baserunover60","_baserunover61","_baserunover62","_baserunover63","_baserunover64","_baserunover65","_baserunover66","_baserunover67","_baserunover68","_baserunover69","_baserunover70","_baserunover71","_baserunover72","_baserunover73","_baserunover74","_baserunover75","_baserunover76","_baserunover77","_baserunover78","_baserunover79","_baserunover80","_baserunover81","_baserunover82","_baserunover83","_baserunover84","_baserunover85","_baserunover86","_baserunover87","_baserunover88","_baserunover89","_baserunover90","_baserunover91","_baserunover92","_baserunover93","_baserunover94","_baserunover95","_baserunover96","_baserunover97","_baserunover98","_baserunover99","_baserunover100"];

    wai_mission_timeout     = [3600,5400]; //time each missions takes to despawn if inactive 60-90 minutes

    _position        = [200] call find_position;
    _mission        = [_position,"Extreme","Super Villains Lair","MainBandit",true] call mission_init;
    
    diag_log         format["WAI: [Mission:[Bandit] Super Villains Lair]: Starting... %1",_position];

    //Setup the crate
    _crate_type     = crates_large call BIS_fnc_selectRandom;
    _crate             = createVehicle [_crate_type,[(_position select 0),(_position select 1) + 10,15.8], [], 0, "CAN_COLLIDE"];

    //Super Villains Lair
    _baserunover0 = createVehicle ["land_aif_hotel_bio",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];
    _baserunover1 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 45, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover2 = createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) - 45,-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover3 = createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) + 45,-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover4 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 45, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover5 = createVehicle ["Land_Fort_Watchtower",[(_position select 0) - 45, (_position select 1) + 45,-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover6 = createVehicle ["Land_Fort_Watchtower",[(_position select 0) + 45, (_position select 1) + 45,-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover7 = createVehicle ["Land_Fort_Watchtower",[(_position select 0) - 45, (_position select 1) - 45,-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover8 = createVehicle ["Land_Fort_Watchtower",[(_position select 0) + 45, (_position select 1) - 45,-0.2],[], 0, "CAN_COLLIDE"];
    _baserunover9 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 35, (_position select 1) - 10,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover10 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 35, (_position select 1) - 20,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover11 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 35, (_position select 1) - 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover12 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 35, (_position select 1) + 10,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover13 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 35, (_position select 1) + 20,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover14 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 35, (_position select 1) + 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover15 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 35, (_position select 1) - 10,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover16 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 35, (_position select 1) - 20,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover17 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 35, (_position select 1) - 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover18 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 35, (_position select 1) + 10,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover19 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 35, (_position select 1) + 20,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover20 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 35, (_position select 1) + 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover21 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 10, (_position select 1) - 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover22 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 20, (_position select 1) - 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover23 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 30, (_position select 1) - 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover24 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 10, (_position select 1) - 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover25 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 20, (_position select 1) - 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover26 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 30, (_position select 1) - 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover27 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 10, (_position select 1) + 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover28 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 20, (_position select 1) + 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover29 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 30, (_position select 1) + 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover30 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 10, (_position select 1) + 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover31 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 20, (_position select 1) + 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover32 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 30, (_position select 1) + 35,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover33 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 100, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover34 = createVehicle ["Land_HBarrier5",[(_position select 0) + 100, (_position select 1) + 90,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover35 = createVehicle ["Land_HBarrier5",[(_position select 0) + 90, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover36 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 100, (_position select 1) + 40,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover37 = createVehicle ["Land_HBarrier5",[(_position select 0) + 100, (_position select 1) + 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover38 = createVehicle ["Land_HBarrier5",[(_position select 0) + 100, (_position select 1) + 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover39 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 100, (_position select 1) - 40,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover40 = createVehicle ["Land_HBarrier5",[(_position select 0) + 100, (_position select 1) - 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover41 = createVehicle ["Land_HBarrier5",[(_position select 0) + 100, (_position select 1) - 55,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover42 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 100, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover43 = createVehicle ["Land_HBarrier5",[(_position select 0) + 100, (_position select 1) - 90,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover44 = createVehicle ["Land_HBarrier5",[(_position select 0) + 90, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover45 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 40, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover46 = createVehicle ["Land_HBarrier5",[(_position select 0) + 50, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover47 = createVehicle ["Land_HBarrier5",[(_position select 0) + 30, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover48 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 40, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover49 = createVehicle ["Land_HBarrier5",[(_position select 0) - 30, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover50 = createVehicle ["Land_HBarrier5",[(_position select 0) - 50, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover51 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 100, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover52 = createVehicle ["Land_HBarrier5",[(_position select 0) - 90, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover53 = createVehicle ["Land_HBarrier5",[(_position select 0) - 100, (_position select 1) - 90,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover54 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 100, (_position select 1) - 40,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover55 = createVehicle ["Land_HBarrier5",[(_position select 0) - 100, (_position select 1) - 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover56 = createVehicle ["Land_HBarrier5",[(_position select 0) - 100, (_position select 1) - 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover57 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 100, (_position select 1) + 40,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover58 = createVehicle ["Land_HBarrier5",[(_position select 0) - 100, (_position select 1) + 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover59 = createVehicle ["Land_HBarrier5",[(_position select 0) - 100, (_position select 1) + 30,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover60 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 100, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover61 = createVehicle ["Land_HBarrier5",[(_position select 0) - 100, (_position select 1) + 90,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover62 = createVehicle ["Land_HBarrier5",[(_position select 0) - 90, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover63 = createVehicle ["land_fortified_nest_big",[(_position select 0) - 40, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover64 = createVehicle ["Land_HBarrier5",[(_position select 0) - 30, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover65 = createVehicle ["Land_HBarrier5",[(_position select 0) - 50, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover66 = createVehicle ["land_fortified_nest_big",[(_position select 0) + 40, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover67 = createVehicle ["Land_HBarrier5",[(_position select 0) + 50, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover68 = createVehicle ["Land_HBarrier5",[(_position select 0) - 30, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover69 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover70 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 150, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover71 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 100, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover72 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 50, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover73 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 0, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover74 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 50, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover75 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 100, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover76 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 150, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover77 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) + 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover78 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) + 150,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover79 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover80 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) + 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover81 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) + 0,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover82 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) - 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover83 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover84 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) - 150,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover85 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 200, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover86 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 150, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover87 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 100, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover88 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 50, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover89 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) + 0, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover90 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 50, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover91 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 100, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover92 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 150, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover93 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) - 200,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover94 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) - 150,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover95 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) - 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover96 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) - 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover97 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) - 0,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover98 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) + 50,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover99 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) + 100,-0.1],[], 0, "CAN_COLLIDE"];
    _baserunover100 = createVehicle ["MAP_fortified_nest_small",[(_position select 0) - 200, (_position select 1) + 150,-0.1],[], 0, "CAN_COLLIDE"];
    
    _baserunover     = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16,_baserunover17,_baserunover18,_baserunover19,_baserunover20,_baserunover21,_baserunover22,_baserunover23,_baserunover24,_baserunover25,_baserunover26,_baserunover27,_baserunover28,_baserunover29,_baserunover30,_baserunover31,_baserunover32,_baserunover33,_baserunover34,_baserunover35,_baserunover36,_baserunover37,_baserunover38,_baserunover39,_baserunover40,_baserunover41,_baserunover42,_baserunover43,_baserunover44,_baserunover45,_baserunover46,_baserunover47,_baserunover48,_baserunover49,_baserunover50,_baserunover51,_baserunover52,_baserunover53,_baserunover54,_baserunover55,_baserunover56,_baserunover57,_baserunover58,_baserunover59,_baserunover60,_baserunover61,_baserunover62,_baserunover63,_baserunover64,_baserunover65,_baserunover66,_baserunover67,_baserunover68,_baserunover69,_baserunover70,_baserunover71,_baserunover72,_baserunover73,_baserunover74,_baserunover75,_baserunover76,_baserunover77,_baserunover78,_baserunover79,_baserunover80,_baserunover81,_baserunover82,_baserunover83,_baserunover84,_baserunover85,_baserunover86,_baserunover87,_baserunover88,_baserunover89,_baserunover90,_baserunover91,_baserunover92,_baserunover93,_baserunover94,_baserunover95,_baserunover96,_baserunover97,_baserunover98,_baserunover99,_baserunover100];
    _directions        = [90,270,0,180,90,0,90,0,180,90,90,90,90,90,90,90,90,90,90,90,90,0,0,0,0,0,0,0,0,0,0,0,0,180,90,0,270,90,90,270,90,90,0,90,0,0,0,0,0,0,0,0,0,270,90,270,270,90,270,0,180,270,0,180,0,0,180,0,0,180,180,180,180,180,180,180,180,180,270,270,270,270,270,270,270,0,0,0,0,0,0,0,0,0,90,90,90,90,90,90,90];
    
    { _x setDir (_directions select _forEachIndex) } forEach _baserunover;

    { _x setVectorUp surfaceNormal position  _x; } count _baserunover;

    //Troops
    _rndnum = round (random 3) + 4;
    [[(_position select 0) + 60, (_position select 1) + 60, 0],6,"extreme","Random",4,"Random","gsc_eco_stalker_mask_fred","Random",true] call spawn_group;
    [[(_position select 0) - 60, (_position select 1) + 60, 0],6,"extreme","Random",4,"Random","gsc_eco_stalker_mask_camo","Random",true] call spawn_group;
    [[(_position select 0) - 60, (_position select 1) - 60, 0],6,"extreme","Random",4,"Random","gsc_eco_stalker_mask_neutral","Random",true] call spawn_group;
    [[(_position select 0) + 60, (_position select 1) - 60, 0],6,"extreme","Random",4,"Random","gsc_eco_stalker_head_fred","Random",true] call spawn_group;
    [[(_position select 0) + 20, (_position select 1) + 0, 0],6,"extreme","Random",4,"Random","gsc_eco_stalker_head_neutral","Random",true] call spawn_group;
    
    //The Super Villain Himself
    [[(_position select 0) + 5,(_position select 1) + 10, 0],1,"extreme","BAF_AS50_scoped_DZ",4,"Random","gsc_eco_stalker_head_duty","Random",true] call spawn_group;
    
    // Turrets
    [[[(_position select 0) + 55, (_position select 1) - 55, 0],[(_position select 0) - 55, (_position select 1) - 55, 0]],"M2StaticMG","hard","gsc_eco_stalker_mask_fred",1,2,"Random","Random",true] call spawn_static;
    [[[(_position select 0) - 55, (_position select 1) + 55, 0],[(_position select 0) + 55, (_position select 1) + 55, 0]],"M2StaticMG","hard","gsc_eco_stalker_mask_camo",1,2,"Random","Random",true] call spawn_static;
    [[[(_position select 0) + 55, (_position select 1) - 55, 0],[(_position select 0) - 55, (_position select 1) - 55, 0]],"TOW_Tripod","hard","gsc_eco_stalker_mask_neutral","Random",2,"Random","Random",true] call spawn_static;
    [[[(_position select 0) - 55, (_position select 1) + 55, 0],[(_position select 0) + 55, (_position select 1) - 55, 0]],"TOW_Tripod","hard","gsc_eco_stalker_head_fred","Random",2,"Random","Random",true] call spawn_static;
    [[[(_position select 0) - 13, (_position select 1) + 15, 15.77],[(_position select 0) + 21, (_position select 1) - 23, 15.77]],"Searchlight","hard","gsc_eco_stalker_mask_fred","Random",2,"Random","Random",true] call spawn_static;
    [[[(_position select 0) - 13, (_position select 1) - 23, 15.77],[(_position select 0) + 21, (_position select 1) + 15, 15.77]],"Stinger_Pod","hard","gsc_eco_stalker_head_fred","Random",2,"Random","Random",true] call spawn_static;
    
    [[(_position select 0) + 80, (_position select 1) + 70, 0],[(_position select 0) + 20, (_position select 1) - 70, 0],200,2,"Offroad_DSHKM_Gue_DZE","hard"] spawn vehicle_patrol;
    [[(_position select 0) + 80, (_position select 1) + 70, 0],[(_position select 0) + 30, (_position select 1) - 70, 0],200,2,"UAZ_SPG9_INS","hard"] spawn vehicle_patrol;
    [[(_position select 0) + 80, (_position select 1) + 70, 0],[(_position select 0) + 40, (_position select 1) - 70, 0],200,2,"BRDM2_INS","hard"] spawn vehicle_patrol;
    [[(_position select 0) + 80, (_position select 1) + 70, 0],[(_position select 0) + 50, (_position select 1) - 70, 0],200,2,"T34","hard"] spawn vehicle_patrol;
    
    [[(_position select 0), (_position select 1), 0],[(_position select 0) + 1100, (_position select 1) + 1100, 150],400,"UH1H_TK_EP1",5,"hard","Random",4,"Random","gsc_eco_stalker_mask_fred","Random",true] spawn heli_para;
    [[(_position select 0), (_position select 1), 0],[(_position select 0) + 1050, (_position select 1) + 1050, 150],300,"UH1H_TK_EP1",5,"hard","Random",4,"Random","gsc_eco_stalker_mask_camo","Random",true] spawn heli_para;
    [[(_position select 0), (_position select 1), 0],[(_position select 0) + 1000, (_position select 1) + 1000, 150],200,"AH6J_EP1",0,"hard","Random",4,"Random","Random","Random",true] spawn heli_para;
    [[(_position select 0), (_position select 1), 0],[(_position select 0) + 1000, (_position select 1) + 1000, 150],100,"Mi24_V",4,"hard","Random",4,"Random","gsc_eco_stalker_mask_neutral","Random",true] spawn heli_para;

    // Spawn Vehicles
    _dir             = floor(round(random 360));

    _vehclass         = bandit_vehicles             call BIS_fnc_selectRandom;
    _vehclass2         = super_villain_vehicles     call BIS_fnc_selectRandom;
    _vehclass3         = super_villain_choppers     call BIS_fnc_selectRandom;

    _vehicle        = [_vehclass,_position,false,_dir]     call custom_publish;
    _vehicle2        = [_vehclass2,_position,false,_dir] call custom_publish;
    _vehicle3        = [_vehclass3,_position,false,_dir] call custom_publish;
    
    if(debug_mode) then {
        diag_log format["WAI: [Bandit] super_villain spawned a %1",_vehclass];
        diag_log format["WAI: [Bandit] super_villain spawned a %1",_vehclass3];
        diag_log format["WAI: [Bandit] super_villain spawned a %1",_vehclass2];
    };

    //Condition
    _complete = [
        [_mission,_crate],                // mission number and crate
        ["kill"],                        // ["crate"], or ["kill"], or ["assassinate", _unitGroup],
        [_baserunover],                 // cleanup objects
        format["The Super Villain has setup a new lair from where he plans to take over %1, go and stop him!",worldName],    // mission announcement
        "The Super Villain has been taken out and his evil plans foiled!",                                    // mission success
        "Survivors were unable to stop the Super Villain, soon he will enslave you all!"                // mission fail
    ] call mission_winorfail;

    if(_complete) then {
        [_crate,80,20,[6,crate_items_high_value],10] call dynamic_crate;
    };

    diag_log format["WAI: [Mission:[Bandit] Super Villains Lair]: Ended at %1",_position];

    wai_mission_timeout = [900,1800]; //time each missions takes to despawn if inactive 15-30 minutes
    
    b_missionrunning = false;

};