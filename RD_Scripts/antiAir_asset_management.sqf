RD_fnc_buildObjectArray = {
	
	_Names = _this select 0;
	_List = [];
	
	_checkNum = 1;
	_checkString = _Names + str _checkNum;
	_checkObj = missionNameSpace getVariable [_checkString, objNull];
		
	while {!(_checkObj isEqualto objNull)} do
	{
		_List pushBack  _checkObj;
		_checkNum = _checkNum + 1;
		_checkString = _Names + str _checkNum;
		_checkObj = missionNameSpace getVariable [_checkString, objNull];
	};
			
	_Names = nil;
	_checkNum = nil;
	_checkString = nil;
	_checkObj = nil;
	
	_List;
	
};

RD_fnc_chooseGun = {

	_gunList = _this select 0;
	
	_gunChance = floor random 100;
	
	if (_gunChance <= 33) then 
	{
		
		_gunList deleteAt (floor random (count _gunList));
	
	};
	
	{
		{(vehicle _x) deleteVehicleCrew _x;}forEach crew _x;
		deleteVehicle _x;
	
	}forEach _gunList;

	_gunList = nil;
	_gunChance = nil;
	
};

RD_fnc_spawnDefensGroup = {
	
	_location = _this select 0;
	_tempArray = [];
	_groupSize = 2 + (floor random 4);
	for [{_i=0}, {_i <= _groupSize}, {_i = _i + 1}] do 
	{
		
		_tempArray pushback (selectRandom ME_Militia_Inf);
		
	};
	
	_location = _location findEmptyPosition [5,15];
	
	_grp = [_location, east, _tempArray] call BIS_fnc_spawnGroup;

	
	_grp;
	
};


RD_fnc_defendRadar = {

	_radar = _this select 0;
	
	_grp = [(getPos _radar)] call RD_fnc_spawnDefensGroup;
	
	[_grp, (getPos _radar),75] call BIS_fnc_taskPatrol;
	

};

RD_fnc_rotateRadar = {
	
	_radar = _this select 0;

	while {alive _radar} do {
		{
			_radar lookAt (_radar getRelPos [100, _x]);
			sleep 2.45;
		} forEach [120, 240, 0];
	};
};

RD_fnc_chooseRadar = {

	_radarList = _this select 0;
	
	//_radarList deleteAt (floor random (count _radarList));
	_radarChoice = selectRandom _radarList;
	_radarChoice addMPEventHandler ["mpkilled", {["AA_Objective","SUCCEEDED", true] call BIS_fnc_taskSetState;}];
	
	
	
	[_radarChoice] call RD_fnc_defendRadar;
	[_radarChoice] spawn RD_fnc_rotateRadar;
	
	_radarList deleteAt ( _radarList find _radarChoice);
	
	{
		{(vehicle _x) deleteVehicleCrew _x;}forEach crew _x;
		deleteVehicle _x;
	
	}forEach _radarList;
	
	[west,["AA_Objective"],["Locate and Destroy Radar","Locate and Destroy Radar","Destroy Radar"],(getMarkerPos "AA_obj"),true,0,true,"destroy",true] call BIS_fnc_taskCreate;
		

};

RD_fnc_chooseSam = {

	_samList = _this select 0;
	_numberSams = _this select 1;
	
	if (_numberSams > (count _samList)) then {_numberSams = count _samList;};

	for [{_b=1}, {_b <= _numberSams}, {_b = _b + 1}] do 
	{
		_SamChoice = selectRandom _samList;
		
		_grp = [(getPos _samChoice)] call RD_fnc_spawnDefensGroup;
		
		[_grp, (getPos _samChoice),75] call BIS_fnc_taskPatrol;
		
		_samList deleteAt (_samList find _samChoice);
				
	};
	
	{
		{(vehicle _x) deleteVehicleCrew _x;}forEach crew _x;
		deleteVehicle _x;
	
	}forEach _samList;
	
};
	







_gunList = ["AA_gun_"] call RD_fnc_buildObjectArray;
_radarList = ["AA_radar_"] call RD_fnc_buildObjectArray;
_samList = ["AA_Sam_"] call RD_fnc_buildObjectArray;


[_gunList] call RD_fnc_chooseGun;
[_radarList] spawn RD_fnc_chooseRadar;
[_samList, 3] spawn RD_fnc_chooseSam;

















