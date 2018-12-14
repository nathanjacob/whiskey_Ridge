//_trigger = _this select 0;
if (!isServer) exitWith {};

maxSquads = 3; //Should be a constant
squadNum = 1;

patrolSquadMax = 2; //Should be a constant
patrolCount = 1;

stalkerSquadMax = 2; //Should be a constant
stalkerCount = 1;


patrolEndpoint = [];
_rallyPosition = [];

buildings = [];

armed = createGroup east;
armed deleteGroupWhenEmpty true;


//This creates the array of buildings to use a spawn positions
_checkNum = 1;
_checkString = "spawnBuilding_" + str _checkNum;
_checkObj = missionNameSpace getVariable [_checkString, objNull];
while {!(_checkObj isEqualto objNull)} do
{
	buildings pushBack  _checkObj;
	_checkNum = _checkNum + 1;
	_checkString = "spawnBuilding_" + str _checkNum;
	_checkObj = missionNameSpace getVariable [_checkString, objNull];
};




//This creates the array of patrol end points for patrolling squads to go to
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

//Determine where squads will originate
spawnPoint = selectRandom buildings;

//create cache location
target =  selectRandom buildings;
//This loop ensures the spawn position would not be the same as the cache... boy would that be awkward.
while {(target isEqualto spawnPoint)} do {target = selectRandom buildings;};
[] call fnc_createCache;

//Create trigger that regulates spawn rate of patrol groups
spawnClear = createTrigger ["EmptyDetector",(getPos spawnPoint),true];
spawnClear setTriggerActivation ["EAST", "PRESENT", true];
spawnClear setTriggerArea [10,10,0,false];
spawnClear setTriggerTimeout [1,1,1,true];
spawnClear setTriggerStatements ["this","","[] call fnc_spawnSquads;"];







//Start generating patrols or stalkers
[] call fnc_spawnSquads;

//Begin unarmed squad deployment
[] spawn fnc_checkUnarmed;




