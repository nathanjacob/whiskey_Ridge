//_trigger = _this select 0;
if (!isServer) exitWith {};

maxSquads = 3;
squadNum = 1;

patrolSquadMax = 2;
patrolCount = 1;

stalkerSquadMax = 2;
stalkerCount = 1;


patrolEndpoint = [];
_rallyPosition = [];

buildings = [];

armed = createGroup east;
armed deleteGroupWhenEmpty true;



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
			
			_tempArray pushback (selectRandom ME_Militia_Inf);
			
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


fnc_spawnStalker = {

};



fnc_spawnSquads = {

	[] call fnc_spawnPatrol;
	
};


spawnClear = createTrigger ["EmptyDetector",(getPos spawnPoint),true];
spawnClear setTriggerActivation ["EAST", "PRESENT", true];
spawnClear setTriggerArea [10,10,0,false];
spawnClear setTriggerTimeout [1,1,1,true];
spawnClear setTriggerStatements ["this","","[] call fnc_spawnSquads;"];


//Start generating patrols or stalkers
[] call fnc_spawnSquads;

//create cache location
target =  (selectRandom buildings);
while {(target isEqualto spawnPoint)} do {target = (selectRandom buildings);};
[] call fnc_createCache;

//Begin unarmed squad deployment
[] spawn fnc_checkUnarmed;




