if (!isServer) exitWith {};

//RD_CivKilled = 0;
//RD_CivLimit = 4; //Define this as a constant someday

RD_fnc_civilianCooldown = {

	if (RD_CivKilled >= 1) then {
		
		RD_CivKilled = RD_CivKilled - 1;
		_string = "Civlian kill forgiven "  + str (RD_CivKilled) + "  of " + str (RD_CivLimit);
		[[west,"HQ"],_string] remoteExec ["sideChat",0];
		_string = nil;
	};
	
};


RD_fnc_checkCivLimit = {

	if (RD_CivKilled >= RD_CivLimit) then 
	{
		[[west,"HQ"],"Gentlemen you've let us down. You've killed too many civilians. Return to base, it's over."] remoteExec ["sideChat",0];
		
		sleep 3;
		
		"EveryoneLost" call BIS_fnc_endMissionServer;
	};
};

RD_fnc_unitKilled = {

	private _unit = _this select 0;
	private _killer = _this select 1;
	private _killer2 = _this select 2;

	
	if (((faction _unit isEqualTo "CIV_F") || (faction _unit isEqualTo "LOP_TAK_Civ"))  && ((side _killer isEqualTo west) || side _killer2 isEqualTo west))  then 
	{
		RD_CivKilled = RD_CivKilled + 1;
		
		private _string = (str (name _killer)) + " killed a civilian!! Mind your fire! " +  str (RD_CivKilled) + "  of " + str (RD_CivLimit);
		
		[[west,"HQ"],_string] remoteExec ["sideChat",0];
		
		_string = nil;
		
		[] spawn RD_fnc_checkCivLimit;
	};
	
	//_test = "Faction is " + str (faction _unit);
	//[[west,"HQ"],_test] remoteExec ["sideChat",0];
	
	_unit = nil;
	_killer = nil;
	_killer2 = nil;
	
};

RD_fnc_civEvacuate = {
	
	_location = _this select 0; //This is a marker from the array of locations
	
	_civs = [];
	
	{
		if ((side _x) == civilian) then
		{
			
			if ((getPos (leader _x)) inArea _location) then 
			{
				_civs pushback _x;
			};
		};
	}forEach allGroups;
		
	[_civs] call RD_fnc_civWaypoint;
	
	

};

RD_fnc_civWaypoint = {
	
	_civs = _this select 0;
	{
		
		_fleeChance = floor random 100;
		
		if (_fleeChance <= 30) then 
		{
		
			while {(count (waypoints _x)) > 0} do
			{
				deleteWaypoint ((waypoints _x) select 0);
			};
			
			_x addWaypoint [(getMarkerPos "civ_Safety_2"),10,1];
			_x setCurrentWaypoint [_x,1];
			[[west,"HQ"],"Looks like some civilians got the message."] remoteExec ["sideChat",0];
		};
		
	}forEach _civs;
	
	_fleeChance = nil;
	_civs = nil;
	
};


RD_fnc_leafletCheck = {
	
	_unit = _this select 0;
	_weapon = _this select 1;
	_realeasePoint = getPos _unit;
	//_target = getMarkerPos "target";
	
	{
		if (((getMarkerPos _x)  distance2D _unit) < 1000) then 
		{
			
			if (_weapon isEqualTo "FIR_PDU5B") then 
			{
				[[west,"HQ"],"Good Drop Sir, let's see if those people get to safety"] remoteExec ["sideChat",0];
				[_x] spawn RD_fnc_civEvacuate;
			};
		}
		/*
		else
		{
			
			if (_weapon isEqualTo "FIR_PDU5B") then 
			{
				[[west,"HQ"],"Too far off. Try again."] remoteExec ["sideChat",0];
			};
		};
		*/
	}forEach civLocations;
	
	_unit = nil;
	_weapon = nil;
	_realeasePoint = nil;
};

//Add eventhandler to aircraft. This  moniters for dropping of leaflets.
//There might be a better way to monitor this with a trigger and grabbing the vehicle from there then simply place triggers wherever we want leaflets capability
//For now leaflet capability is only available at hardcoded target area

//Whiplash20 is a testing unit make sure to delete
(Whiplash20) addEventHandler ["Fired",{[_this select 0, _this select 1] call RD_fnc_leafletCheck; }];

(Whiplash0) addEventHandler ["Fired",{[_this select 0, _this select 1] call RD_fnc_leafletCheck; }];
(Gunslinger0) addEventHandler ["Fired",{[_this select 0, _this select 1] call RD_fnc_leafletCheck; }];
(Reaper0) addEventHandler ["Fired",{[_this select 0, _this select 1] call RD_fnc_leafletCheck; }];


RD_UnitKilled = addMissionEventHandler ["EntityKilled", {[_this select 0,_this select 1,_this select 2] call RD_fnc_unitKilled;}];

coolDownOff = true;
RD_CivCooldown = createTrigger ["EmptyDetector",(getMarkerPos "test"),true];
RD_CivCooldown setTriggerActivation ["ANY","PRESENT",true];
RD_CivCooldown setTriggerTimeout [600,900,1200,false];
RD_CivCooldown setTriggerStatements ["true && coolDownOff", "[] call RD_fnc_civilianCooldown; coolDownOff = false","coolDownOff = true;"];


