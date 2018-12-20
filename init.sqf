fn_ftravel = compile preprocessFile "scripts\fn_ftravel.sqf";

//Setting Up Parameters
_Ocast 	= 0;
_Rain 	= 0;
_Fog 	= 0;
_TOD 	= 0;
_weather= 0;
_base = [];
_baseName = "";


//Grabbing parameter values
_TOD = (paramsarray select 0);
_timeMult = (paramsarray select 1);	
_weather = (paramsarray select 2);
_maxView = (paramsarray select 3);
_fatigue = (paramsarray select 4);

//_locationParam = (paramsarray select 5);

//if (_TOD == 24) then {_TOD = (floor random 23) +1};			//If random is selected this chooses a random value
//if (_weather == 5) then {_weather = (floor random 4) + 1};  //If random is selected this chooses a random value

//Setting new Time of Day
skipTime (((_TOD) - daytime + 24) % 24);

setTimeMultiplier _timeMult;

setViewDistance _maxView;
setObjectViewDistance _maxView;

	
//Dealing with weather bullshit GOD DAMN fog
sleep 1;
0 setFog [0,0,0];
sleep 1;



switch (_weather) do {
	case 1: {skipTime -24; 86400 setOvercast 0;skipTime 24};
	case 2: {skipTime -24; 86400 setOvercast 1; skipTime 24};
	case 3: {skipTime -24; 86400 setOvercast .75;skipTime 24};
	case 4; {0 setFog 1};

};
if (_weather == 1) then {0 setFog [0,0,0]}; //Attemping to fix the damn fog





//MISSION SPECIFIC STUFF
//Unflip vehicle stuff
if (!isDedicated) then {
 waitUntil {!isNull player && {time > 0}};
player addAction [
	"Flip Vehicle", 
	"FlipAction.sqf", 
	[], 
	0, 
	false, 
	true, 
	"", 
	"_this == (vehicle _target) && {(count nearestObjects [_target, ['landVehicle'], 5]) > 0 && {(vectorUp cursorTarget) select 2 < 0}}"
];
Player AddEventHandler ["Respawn", {
	(_this select 0) addAction [
		"Flip Vehicle", 
		"FlipAction.sqf", 
		[], 
		0, 
		false, 
		true, 
		"", 
		"_this == (vehicle _target) && {(count nearestObjects [_target, ['landVehicle'], 5]) > 0 && {(vectorUp cursorTarget) select 2 < 0}}"
	];
}];
};

