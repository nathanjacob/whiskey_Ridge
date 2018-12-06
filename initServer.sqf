if (!isServer) exitWith {};

RD_afghanInf = ["TBan_Fighter2","TBan_Fighter3","TBan_Fighter4","TBan_Fighter5","TBan_Fighter6","TBan_Recruit","TBan_Recruit2","TBan_Recruit5","TBan_Recruit6","TBan_Recruit3","TBan_Recruit4","TBan_Warlord"];

[] execVM "RD_Scripts\unarmed_armed.sqf";

[] execVM "RD_Scripts\whiskeyRidge.sqf";


[] execVM "scripts\fn_advancedTowingInit.sqf";
[] execVM "eos\OpenMe.sqf";
[] execVM "RD_Scripts\civilian_asset_management.sqf";



//airbaseReaspawn = [west, (getmarkerPos "kindufAirfield"), "Kinduf Airbase"] call BIS_fnc_addRespawnPosition;
//outpostRespawn = [west, (getmarkerPos "OP_Conflict"), "OP Conflict"] call BIS_fnc_addRespawnPosition;


[] spawn {
     while {true} do {
          {
               if (!isNull (getAssignedCuratorUnit _x)) then {
                    _x addCuratorEditableObjects [allUnits + vehicles + (allMissionObjects "All"),true];
               };
          } count allCurators;
          sleep 5;
     };
};
