cacheLocation = [];
hint "Shits running";

fnc_buildArray = {
	
	_arrayBase = _this select 0;
	
	_checkNum = 1;
	_checkString = _arrayBase + str _checkNum;
	
	while {(!(isNil _checkString))} do 
	{
		cacheLocation pushback _checkString;
		_checkNum = _checkNum + 1;
		_checkString = _arrayBase + str _checkNum;
	};



};

hint "loops done";


["cacheHouse_"] call fnc_buildArray;


target =  missionNamespace getVariable [(selectRandom cacheLocation),objNull];
_cachePos = (getPos target) findEmptyPosition [1, 10,"Land_Pallet_MilBoxes_F"];

_cache = [_cachePos,(floor random 360),"Land_Pallet_MilBoxes_F"] call bis_fnc_spawnVehicle;



spawnPoint = missionNamespace getVariable [(selectRandom cacheLocation),objNull];

while {(target isEqualto spawnPoint)} do {spawnPoint = missionNamespace getVariable [(selectRandom cacheLocation),objNull];};

spawnBuilding = nearestBuilding spawnPoint;


//for [{_i=0}, {_i<3}, {_i=_i+1}] do 

maxSquads = 3;
squadNum = 1;

while { ((squadNum <= maxSquads) && (alive spawnBuilding))} do
{
	
	_grp = "group" + str squadNum;
	_grp = [(getPos spawnPoint), east, 3] call BIS_fnc_spawnGroup;
	_grp  addwaypoint [(getPos target),1,1];
	[_grp,1] setWaypointType "MOVE";
	[_grp,1] setWaypointFormation "FILE";
	[_grp,1] setWaypointSpeed "LIMITED";
	[_grp,1] setWaypointBehaviour "SAFE";
	
	_grp setCurrentWaypoint [_grp, 1];
	sleep 10;
	squadNum = squadNum + 1;
};


