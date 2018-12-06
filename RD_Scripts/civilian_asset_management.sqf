if (!isServer) exitWith {};

RD_CivKilled = 0;
RD_CivLimit = 4; //Define this as a constant someday

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

	if (((faction _unit isEqualTo "CIV_F") || (faction _unit isEqualTo "AFGCIV"))  && ((side _killer isEqualTo west) || side _killer2 isEqualTo west))  then 
	{
		RD_CivKilled = RD_CivKilled + 1;
		
		private _string = (str (name _killer)) + " killed a civilian!! Mind your fire!";
		
		[[west,"HQ"],_string] remoteExec ["sideChat",0];
		
		_string = nil;
		
		[] spawn RD_fnc_checkCivLimit;
	};
	
	_unit = nil;
	_killer = nil;
	
};

RD_UnitKilled = addMissionEventHandler ["EntityKilled", {[_this select 0,_this select 1,_this select 2] call RD_fnc_unitKilled;}];