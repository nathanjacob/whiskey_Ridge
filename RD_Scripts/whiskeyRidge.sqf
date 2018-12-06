//_trigger = _this select 0;
if (!isServer) exitWith {};


maxSquads = 3;
squadNum = 1;

patrolSquadMax = 2;
patrolCount = 1;

//sentrySquadMax = 4;
//sentryCount = 1;

stalkerSquadMax = 2;
stalkerCount = 1;


patrolEndpoint = [];
_rallyPosition = [];

buildings = [];

armed = createGroup east;
armed deleteGroupWhenEmpty true;








/*
_structures = nearestObjects [(getPos cityCenter), ["building"], 400];

{
	_posArray = [_x] call BIS_fnc_buildingPositions;
	//Count number of positions in the array
	_posCount = count _posArray;
	if (_posCount > 0) then {_buildings pushBack _x;};
}forEach _structures;
*/

_checkNum = 1;
_checkString = "spawnBuilding_" + str _checkNum;
_checkObj = missionNameSpace getVariable _checkString;

while {!(_checkObj isEqualto objNull)} do
{
	buildings pushBack  _checkObj;
	_checkNum = _checkNum + 1;
	_checkString = "spawnBuilding_" + str _checkNum;
	_checkObj = missionNameSpace getVariable _checkString;
};

//Determine where squads will originate
spawnPoint = selectRandom buildings;

_checkNum = 1;
_checkString = "patrolEnd_" + str _checkNum;
while {(getmarkerColor _checkString) != "" } do 
{
	patrolEndpoint pushback _checkString;
	_checkNum = _checkNum + 1;
	_checkString = "patrolEnd_" + str _checkNum;
};

_checkNum = nil;
_checkString = nil;

target =  (selectRandom buildings);
while {(target isEqualto spawnPoint)} do {target = (selectRandom buildings);};



fnc_spawnPatrol = {
	
	//[[west,"HQ"],"Attempting to spawn Patrol"] remoteExec ["sideChat",0];
	
	if ((patrolCount <= patrolSquadMax) && (alive spawnPoint)) then 
	{

		_grp = "group" + str patrolCount;
		
		// NEW SQUAD SPAWN STUFF
		
		_tempArray = [];
		_groupSize = 2 + (floor random 4);
		for [{_i=0}, {_i <= _groupSize}, {_i = _i + 1}] do 
		{
			
			_tempArray pushback (selectRandom RD_afghanInf);
			
		};
		
		_grp = [(getPos spawnPoint), east, _tempArray] call BIS_fnc_spawnGroup;
		
		//_grp = [(getPos spawnPoint), east, 3] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		
		{
			//This event handler detects if  unit is killed and checks if his entire group is dead. If the group is all dead it reduces current convoy count and begins building new group
			_x addMPEventHandler ["mpkilled", {if ({alive _x} count units group (_this select 0) < 1) then {patrolCount = patrolCount - 1; null = [] spawn fnc_spawnSquads;};}];
			
		}forEach units _grp;
				
		_grp  addwaypoint [(getMarkerPos (selectRandom patrolEndpoint)),1,1];
		//_grp  addwaypoint [(getMarkerPos "patrolEnd_1"),1,1];
		[_grp,1] setWaypointType "MOVE";
		[_grp,1] setWaypointFormation "FILE";
		[_grp,1] setWaypointSpeed "LIMITED";
		[_grp,1] setWaypointBehaviour "SAFE";
		[_grp,1] setWaypointCompletionRadius 15;
		_grp setCurrentWaypoint [_grp, 1];
		[_grp,1] setWaypointStatements ["true","{deleteVehicle _x;}forEach thisList; patrolCount = patrolCount - 1; [] call fnc_spawnSquads;"];
		
		patrolCount = patrolCount + 1;
	};


};

fnc_spawnSentry = {
	
	//[[west,"HQ"],"Attempting to spawn Sentry"] remoteExec ["sideChat",0];
	
	if ((sentryCount <= sentrySquadMax) && (alive spawnPoint)) then 
	{

		_grp = "group" + str sentryCount;
		_grp = [(getPos spawnPoint), east, 3] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		sentryCount = sentryCount + 1;
		
		{
			//This event handler detects if  unit is killed and checks if his entire group is dead. If the group is all dead it reduces current convoy count and begins building new group
			_x addMPEventHandler ["mpkilled", {if ({alive _x} count units group (_this select 0) < 1) then {sentryCount = sentryCount - 1; null = [] spawn fnc_spawnSquads;};}];
			
		}forEach units _grp;
	

		_grp setBehaviour "SAFE";
		_grp setCombatMode "RED";
		_grp setSpeedMode "LIMITED";
		_grp setFormation "Column (compact)/File";
		_wpCount = 0;

		_patrolRadius = 100 + (100 * random 4);
		_center = getPos selectRandom buildings;
		
		//Determines clockwise or counterclockwise patrol
		if ((floor random 10) >= 5) then 
		{
			
			for [{_i=4}, {_i >= 1}, {_i = _i - 1}] do {
			
			_WPPos = _center getPos [_patrolRadius,((_i)*(360/4))];
			_wpCount = _wpCount + 1;
			_wp = _grp addWaypoint [_WPPos,_wpCount];
			_wp setWaypointCompletionRadius 20;
			if (_wpCount == 4) then { [_grp, 4] setWaypointType "CYCLE";};
			};
		}
	
		else 
	
		{
			for [{_i=1}, {_i <= 4}, {_i = _i + 1}] do {
			_WPPos = _center getPos [_patrolRadius,((_i)*(360/4))];
			_wpCount = _wpCount + 1;
			_wp = _grp addWaypoint [_WPPos,_wpCount];
			_wp setWaypointCompletionRadius 20;
			if (_wpCount == 4) then { [_grp, 4] setWaypointType "CYCLE";};
			};
		};
	
	};
	
	
	
};


fnc_spawnStalker = {

};



fnc_spawnSquads = {

	[] call fnc_spawnPatrol;
	//[] call fnc_spawnSentry;

};

fnc_cacheObj = {

	(cache select 0) allowDamage true;
	(cache select 0) setDamage 1;
	["cacheTask","SUCCEEDED", true] call BIS_fnc_taskSetState;
};


fnc_createCache = {
	_cacheLocation = getPosASL (nearestBuilding target);
	_cacheLocation = [(_cacheLocation select 0),(_cacheLocation select 1),(_cacheLocation select 2)+1];

	cache = [_cacheLocation,"O_supplyCrate_F"] call BIS_fnc_spawnObjects;
	(cache select 0) enableSimulationGlobal true;
	(cache select 0) allowDamage false;

	cacheDestroyed = createTrigger ["EmptyDetector",(getPos target),true];
	cacheDestroyed setTriggerActivation ["ANY","PRESENT",false];
	cacheDestroyed setTriggerStatements ["!(alive (nearestBuilding target))","[] call fnc_cacheObj;",""];

	
	[west,["cacheTask"],["Locate and destroy enemy weapons cache","Locate and destroy enemy weapons cache","Destroy Weapons Cache"],(getPos cityCenter),true,0,true,"destroy",true] call BIS_fnc_taskCreate;
	
};


spawnClear = createTrigger ["EmptyDetector",(getPos spawnPoint),true];
spawnClear setTriggerActivation ["EAST", "PRESENT", true];
spawnClear setTriggerArea [10,10,0,false];
spawnClear setTriggerTimeout [1,1,1,true];
spawnClear setTriggerStatements ["this","","[] call fnc_spawnSquads;"];


[] call fnc_spawnSquads;
[] call fnc_createCache;


//sleep 5;
[] spawn fnc_checkUnarmed;




